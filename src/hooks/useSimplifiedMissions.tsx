import { useState, useEffect } from 'react';

// Simplified missions using localStorage for missing tables
export const useSimplifiedMissions = () => {
  const [missions, setMissions] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);

  const fetchMissions = () => {
    setLoading(true);
    try {
      const localMissions = localStorage.getItem('user_missions') || '[]';
      setMissions(JSON.parse(localMissions));
    } catch (error) {
      console.error('Erro ao carregar missões:', error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchMissions();
  }, []);

  return {
    missions,
    loading,
    refetch: fetchMissions
  };
};