uniform vec2 u_resolution;
attribute vec2 a_position;
varying vec2 resolution;

void main() {
  gl_Position = vec4(a_position, 0, 1);
  resolution = u_resolution;
}