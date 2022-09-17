// this is the default code that you get when you reate a blank sahder. 
// nothing changed here.



//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;

    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Bending shader
//

varying vec2 v_vTexcoord;           // currently reading pixels original position (x, y)
varying vec4 v_vColour;             // currently reading pixels color (red, green, blue, alpha)


void main()
{
    vec2 coordinates;               // srotage for the new set of coordinates to repalce "v_vTexcoord"
    float pixelDistanceX;           // storage for the distance of current read pixel fron horizontal center
    float pixelDistanceY;           // storage for the distance of current read pixel fron vertical center
    float offset;                   // storage for the distance we'll displace the pixel on the screen.
    float dir;                      // direction in which we'll displace the pizels.
    
  pixelDistanceX = distance(v_vTexcoord.x, 0.5);    // calculate the current pixel distance from horizontal center 
  pixelDistanceY = distance(v_vTexcoord.y, 0.5);    // calculate the current pixel distance from vertical center 
  
  offset = (pixelDistanceX*0.2) * pixelDistanceY;   // offset will be the Y distance fro, vertical center multiplied by the 0.2 fractiopn of pixelDistanceX
  // basically the further the pixel is from horizontal cetner and vertical center, the further the disnplacement will be
  
    if (v_vTexcoord.y <= 0.5)  
        dir = 2.0;                  // if the pixel is before the half of the screen (0.5) then dispalce the pixel upwards (1)
    else
        dir = -2.0;                 // else displace downwards (-1)
    
    // finally prepare the new texture "vector 2" (vec2)
    coordinates = vec2(v_vTexcoord.x , v_vTexcoord.y + pixelDistanceX*(offset*3.0*dir));
    
    // output the resulting sehnanigans
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, coordinates);
}
       
