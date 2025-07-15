import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/hooks/useAuth';
import { startOfWeek } from 'date-fns';
import { toast } from 'sonner';

export interface WeeklyEvaluation {
  id: string;
  user_id: string;
  week_start_date: string;
  learning_data: {
    melhor_acontecimento?: string;
    maior_desafio?: string;
    conselho_mentor?: string;
    maior_aprendizado_sabotador?: string;
    momento_percebi_sabotando?: string;
    nome_semana?: string;
    relacao_ultima_semana?: string;
  };
  performance_ratings: {
    [key: string]: number;
  };
  next_week_goals?: string;
  created_at: string;
  updated_at: string;
}

export const useWeeklyEvaluations = () => {
  const [evaluations, setEvaluations] = useState<WeeklyEvaluation[]>([]);
  const [currentEvaluation, setCurrentEvaluation] = useState<WeeklyEvaluation | null>(null);
  const [loading, setLoading] = useState(true);
  const { user } = useAuth();

  const fetchEvaluations = async () => {
    try {
      setLoading(true);
      
      if (!user) {
        setEvaluations([]);
        setCurrentEvaluation(null);
        return;
      }

      const profile = await supabase.from('profiles').select('id').eq('user_id', user.id).single();
      if (profile.error) throw profile.error;

      // Simular dados de avaliações semanais
      const mockEvaluations: WeeklyEvaluation[] = [];
      setEvaluations(mockEvaluations);
    } catch (error) {
      console.error('Erro ao buscar avaliações semanais:', error);
    } finally {
      setLoading(false);
    }
  };

  const fetchEvaluationByWeek = async (weekStartDate: Date) => {
    try {
      if (!user) return null;

      const profile = await supabase.from('profiles').select('id').eq('user_id', user.id).single();
      if (profile.error) throw profile.error;

      const weekStartString = weekStartDate.toISOString().split('T')[0];

      // Simulação: retornar null como se não houvesse avaliação
      setCurrentEvaluation(null);
      return null;
    } catch (error) {
      console.error('Erro ao buscar avaliação da semana:', error);
      return null;
    }
  };

  const saveEvaluation = async (
    weekStartDate: Date,
    learningData: any,
    performanceRatings: any,
    nextWeekGoals: string
  ) => {
    try {
      if (!user) {
        toast.error('Você precisa estar logado para salvar avaliações');
        return;
      }

      const profile = await supabase.from('profiles').select('id').eq('user_id', user.id).single();
      if (profile.error) throw profile.error;

      const weekStartString = weekStartDate.toISOString().split('T')[0];

      const evaluationData = {
        user_id: profile.data.id,
        week_start_date: weekStartString,
        learning_data: learningData,
        performance_ratings: performanceRatings,
        next_week_goals: nextWeekGoals
      };

      // Simulação: criar avaliação mock
      const mockEvaluation: WeeklyEvaluation = {
        id: Date.now().toString(),
        user_id: profile.data.id,
        week_start_date: weekStartString,
        learning_data: learningData,
        performance_ratings: performanceRatings,
        next_week_goals: nextWeekGoals,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      };

      setCurrentEvaluation(mockEvaluation);
      
      // Atualizar lista de avaliações
      setEvaluations(prev => {
        const filtered = prev.filter(evaluation => evaluation.week_start_date !== weekStartString);
        return [mockEvaluation, ...filtered].sort((a, b) => 
          new Date(b.week_start_date).getTime() - new Date(a.week_start_date).getTime()
        );
      });

      toast.success('Avaliação semanal salva localmente! +50 pontos');
      return mockEvaluation;
    } catch (error) {
      console.error('Erro ao salvar avaliação semanal:', error);
      toast.error('Erro ao salvar avaliação');
      throw error;
    }
  };

  const getWeekStartDate = (date: Date = new Date()) => {
    return startOfWeek(date, { weekStartsOn: 1 }); // Segunda-feira como início da semana
  };

  useEffect(() => {
    fetchEvaluations();
  }, [user]);

  return {
    evaluations,
    currentEvaluation,
    loading,
    saveEvaluation,
    fetchEvaluationByWeek,
    getWeekStartDate,
    refetch: fetchEvaluations
  };
};