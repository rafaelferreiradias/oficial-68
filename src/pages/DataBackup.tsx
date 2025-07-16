import React from 'react';
import { DataBackupPanel } from '@/components/admin/DataBackupPanel';

export const DataBackup = () => {
  return (
    <div className="container mx-auto p-6">
      <div className="mb-8">
        <h1 className="text-3xl font-bold mb-2">Backup de Dados</h1>
        <p className="text-muted-foreground">
          Faça backup completo dos seus dados antes da migração de conta
        </p>
      </div>
      
      <DataBackupPanel />
    </div>
  );
};