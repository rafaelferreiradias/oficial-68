import React from 'react';
import { DisabledAdminFeature } from './DisabledAdminFeature';

interface WeightGoalsManagerProps {
  selectedUser?: any;
  currentWeight?: number;
}

export const WeightGoalsManager: React.FC<WeightGoalsManagerProps> = () => {
  return (
    <DisabledAdminFeature
      title="Gerenciador de Metas de Peso"
      description="Sistema de definição e acompanhamento de metas de peso personalizadas para cada usuário."
    />
  );
};

export default WeightGoalsManager;