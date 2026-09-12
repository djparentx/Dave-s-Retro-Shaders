#version 110

/* 
crt-consumer by DariusG 2022-2023
Trimmed for R36S/RK3326: removed unused Color Temp (WP), Noise, Contrast matrix,
Slot Mask, and all mask() branches except Shadowmask=0 (hardcoded, no longer a runtime param).

This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your option)
any later version.
*/

// Parameter lines go here:
#pragma parameter bogus0 " [ CRT-CONSUMER ] " 0.0 0.0 0.0 0.0
#pragma parameter sharpx "Sharpness Horizontal" 2.0 1.0 5.0 0.1
#pragma parameter sharpy "Sharpness Vertical" 3.0 1.0 5.0 0.1
#pragma parameter bogus_geo " [ GEOMETRY ] " 0.0 0.0 0.0 0.0
#pragma parameter warpx "Curvature X" 0.03 0.0 0.12 0.01
#pragma parameter warpy "Curvature Y" 0.04 0.0 0.12 0.01
#pragma parameter corner "Corner size" 0.03 0.0 0.10 0.01
#pragma parameter smoothness "Border Smoothness" 600.0 25.0 600.0 5.0
#pragma parameter vignette "Vignette On/Off" 1.0 0.0 1.0 1.0
#pragma parameter bogus_scan " [ SCANLINES/MASKS ] " 0.0 0.0 0.0 0.0
#pragma parameter scanlow "Beam low" 6.0 1.0 15.0 1.0
#pragma parameter scanhigh "Beam high" 8.0 1.0 15.0 1.0
#pragma parameter inter "Interlacing Toggle" 1.0 0.0 1.0 1.0
#pragma parameter scan_type "Scanline Type, pronounced/soft"  2.0 2.0 3.0 1.0 
#pragma parameter beamlow "Scanlines dark" 1.35 0.5 2.5 0.05 
#pragma parameter beamhigh "Scanlines bright" 0.9 0.5 2.5 0.05 
#pragma parameter masksize "Mask Size" 1.0 1.0 2.0 1.0
#pragma parameter MaskDark "Mask dark" 0.5 0.0 2.0 0.1
#pragma parameter MaskLight "Mask light" 1.5 0.0 2.0 0.1
#pragma parameter bogus_col " [ COLORS ] " 0.0 0.0 0.0 0.0
#pragma parameter GAMMA_OUT "Gamma Out" 2.2 0.0 4.0 0.05
#pragma parameter crt_lum "CRT Luminances On/Off" 1.0 0.0 1.0 1.0
#pragma parameter brightboost1 "Bright boost dark pixels" 1.3 0.0 3.0 0.05
#pragma parameter brightboost2 "Bright boost bright pixels" 1.05 0.0 3.0 0.05
#pragma parameter sat "Saturation" 1.0 0.0 2.0 0.05
#pragma parameter sawtooth "Sawtooth Effect" 1.0 0.0 1.0 1.0
#pragma parameter bleed "Color Bleed Effect" 1.0 0.0 1.0 1.0
#pragma parameter bl_size "Color Bleed Size, less is more" 1.5 0.1 4.0 0.05
#pragma parameter alloff "Switch off shader" 0.0 0.0 1.0 1.0
#define pi 6.28318

#if defined(VERTEX)

#if __VERSION__ >= 130
#define COMPAT_VARYING out
#define COMPAT_ATTRIBUTE in
#define COMPAT_TEXTURE texture
#else
#define COMPAT_VARYING varying 
#define COMPAT_ATTRIBUTE attribute 
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

COMPAT_ATTRIBUTE vec4 VertexCoord;
COMPAT_ATTRIBUTE vec4 COLOR;
COMPAT_ATTRIBUTE vec4 TexCoord;
COMPAT_VARYING vec2 TEX0;
COMPAT_VARYING vec2 scale;
COMPAT_VARYING vec2 maskpos;

vec4 _oPosition1; 
uniform mat4 MVPMatrix;
uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;

void main()
{
    gl_Position = MVPMatrix * VertexCoord;
    TEX0.xy = TexCoord.xy * 1.0001;
    scale = TextureSize.xy/InputSize.xy;
    maskpos = TEX0.xy*OutputSize.xy*scale;
}

#elif defined(FRAGMENT)

#if __VERSION__ >= 130
#define COMPAT_VARYING in
#define COMPAT_TEXTURE texture
out vec4 FragColor;
#else
#define COMPAT_VARYING varying
#define FragColor gl_FragColor
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;
uniform sampler2D Texture;
COMPAT_VARYING vec2 TEX0;
COMPAT_VARYING vec2 scale;
COMPAT_VARYING vec2 maskpos;

// compatibility #defines
#define Source Texture
#define vTexCoord TEX0.xy
#define iChannel0 Texture
#define iTime (float(FrameCount) / 2.0)
#define iTimer (float(FrameCount) / 60.0)
#define Timer (float(FrameCount) * 60.0)

