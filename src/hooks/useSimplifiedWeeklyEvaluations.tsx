import { useState, useEffect } from 'react';

export interface WeeklyEvaluation {
  id: string;
  user_id: string;
  week_start_date: string;
  learning_data: any;
  performance_ratings: any;
  created_at: string;
}

export const useWeeklyEvaluations = () => {
  const [evaluations, setEvaluations] = useState<WeeklyEvaluation[]>([]);
  const [loading, setLoading] = useState(false);

  const fetchEvaluations = () => {
    setLoading(true);
    try {
      const localEvals = JSON.parse(localStorage.getItem('weekly_evaluations') || '[]');
      setEvaluations(localEvals);
    } catch (error) {
      console.error('Erro ao carregar avaliações:', error);
    } finally {
      setLoading(false);
    }
  };

  const createEvaluation = (data: any) => {
    const newEval: WeeklyEvaluation = {
      id: Date.now().toString(),
      ...data,
      created_at: new Date().toISOString()
    };
    
    const updated = [newEval, ...evaluations];
    setEvaluations(updated);
    localStorage.setItem('weekly_evaluations', JSON.stringify(updated));
    return newEval;
  };

  const updateEvaluation = (id: string, updates: any) => {
    const updatedEvals = evaluations.map(evaluation => 
      evaluation.id === id ? { ...evaluation, ...updates } : evaluation
    );
    
    setEvaluations(updatedEvals);
    localStorage.setItem('weekly_evaluations', JSON.stringify(updatedEvals));
    return updatedEvals.find(e => e.id === id);
  };

  const deleteEvaluation = (id: string) => {
    const updatedEvals = evaluations.filter(evaluation => evaluation.id !== id);
    setEvaluations(updatedEvals);
    localStorage.setItem('weekly_evaluations', JSON.stringify(updatedEvals));
  };

  useEffect(() => {
    fetchEvaluations();
  }, []);

  return {
    evaluations,
    loading,
    createEvaluation,
    updateEvaluation,
    deleteEvaluation,
    refetch: fetchEvaluations
  };
};