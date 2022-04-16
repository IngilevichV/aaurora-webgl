import React from 'react';
import { Scene } from './components/scene';
import { useWindowSize } from './hooks/useWindowSize';

const App: React.FC = () => {
  const { width, height } = useWindowSize();

  return <Scene width={width} height={height} />;
};

export default App;