#define SourceSize vec4(TextureSize, 1.0 / TextureSize) //either TextureSize or InputSize
#define OutputSize vec4(OutputSize, 1.0 / OutputSize)

#ifdef PARAMETER_UNIFORM
// All parameter floats need to have COMPAT_PRECISION in front of them

uniform COMPAT_PRECISION float warpx;
uniform COMPAT_PRECISION float warpy;
uniform COMPAT_PRECISION float corner;
uniform COMPAT_PRECISION float smoothness;
uniform COMPAT_PRECISION float scanlow;
uniform COMPAT_PRECISION float scanhigh;
uniform COMPAT_PRECISION float beamlow;
uniform COMPAT_PRECISION float beamhigh;
uniform COMPAT_PRECISION float scan_type;
uniform COMPAT_PRECISION float brightboost1;
uniform COMPAT_PRECISION float brightboost2;
uniform COMPAT_PRECISION float masksize;
uniform COMPAT_PRECISION float MaskDark;
uniform COMPAT_PRECISION float MaskLight;
uniform COMPAT_PRECISION float GAMMA_OUT;
uniform COMPAT_PRECISION float sat;
uniform COMPAT_PRECISION float inter;
uniform COMPAT_PRECISION float vignette;
uniform COMPAT_PRECISION float alloff;
uniform COMPAT_PRECISION float sawtooth;
uniform COMPAT_PRECISION float bleed;
uniform COMPAT_PRECISION float bl_size;
uniform COMPAT_PRECISION float sharpx;
uniform COMPAT_PRECISION float sharpy;
uniform COMPAT_PRECISION float crt_lum;

#else
  
#define warpx  0.0    
#define warpy  0.0    
#define corner 0.0    
#define smoothness 300.0    
#define scanlow  6.0    
#define scanhigh  8.0    
#define beamlow  1.35    
#define beamhigh  1.05 
#define scan_type 2.0   
#define brightboost1 1.45    
#define brightboost2 1.1    
#define masksize 1.0    
#define MaskDark 0.5  
#define MaskLight 1.5 
#define GAMMA_OUT 2.2
#define sat 1.0 
#define inter 1.0
#define vignette 1.0
#define alloff 0.0
#define sawtooth 0.0
#define bleed 0.0
#define bl_size 1.0
#define sharpx 2.0
#define sharpy 3.0
#define crt_lum 1.0 

#endif


vec2 Warp(vec2 pos)
{
    pos  = pos*2.0-1.0;    
    pos *= vec2(1.0 + (pos.y*pos.y)*warpx, 1.0 + (pos.x*pos.x)*warpy);
    return pos*0.5 + 0.5;
} 


float sw (float y,float l, float x)
{
    float scan = mix(scanlow,scanhigh,y);
    float beam = mix(beamlow,beamhigh,l);
    float ex = y*(beam+x);
    return exp2(-scan*pow(ex,scan_type));
}

// Hardcoded to Shadowmask==0 path only (dead branches for other mask types removed)
vec3 mask(vec2 x,vec3 col,float l)
{
    x = floor(x/masksize);        
    float m =fract(x.x*0.4999);

    if (m<0.4999) return vec3(1.0,MaskDark,1.0);
    else return vec3(MaskDark,1.0,MaskDark);
}


vec3 saturation (vec3 Color, float l, vec3 lweight)
{
    float lum=l;
    
    if (lum<0.5) lweight=(lweight*lweight) + (lweight*lweight);

    float luminance = dot(Color, lweight);
    vec3 greyScaleColor = vec3(luminance);

    vec3 res = vec3(mix(greyScaleColor, Color, sat));
    return res;
}


float corner0(vec2 coord)
{
                coord *= TextureSize / InputSize;
                coord = (coord - vec2(0.5)) * 1.0 + vec2(0.5);
                coord = min(coord, vec2(1.0)-coord) * vec2(1.0, InputSize.y/InputSize.x);
                vec2 cdist = vec2(corner);
                coord = (cdist - min(coord,cdist));
                float dist = sqrt(dot(coord,coord));
                return clamp((cdist.x-dist)*smoothness,0.0, 1.0);
}  

float RGB2Y(vec3 _rgb) {
    return dot(_rgb, vec3(0.29900, 0.58700, 0.11400));
}

float RGB2U(vec3 _rgb) {
   return dot(_rgb, vec3(-0.14713, -0.28886, 0.43600));
}

float RGB2V(vec3 _rgb) {
   return dot(_rgb, vec3(0.61500, -0.51499, -0.10001));
}



float YUV2R(vec3 _yuv) {
   return dot(_yuv, vec3(1, 0.00000, 1.13983));
}

float YUV2G(vec3 _yuv) {
   return dot(_yuv, vec3(1.0, -0.39465, -0.58060));
}

