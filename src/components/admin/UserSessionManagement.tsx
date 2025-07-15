import React from 'react';
import { SimplifiedUserSessionManagement } from './SimplifiedUserSessionManagement';

interface UserSessionManagementProps {
  userId: string;
  userName?: string;
}

// Componente de compatibilidade para não quebrar imports existentes
export const UserSessionManagement: React.FC<UserSessionManagementProps> = ({ 
  userId, 
  userName = 'Usuário' 
}) => {
  return <SimplifiedUserSessionManagement userId={userId} userName={userName} />;
};

export default UserSessionManagement;