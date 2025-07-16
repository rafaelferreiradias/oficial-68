import React from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Progress } from '@/components/ui/progress';
import { Download, Database, Github, AlertTriangle, CheckCircle } from 'lucide-react';
import { useDataBackup } from '@/hooks/useDataBackup';
import { Alert, AlertDescription } from '@/components/ui/alert';

export const DataBackupPanel = () => {
  const { isBackingUp, backupProgress, createFullBackup } = useDataBackup();

  const handleGithubBackup = () => {
    window.open('https://github.com/settings/repositories', '_blank');
  };

  return (
    <div className="space-y-6">
      <Alert>
        <AlertTriangle className="h-4 w-4" />
        <AlertDescription>
          <strong>IMPORTANTE:</strong> Você está prestes a migrar de conta. Faça backup completo de todos os dados antes de prosseguir.
        </AlertDescription>
      </Alert>

      <div className="grid gap-6 md:grid-cols-2">
        {/* Backup do Supabase */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Database className="h-5 w-5" />
              Backup dos Dados (Supabase)
            </CardTitle>
            <CardDescription>
              Exporta todos os dados do usuário do banco de dados para arquivos JSON
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            {isBackingUp && (
              <div className="space-y-2">
                <div className="flex justify-between text-sm">
                  <span>Progresso do backup</span>
                  <span>{Math.round(backupProgress)}%</span>
                </div>
                <Progress value={backupProgress} className="w-full" />
              </div>
            )}
            
            <Button 
              onClick={createFullBackup} 
              disabled={isBackingUp}
              className="w-full"
            >
              <Download className="h-4 w-4 mr-2" />
              {isBackingUp ? 'Fazendo Backup...' : 'Baixar Backup Completo'}
            </Button>

            <div className="text-sm text-muted-foreground space-y-1">
              <p><strong>Dados incluídos:</strong></p>
              <ul className="list-disc list-inside space-y-1 ml-2">
                <li>Perfil do usuário</li>
                <li>Dados físicos e de saúde</li>
                <li>Histórico de medidas e pesagens</li>
                <li>Missões e pontuações</li>
                <li>Perfil comportamental</li>
                <li>Avatars e arquivos (storage)</li>
              </ul>
            </div>
          </CardContent>
        </Card>

        {/* Backup do GitHub */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Github className="h-5 w-5" />
              Backup do Código (GitHub)
            </CardTitle>
            <CardDescription>
              Certifique-se de que o código está sincronizado e faça um backup do repositório
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="text-sm text-muted-foreground space-y-2">
              <div className="flex items-center gap-2">
                <CheckCircle className="h-4 w-4 text-green-500" />
                <span>Código já está no GitHub</span>
              </div>
              <p>Para fazer backup adicional:</p>
              <ul className="list-disc list-inside space-y-1 ml-2">
                <li>Clone o repositório localmente</li>
                <li>Faça download do repositório como ZIP</li>
                <li>Exporte as configurações do projeto</li>
              </ul>
            </div>

            <Button 
              onClick={handleGithubBackup}
              variant="outline"
              className="w-full"
            >
              <Github className="h-4 w-4 mr-2" />
              Abrir GitHub
            </Button>
          </CardContent>
        </Card>
      </div>

      {/* Instruções de Migração */}
      <Card>
        <CardHeader>
          <CardTitle>Instruções para Migração</CardTitle>
          <CardDescription>
            Siga estes passos para migrar para a nova conta
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-3 text-sm">
            <div className="border-l-4 border-blue-500 pl-4">
              <h4 className="font-semibold">1. Backup Completo</h4>
              <p>Baixe todos os dados usando o botão acima</p>
            </div>
            
            <div className="border-l-4 border-green-500 pl-4">
              <h4 className="font-semibold">2. Novo Projeto Supabase</h4>
              <p>Crie um novo projeto no Supabase com a nova conta</p>
            </div>
            
            <div className="border-l-4 border-yellow-500 pl-4">
              <h4 className="font-semibold">3. Migração das Tabelas</h4>
              <p>Execute as migrations no novo projeto para recriar as tabelas</p>
            </div>
            
            <div className="border-l-4 border-purple-500 pl-4">
              <h4 className="font-semibold">4. Restauração dos Dados</h4>
              <p>Importe os dados do backup para o novo projeto</p>
            </div>
            
            <div className="border-l-4 border-red-500 pl-4">
              <h4 className="font-semibold">5. Atualização das Configurações</h4>
              <p>Atualize as chaves de API no projeto Lovable</p>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
};