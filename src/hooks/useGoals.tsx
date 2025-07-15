import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/hooks/useAuth';
import { toast } from 'sonner';

export interface Goal {
  id: string;
  user_id: string;
  name: string;
  type: string;
  start_date: string;
  target_date: string;
  notes: string;
  progress: number;
  other_type?: string;
  weekly_reminders: boolean;
  automatic_plan: boolean;
  created_at: string;
  updated_at: string;
}

export const useGoals = () => {
  const [goals, setGoals] = useState<Goal[]>([]);
  const [loading, setLoading] = useState(true);
  const { user } = useAuth();

  const fetchGoals = async () => {
    try {
      setLoading(true);
      
      if (!user) {
        setGoals([]);
        return;
      }

      // Since goals table doesn't exist, use localStorage
      const localGoals = localStorage.getItem(`goals_${user.id}`);
      if (localGoals) {
        setGoals(JSON.parse(localGoals));
      } else {
        setGoals([]);
      }
    } catch (error) {
      console.error('Erro ao buscar metas:', error);
      toast.error('Erro ao carregar metas');
    } finally {
      setLoading(false);
    }
  };

  const createGoal = async (goalData: Omit<Goal, 'id' | 'user_id' | 'created_at' | 'updated_at'>) => {
    try {
      if (!user) throw new Error('Usuário não autenticado');

      const newGoal: Goal = {
        ...goalData,
        id: Date.now().toString(),
        user_id: user.id,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      };
      
      const updatedGoals = [newGoal, ...goals];
      setGoals(updatedGoals);
      localStorage.setItem(`goals_${user.id}`, JSON.stringify(updatedGoals));
      
      toast.success('Meta criada com sucesso!');
      return newGoal;
    } catch (error) {
      console.error('Erro ao criar meta:', error);
      toast.error('Erro ao criar meta');
      throw error;
    }
  };

  const updateGoal = async (id: string, updates: Partial<Goal>) => {
    try {
      const updatedGoals = goals.map(goal => 
        goal.id === id 
          ? { ...goal, ...updates, updated_at: new Date().toISOString() }
          : goal
      );
      
      setGoals(updatedGoals);
      if (user) {
        localStorage.setItem(`goals_${user.id}`, JSON.stringify(updatedGoals));
      }
      
      toast.success('Meta atualizada com sucesso!');
      return updatedGoals.find(g => g.id === id);
    } catch (error) {
      console.error('Erro ao atualizar meta:', error);
      toast.error('Erro ao atualizar meta');
      throw error;
    }
  };

  const deleteGoal = async (id: string) => {
    try {
      const updatedGoals = goals.filter(goal => goal.id !== id);
      setGoals(updatedGoals);
      
      if (user) {
        localStorage.setItem(`goals_${user.id}`, JSON.stringify(updatedGoals));
      }
      
      toast.success('Meta excluída com sucesso!');
    } catch (error) {
      console.error('Erro ao excluir meta:', error);
      toast.error('Erro ao excluir meta');
      throw error;
    }
  };

  useEffect(() => {
    fetchGoals();
  }, [user]);

  return {
    goals,
    loading,
    createGoal,
    updateGoal,
    deleteGoal,
    refetch: fetchGoals
  };
};