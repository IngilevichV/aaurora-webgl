import { createShader, createProgram } from './glUtils';
import vertexShader from './vertex.glsl';
import fragmentShader from './fragment.glsl';

export const draw = ({ canvas }) => {
  if (!canvas) return null;
  const gl = canvas.getContext('webgl2');
  gl.viewport(0, 0, gl.canvas.width, gl.canvas.height);

  const vertexShaderNode = createShader(gl, gl.VERTEX_SHADER, vertexShader);
  const fragmentShaderNode = createShader(
    gl,

    gl.FRAGMENT_SHADER,
    fragmentShader
  );
  const program = createProgram(gl, vertexShaderNode, fragmentShaderNode);
  gl.useProgram(program);

  const dataBuffer = new Float32Array([
    -1, -1, 1, -1, -1, 1, 1, -1, 1, 1, -1, 1,
  ]);

  const buffer = gl.createBuffer();
  gl.bindBuffer(gl.ARRAY_BUFFER, buffer);
  gl.bufferData(gl.ARRAY_BUFFER, dataBuffer, gl.STATIC_DRAW);

  const resolutionLocation = gl.getUniformLocation(program, 'u_resolution');
  gl.uniform2f(resolutionLocation, canvas.width, canvas.height);

  const positionLocation = gl.getAttribLocation(program, 'a_position');
  gl.enableVertexAttribArray(positionLocation);

  gl.vertexAttribPointer(positionLocation, 2, gl.FLOAT, false, 0, 0);

  gl.drawArrays(gl.TRIANGLES, 0, 6);
};
