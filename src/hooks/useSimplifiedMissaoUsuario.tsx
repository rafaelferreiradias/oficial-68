import { useState, useEffect } from 'react';

export interface MissaoUsuario {
  id: string;
  user_id: string;
  data: string;
  bebeu_agua: boolean;
  dormiu_bem: boolean;
  autocuidado: number;
  humor: number;
  concluido: boolean;
  created_at: string;
  updated_at: string;
}

export const useMissaoUsuario = () => {
  const [missions, setMissions] = useState<MissaoUsuario[]>([]);
  const [loading, setLoading] = useState(false);

  const fetchMissions = () => {
    setLoading(true);
    try {
      const localMissions = JSON.parse(localStorage.getItem('user_missions') || '[]');
      setMissions(localMissions);
    } catch (error) {
      console.error('Erro ao buscar missões do usuário:', error);
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