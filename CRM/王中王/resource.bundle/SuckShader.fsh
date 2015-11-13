// Fragment shader for "suck" effect
// Converted to GLSL from: http://www.aplweb.co.uk/blog/flash/gpu-suck-effect/

varying mediump vec2 v_texture_coordinate; 

uniform sampler2D u_texture;
uniform mediump float u_time;
uniform mediump vec2 u_max_tex_coord;
uniform mediump vec2 u_target;

void main()
{
    mediump vec2 pos = v_texture_coordinate;
    
    pos = pos + (normalize(pos - u_target) * u_time);
    if (pos.x < 0.0 || pos.x > u_max_tex_coord.x || pos.y < 0.0 || pos.y > u_max_tex_coord.y) {
        mediump float l = 1.0;
        mediump float shaddow_l = 0.07;
        if (pos.y < 0.0) {
            if (pos.x < 0.0) {
                l = max(-pos.x, -pos.y);
            } else if (pos.x < u_max_tex_coord.x) {
                l = -pos.y;
            } else {
                l = max(pos.x - u_max_tex_coord.x, -pos.y);
            }
        } else if (pos.y < u_max_tex_coord.y) {
            if (pos.x < 0.0) {
                l = -pos.x;
            } else {
                l = pos.x - u_max_tex_coord.x; 
            }
        } else {
            if (pos.x < 0.0) {
                l = max(-pos.x, pos.y - u_max_tex_coord.y);
            } else if (pos.x < u_max_tex_coord.x) {
                l = pos.y - u_max_tex_coord.y;
            } else {
                l = max(pos.x - u_max_tex_coord.x, pos.y - u_max_tex_coord.y);
            }
        }
        if (l < shaddow_l) {
             gl_FragColor = vec4(0.0, 0.0, 0.0, 0.5 - l/shaddow_l);
        } else {
            discard;
        }
    } else {
        gl_FragColor = texture2D(u_texture, pos);
    }
}
