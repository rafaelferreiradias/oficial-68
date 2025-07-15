// Simplified hooks to replace problematic ones that access non-existent tables
import { useState, useEffect } from 'react';

export const useMissaoUsuario = () => {
  const [missions, setMissions] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    // Use localStorage instead of non-existent table
    const localMissions = JSON.parse(localStorage.getItem('user_missions') || '[]');
    setMissions(localMissions);
  }, []);

  return {
    missions,
    loading,
    refetch: () => {
      const localMissions = JSON.parse(localStorage.getItem('user_missions') || '[]');
      setMissions(localMissions);
    }
  };
};

export const useProgressData = () => {
  const [progressData, setProgressData] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    // Mock progress data
    setProgressData([]);
  }, []);

  return {
    progressData,
    loading,
    refetch: () => setProgressData([])
  };
};

export const useWeeklyEvaluations = () => {
  const [evaluations, setEvaluations] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);

  const fetchEvaluations = () => {
    const localEvals = JSON.parse(localStorage.getItem('weekly_evaluations') || '[]');
    setEvaluations(localEvals);
  };

  const createEvaluation = (data: any) => {
    const newEval = { id: Date.now().toString(), ...data, created_at: new Date().toISOString() };
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