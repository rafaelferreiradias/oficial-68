import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/hooks/useAuth';
import { useToast } from '@/hooks/use-toast';

export interface Challenge {
  id: string;
  title: string;
  description: string | null;
  category: 'biologico' | 'psicologico' | null;
  level: 'iniciante' | 'intermediario' | 'avancado' | null;
  points: number | null;
  duration_days: number | null;
  icon: string | null;
  is_active: boolean | null;
  created_at: string | null;
  updated_at: string | null;
}

export interface UserChallenge {
  id: string;
  user_id: string;
  challenge_id: string;
  progress: number;
  target_value: number;
  is_completed: boolean;
  started_at: string;
  completed_at: string | null;
  challenge: Challenge;
}

export const useChallenges = () => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [challenges, setChallenges] = useState<Challenge[]>([]);
  const [userChallenges, setUserChallenges] = useState<UserChallenge[]>([]);
  const [availableChallenges, setAvailableChallenges] = useState<Challenge[]>([]);
  const [completedChallenges, setCompletedChallenges] = useState<UserChallenge[]>([]);
  const [activeChallenges, setActiveChallenges] = useState<UserChallenge[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (user) {
      fetchChallenges();
    }
  }, [user]);

  const fetchChallenges = async () => {
    if (!user) return;

    try {
      // Fetch available challenges
      const { data: challengesData, error: challengesError } = await supabase
        .from('challenges')
        .select('*')
        .eq('is_active', true)
        .order('created_at', { ascending: false });

      if (challengesError) throw challengesError;
      
      setChallenges(challengesData || []);
      
      // Since we don't have user_challenges table, create mock user challenges
      const mockUserChallenges: UserChallenge[] = [];
      const mockAvailable = challengesData || [];
      
      setUserChallenges(mockUserChallenges);
      setAvailableChallenges(mockAvailable);
      setActiveChallenges(mockUserChallenges.filter(uc => !uc.is_completed));
      setCompletedChallenges(mockUserChallenges.filter(uc => uc.is_completed));
      
    } catch (error) {
      console.error('Erro ao buscar desafios:', error);
      toast({
        title: "Erro",
        description: "Não foi possível carregar os desafios.",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const joinChallenge = async (challengeId: string) => {
    if (!user) return false;

    try {
      // Since we don't have user_challenges table, simulate joining with localStorage
      const storageKey = `user_challenge_${user.id}_${challengeId}`;
      const challengeData = {
        id: `uc_${Date.now()}`,
        user_id: user.id,
        challenge_id: challengeId,
        progress: 0,
        target_value: 100,
        is_completed: false,
        started_at: new Date().toISOString(),
        completed_at: null,
        challenge: challenges.find(c => c.id === challengeId)
      };
      
      localStorage.setItem(storageKey, JSON.stringify(challengeData));

      // Update state to simulate database response
      const newUserChallenge = challengeData as UserChallenge;
      setUserChallenges(prev => [...prev, newUserChallenge]);
      setActiveChallenges(prev => [...prev, newUserChallenge]);
      setAvailableChallenges(prev => prev.filter(c => c.id !== challengeId));

      toast({
        title: "Sucesso!",
        description: "Você entrou no desafio com sucesso!",
      });

      return true;
    } catch (error) {
      console.error('Erro ao entrar no desafio:', error);
      toast({
        title: "Erro",
        description: "Não foi possível entrar no desafio.",
        variant: "destructive",
      });
      return false;
    }
  };

  const updateChallengeProgress = async (challengeId: string, progress: number) => {
    if (!user) return false;

    try {
      // Since we don't have user_challenges table, use localStorage
      const storageKey = `user_challenge_${user.id}_${challengeId}`;
      const stored = localStorage.getItem(storageKey);
      
      if (stored) {
        const challengeData = JSON.parse(stored);
        challengeData.progress = progress;
        challengeData.is_completed = progress >= challengeData.target_value;
        
        if (challengeData.is_completed && !challengeData.completed_at) {
          challengeData.completed_at = new Date().toISOString();
          
          // Award points
          toast({
            title: "Desafio Concluído!",
            description: `Parabéns! Você ganhou ${challengeData.challenge?.points || 0} pontos!`,
          });
        }
        
        localStorage.setItem(storageKey, JSON.stringify(challengeData));
        
        // Update state
        setUserChallenges(prev => 
          prev.map(uc => 
            uc.challenge_id === challengeId 
              ? { ...uc, progress, is_completed: challengeData.is_completed, completed_at: challengeData.completed_at }
              : uc
          )
        );
      }

      return true;
    } catch (error) {
      console.error('Erro ao atualizar progresso:', error);
      return false;
    }
  };

  const leaveChallenge = async (challengeId: string) => {
    if (!user) return false;

    try {
      // Since we don't have user_challenges table, remove from localStorage
      const storageKey = `user_challenge_${user.id}_${challengeId}`;
      localStorage.removeItem(storageKey);

      // Update state
      setUserChallenges(prev => prev.filter(uc => uc.challenge_id !== challengeId));
      setActiveChallenges(prev => prev.filter(uc => uc.challenge_id !== challengeId));
      setCompletedChallenges(prev => prev.filter(uc => uc.challenge_id !== challengeId));
      
      // Add back to available challenges
      const challenge = challenges.find(c => c.id === challengeId);
      if (challenge) {
        setAvailableChallenges(prev => [...prev, challenge]);
      }

      toast({
        title: "Sucesso!",
        description: "Você saiu do desafio.",
      });

      return true;
    } catch (error) {
      console.error('Erro ao sair do desafio:', error);
      toast({
        title: "Erro",
        description: "Não foi possível sair do desafio.",
        variant: "destructive",
      });
      return false;
    }
  };

  return {
    challenges,
    userChallenges,
    availableChallenges,
    completedChallenges,
    activeChallenges,
    loading,
    joinChallenge,
    updateChallengeProgress,
    leaveChallenge,
    refetch: fetchChallenges
  };
};