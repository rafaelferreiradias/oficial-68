import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/hooks/useAuth';
import { useToast } from '@/hooks/use-toast';

export interface ClientData {
  id: string;
  user_id: string;
  email: string;
  nome_completo: string;
  funcao_do_usuario?: string;
  telefone?: string;
  data_nascimento?: string;
  sexo?: string;
  altura_cm?: number;
  peso_inicial_kg?: number;
  meta_peso_kg?: number;
  circunferencia_abdominal_cm?: number;
  status: string;
  plano: string;
  data_cadastro: string;
  ultima_atividade?: string;
  created_at: string;
  updated_at: string;
}

export const useClientData = () => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [clientData, setClientData] = useState<ClientData | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (user) {
      fetchClientData();
    }
  }, [user]);

  const fetchClientData = async () => {
    if (!user) return;

    try {
      setLoading(true);
      
      // Buscar dados do cliente
      const { data, error } = await supabase
        .from('clientes')
        .select('*')
        .eq('user_id', user.id)
        .single();

      if (error && error.code !== 'PGRST116') {
        throw error;
      }

      setClientData(data);
    } catch (error) {
      console.error('Erro ao buscar dados do cliente:', error);
      toast({
        title: "Erro ao carregar dados",
        description: "Não foi possível carregar seus dados. Tente novamente.",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const updateClientData = async (updates: Partial<ClientData>) => {
    if (!user || !clientData) return false;

    try {
      const { error } = await supabase
        .from('clientes')
        .update({
          ...updates,
          updated_at: new Date().toISOString()
        })
        .eq('user_id', user.id);

      if (error) throw error;

      // Atualizar estado local
      setClientData(prev => prev ? { ...prev, ...updates } : null);
      
      toast({
        title: "✅ Dados atualizados!",
        description: "Suas informações foram salvas com sucesso.",
      });

      return true;
    } catch (error) {
      console.error('Erro ao atualizar dados do cliente:', error);
      toast({
        title: "Erro ao salvar",
        description: "Não foi possível salvar os dados. Tente novamente.",
        variant: "destructive",
      });
      return false;
    }
  };

  const createClientData = async (data: Partial<ClientData>) => {
    if (!user) return false;

    try {
      const { error } = await supabase
        .from('clientes')
        .insert({
          user_id: user.id,
          email: user.email || '',
          ...data
        });

      if (error) throw error;

      // Buscar dados atualizados
      await fetchClientData();
      
      toast({
        title: "✅ Perfil criado!",
        description: "Seus dados foram salvos com sucesso.",
      });

      return true;
    } catch (error) {
      console.error('Erro ao criar dados do cliente:', error);
      toast({
        title: "Erro ao criar perfil",
        description: "Não foi possível criar seu perfil. Tente novamente.",
        variant: "destructive",
      });
      return false;
    }
  };

  const updateLastActivity = async () => {
    if (!user) return;

    try {
      await supabase
        .from('clientes')
        .update({ 
          ultima_atividade: new Date().toISOString() 
        })
        .eq('user_id', user.id);
    } catch (error) {
      console.error('Erro ao atualizar última atividade:', error);
    }
  };

  return {
    clientData,
    loading,
    fetchClientData,
    updateClientData,
    createClientData,
    updateLastActivity
  };
};