precision mediump float;
varying vec2 resolution;

// mat2 mm2(in float a){
//     float c = cos(a);
//     float s = sin(a);
//     return mat2(c,s,-s,c);
// }
mat2 m2 = mat2(0.9, 1.2,2.9, 1.9);
float tri(in float x){
    return clamp(abs(fract(x)-0.5),0.001,0.5);
}
vec2 tri2(in vec2 p){
    return vec2(tri(p.x)+tri(p.y),tri(p.y+tri(p.x)));
}


float hash21(in vec2 n){ return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453); }

float triNoise2d(in vec2 p, float spd)
{
    float z=1.8;
    float z2=2.5;
	float rz = 0.;
    // p *= mm2(p.x*0.06);
    vec2 bp = p;
	for (float i=0.; i<5.; i++ )
	{
        vec2 dg = tri2(bp*1.85)*.75;
        // dg *= mm2(spd);
        p -= dg/z2;

        bp *= 1.3;
        z2 *= .45;
        z *= .42;
		p *= 1.21 + (rz-1.0)*.02;
        
        rz += tri(p.x+tri(p.y))*z;
        p*= -m2;
	}
    return clamp(1./pow(rz*29., 1.3),0.,.55);
}


vec3 stars(in vec3 p)
{
    vec3 c = vec3(0.);
    float res = resolution.x*0.1;

    for (float i=0.;i<4.;i++)
    {
        vec3 q = fract(p*(.15*res));
        vec3 id = floor(p*(.15*res));
        vec2 rn = vec2(10.01, 10.000003);
        float c2 = smoothstep(10.,.6,length(q));
        c2 *= step(rn.x,.0005+i*i*0.001);
        c += c2*(mix(vec3(1.0,0.49,0.1),vec3(0.75,0.9,1.),rn.y)*0.1+0.9);
        p *= 1.3;
    }
    return c*c*0.8;
}

vec3 bg(in vec3 rd)
{
    float sd = dot(normalize(vec3(-0.5, -0.6, 0.9)), rd)*0.5+0.5;
    sd = pow(sd, 5.);
    vec3 col = mix(vec3(0.05,0.1,0.2), vec3(0.1,0.05,0.2), sd);
    return col*.63;
}

uniform float peak;

   vec4 aurora(vec3 ro, vec3 rd)
    {
        vec4 col = vec4(0);
        vec4 avgCol = vec4(0);
        
        for(float i=0.;i<100.;i++)
        {
            float of = 0.006*hash21(gl_FragCoord.xy)*smoothstep(0.,15., i);
            float pt = ((.7+pow(i,1.4)*.002)-ro.y)/(rd.y*2.+0.4);
            pt -= of;
            vec3 bpos = ro + pt*rd;
            vec2 p = bpos.zx;
            float rzt = triNoise2d(p, 0.06);
            vec4 col2 = vec4(0,0,0, rzt);
            col2.rgb = (sin(1.-vec3(2.15,-.5, 1.2)+i*0.043)*0.5+0.5)*rzt;
            avgCol =  mix(avgCol, col2, .5);
            col += avgCol*exp2(-i*0.065 - 2.5)*smoothstep(0.,5., i);
            
        }
        
        col *= (clamp(rd.y*15.+.4,0.,1.));
        
        // return col*1.8;
        //  return smoothstep(0.,1.1,pow(col,vec4(1.))*1.5);
        return pow(col,vec4(1.))*2.;
        
    }

void main(  )
{
    // gl_FragColor = vec4(1.0, 0.5, 0.0, 1.0);
    // return;

    vec2 scaleFactor = gl_FragCoord.xy / resolution.xy;
    vec2 p = scaleFactor - 0.5; // offset by half of the canvas
    p.x*=resolution.x/resolution.y;

    vec3 ro = vec3(0,0,-8.7);
    vec3 rd = normalize(vec3(p,1.3));
    // vec2 mo = vec2(-1,1);
    // mo.x *= resolution.x/resolution.y;
    // rd.yz *= mm2(mo.y);
    // rd.xz *= mm2(mo.x + sin(1.*0.05)*0.0);

    vec3 col = vec3(0.);
    vec3 brd = rd;
    float fade = smoothstep(0.,0.01,abs(brd.y))*0.1+0.9;

    col = bg(rd)*fade;

    if (rd.y > 0.){
        vec4 aur = smoothstep(-0.01,1.5*pow(2.0, -peak*.5),aurora(ro,rd))*fade;
        // col += stars(rd);
        col = col*(1.-aur.a) + aur.rgb;
    }
    else //Reflections
    {
        rd.y = abs(rd.y);
        col = bg(rd)*fade*0.6;
        vec4 aur = smoothstep(0.0,4.5,aurora(ro,rd));
        // col += stars(rd)*0.1; 
        col = col*(1.-aur.a) + aur.rgb;
        vec3 pos = ro + ((0.5-ro.y)/rd.y)*rd;
        col += mix(vec3(0.2,0.25,0.5)*0.08,vec3(0.3,0.3,0.5)*0.7, 0.);
    }

    gl_FragColor = vec4(col, 1.);
}



//   void main() {
//     vec4 color0 = vec4(0.0, 0.0, 0.0, 0.0);

//     float x = gl_FragCoord.x;
//     float y = resolution[1] - gl_FragCoord.y;

//     float dx = center[0] - x;
//     float dy = center[1] - y;
//     float distance = sqrt(dx*dx + dy*dy);

//     if ( distance < radius )
//       gl_FragColor = vec4(1.0, 0.5, 0.0, 1.0);
//     else 
//       gl_FragColor = color0;


//   }