float YUV2B(vec3 _yuv) {
    return dot(_yuv, vec3(1.0, 2.03211, 0.00000));
}

vec3 YUV2RGB(vec3 _yuv) {
    vec3 _rgb;
    _rgb.r = YUV2R(_yuv);
    _rgb.g = YUV2G(_yuv);
    _rgb.b = YUV2B(_yuv);

   return _rgb;
}

void main()
{


 float a_kernel[5];
    a_kernel[0] = 2.0; 
    a_kernel[1] = 4.0; 
    a_kernel[2] = 1.0; 
    a_kernel[3] = 4.0; 
    a_kernel[4] = 2.0; 
    
	vec2 pos = Warp(vTexCoord.xy*scale)/scale;
    vec2 tex_size = SourceSize.xy;	
    
    if (inter < 0.5 && InputSize.y >400.0) tex_size*=0.5;
  vec2 ogl2pos = pos*TextureSize.xy;
  vec2 p = ogl2pos+0.5;
  vec2 i = floor(p);
  vec2 f = p - i;        // -0.5 to 0.5
       f.x = pow(f.x,sharpx);
       f.y = pow(f.y,sharpy);
       
       p = (i + f-0.5)*SourceSize.zw;
	vec2 pC4 = p;
	vec2 fp = fract(pos*tex_size.xy);
    
    if (inter >0.5 && InputSize.y >400.0) fp.y=1.0; 
    
    vec4 res = vec4(1.0);
    
    if (alloff == 1.0) {res= COMPAT_TEXTURE(Source,pC4); 
        res = pow(res,vec4(1.0/GAMMA_OUT));
}
        else
            {
	       vec3 sample2 = COMPAT_TEXTURE(Source,pC4).rgb;
	
	vec3 color = sample2;
   //sawtooth effect
float t = sin(float(FrameCount));  
if (sawtooth == 1.0){
    if( mod( floor(pC4.y*SourceSize.y*1.0), 2.0 ) == 0.0 ) {
        color += COMPAT_TEXTURE( Source, pC4 + vec2(SourceSize.z*0.2*t, 0.0) ).rgb;
    } else {
        color += COMPAT_TEXTURE( Source, pC4 - vec2(SourceSize.z*0.2*t, 0.0) ).rgb;
    }
    color /= 2.0;}
//end of sawtooth

//color bleeding
if (bleed == 1.0){
    vec3 yuv = vec3(0.0);
    float px = 0.0;
    for( int x = -2; x <= 2; x++ ) {
        px = float(x)/bl_size * SourceSize.z - SourceSize.w * 0.5;
        yuv.g += RGB2U( COMPAT_TEXTURE( Source, pC4 + vec2(px, 0.0)).rgb ) * a_kernel[x + 2];
        yuv.b += RGB2V( COMPAT_TEXTURE( Source, pC4 + vec2(px, 0.0)).rgb ) * a_kernel[x + 2];
    }
    
    yuv.r = RGB2Y(color.rgb);
    yuv.g /= 10.0;
    yuv.b /= 10.0;


    color.rgb = (color.rgb)*0.5 + (YUV2RGB(yuv) * 1.0)*0.5;

// fix for gles half screen turning black
color =clamp(color, 0.0,1.0);
//end of color bleeding
} 

    vec3 lumWeighting = vec3(0.22,0.7,0.08);
	float lum=dot(color,lumWeighting);
	
    float f = fp.y;
    float x=0.0;

 if ( vignette == 1.0)   
  {  // vignette  
  x = (vTexCoord.x*SourceSize.x/InputSize.x-0.5);  // range -0.5 to 0.5, 0.0 being center of screen
  x = x*x*1.5;    // curved response: higher values (more far from center) get higher results.
}
    color = color*sw(f,lum,x) + color*sw(1.0-f,lum,x);
    
    color*=mix(mask(maskpos.xy*1.0001,color,lum), vec3(1.0),lum*0.9);
    
    color*=mix(brightboost1, brightboost2, lum);    
if (crt_lum == 1.0){

    // 0.29/0.24, 0.6/0.69, 0.11/0.07
     color *= vec3(1.208,0.8695,1.5714); 
   }
    color=pow(color,vec3(1.0/GAMMA_OUT));

    if (sat != 1.0) color = saturation(color, lum, lumWeighting);
    
    if (corner!=0.0) color *= corner0(pC4);
	
	res = vec4(color,1.0);
    if (inter >0.5 && InputSize.y >400.0 && fract(iTime)<0.5) res=res*0.95; else res;
}
#if defined GL_ES
    // hacky clamp fix for GLES
    vec2 bordertest = (pC4);
    if ( bordertest.x > 0.0001 && bordertest.x < 0.9999 && bordertest.y > 0.0001 && bordertest.y < 0.9999)
        res = res;
    else
        res = vec4(0.0);
#endif

    FragColor = res;
} 
#endif
