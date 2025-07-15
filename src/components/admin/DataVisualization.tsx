import React from 'react';
import { SimplifiedDataVisualization } from './SimplifiedDataVisualization';

// Componente de compatibilidade para não quebrar imports existentes
export const DataVisualization: React.FC = () => {
  return <SimplifiedDataVisualization />;
};

export default DataVisualization;