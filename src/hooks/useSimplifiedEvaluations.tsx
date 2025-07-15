import { useState, useEffect } from 'react';

// Simplified evaluations using localStorage
export const useSimplifiedEvaluations = () => {
  const [evaluations, setEvaluations] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);

  const fetchEvaluations = () => {
    setLoading(true);
    try {
      const localEvals = localStorage.getItem('weekly_evaluations') || '[]';
      setEvaluations(JSON.parse(localEvals));
    } catch (error) {
      console.error('Erro ao carregar avaliações:', error);
    } finally {
      setLoading(false);
    }
  };

  const createEvaluation = (data: any) => {
    const newEval = {
      id: Date.now().toString(),
      ...data,
      created_at: new Date().toISOString()
    };
    
    const updated = [newEval, ...evaluations];
    setEvaluations(updated);
    localStorage.setItem('weekly_evaluations', JSON.stringify(updated));
    return newEval;
  };

  useEffect(() => {
    fetchEvaluations();
  }, []);

  return {
    evaluations,
    loading,
    createEvaluation,
    refetch: fetchEvaluations
  };
};