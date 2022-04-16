import React, { useRef, useEffect } from 'react';
import { draw } from './draw';

export const Scene = ({ width, height }: { width: number; height: number }) => {
  const ref = useRef(null);
  useEffect(() => {
    if (ref?.current) {
      draw({ canvas: ref.current });
    }
  }, [width, height]);

  return <canvas ref={ref} id="canvas" width={width} height={height}></canvas>;
};
