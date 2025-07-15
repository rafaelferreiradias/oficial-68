import React, { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { useToast } from '@/hooks/use-toast';
import { DisabledAdminFeature } from './DisabledAdminFeature';
import { Calendar, Clock, FileText, Users } from 'lucide-react';

interface SimplifiedUserSessionManagementProps {
  userId: string;
  userName: string;
}

export const SimplifiedUserSessionManagement: React.FC<SimplifiedUserSessionManagementProps> = ({
  userId,
  userName
}) => {
  const [sessionForm, setSessionForm] = useState({
    title: '',
    description: '',
    content: '',
    is_public: false
  });
  const { toast } = useToast();

  const handleCreateSession = () => {
    console.log('Criando sessão para usuário:', userId, sessionForm);
    
    toast({
      title: "Funcionalidade em desenvolvimento",
      description: "Sistema de sessões será implementado quando a tabela 'sessions' for criada."
    });

    // Reset form
    setSessionForm({
      title: '',
      description: '',
      content: '',
      is_public: false
    });
  };

  return (
    <div className="space-y-6">
      {/* Header */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Users className="h-5 w-5" />
            Gerenciamento de Sessões - {userName}
          </CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-muted-foreground">
            Sistema de sessões personalizadas para o usuário selecionado.
          </p>
        </CardContent>
      </Card>

      {/* Nova Sessão */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <FileText className="h-5 w-5" />
            Criar Nova Sessão
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="text-sm font-medium">Título da Sessão</label>
              <Input
                placeholder="Ex: Sessão de Mindfulness"
                value={sessionForm.title}
                onChange={(e) => setSessionForm(prev => ({ ...prev, title: e.target.value }))}
              />
            </div>
            <div>
              <label className="text-sm font-medium">Tipo</label>
              <select 
                className="w-full p-2 border rounded-md"
                value={sessionForm.is_public ? 'public' : 'private'}
                onChange={(e) => setSessionForm(prev => ({ ...prev, is_public: e.target.value === 'public' }))}
              >
                <option value="private">Sessão Privada</option>
                <option value="public">Sessão Pública</option>
              </select>
            </div>
          </div>
          
          <div>
            <label className="text-sm font-medium">Descrição</label>
            <Input
              placeholder="Breve descrição da sessão"
              value={sessionForm.description}
              onChange={(e) => setSessionForm(prev => ({ ...prev, description: e.target.value }))}
            />
          </div>
          
          <div>
            <label className="text-sm font-medium">Conteúdo da Sessão</label>
            <Textarea
              placeholder="Detalhe o conteúdo e atividades da sessão..."
              value={sessionForm.content}
              onChange={(e) => setSessionForm(prev => ({ ...prev, content: e.target.value }))}
              rows={6}
            />
          </div>
          
          <Button 
            onClick={handleCreateSession}
            disabled={!sessionForm.title.trim()}
            className="w-full"
          >
            Criar Sessão (Em Desenvolvimento)
          </Button>
        </CardContent>
      </Card>

      {/* Lista de Sessões */}
      <DisabledAdminFeature
        title="Histórico de Sessões"
        description="Lista de todas as sessões atribuídas a este usuário com status e resultados."
      />
    </div>
  );
};

export default SimplifiedUserSessionManagement;