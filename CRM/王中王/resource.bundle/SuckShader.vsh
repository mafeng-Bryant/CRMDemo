// Vertex shader for "suck" effect
// Converted to GLSL from: http://www.aplweb.co.uk/blog/flash/gpu-suck-effect/

attribute vec4 a_position;
attribute vec2 a_texcoord;

varying vec2 v_texture_coordinate;

void main()
{
    gl_Position = a_position;
    
    v_texture_coordinate = a_texcoord;
}
