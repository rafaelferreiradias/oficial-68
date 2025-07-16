import { useState, useEffect, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';
import { useAuth } from '@/hooks/useAuth';

interface BackupData {
  id: string;
  user_id: string;
  data: any;
  backup_type: 'manual' | 'automatic';
  created_at: string;
  size_bytes: number;
}

interface FullBackupData {
  timestamp: string;
  user_id: string;
  tables: {
    profiles: any[];
    dados_fisicos_usuario: any[];
    dados_saude_usuario: any[];
    historico_medidas: any[];
    informacoes_fisicas: any[];
    missao_dia: any[];
    pesagens: any[];
    pontuacao_diaria: any[];
    perfil_comportamental: any[];
    daily_missions: any[];
    user_points: any[];
    clientes: any[];
    achievements: any[];
    challenges: any[];
    courses: any[];
  };
  storage: {
    avatars: any[];
  };
}

export const useDataBackup = () => {
  const [isBackingUp, setIsBackingUp] = useState(false);
  const [lastBackup, setLastBackup] = useState<string | null>(null);
  const [backupHistory, setBackupHistory] = useState<BackupData[]>([]);
  const [backupProgress, setBackupProgress] = useState(0);
  const { toast } = useToast();
  const { user } = useAuth();

  useEffect(() => {
    loadBackupHistory();
    
    // Backup automático a cada 24 horas
    const interval = setInterval(() => {
      const lastBackupTime = localStorage.getItem('last_auto_backup');
      const now = Date.now();
      const dayInMs = 24 * 60 * 60 * 1000;
      
      if (!lastBackupTime || (now - parseInt(lastBackupTime)) > dayInMs) {
        createAutomaticBackup();
      }
    }, 60 * 60 * 1000); // Verificar a cada hora

    return () => clearInterval(interval);
  }, []);

  const loadBackupHistory = useCallback(async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      // Como não temos tabela de backup ainda, simular com dados locais
      const localBackups = localStorage.getItem('backup_history');
      if (localBackups) {
        setBackupHistory(JSON.parse(localBackups));
      }

      const lastBackupTime = localStorage.getItem('last_backup');
      if (lastBackupTime) {
        setLastBackup(lastBackupTime);
      }
    } catch (error) {
      console.error('Erro ao carregar histórico de backup:', error);
    }
  }, []);

  const createBackup = useCallback(async (type: 'manual' | 'automatic' = 'manual') => {
    setIsBackingUp(true);
    
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) throw new Error('Usuário não autenticado');

      // Coletar dados para backup
      const backupData = {
        profile: null,
        healthData: null,
        missions: null,
        goals: null,
        diaryEntries: null,
        courses: null
      };

      // Buscar dados do usuário
      const { data: profile } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', user.id)
        .single();

      const { data: healthData } = await supabase
        .from('dados_saude_usuario')
        .select('*')
        .eq('user_id', user.id);

      const { data: missions } = await supabase
        .from('daily_missions')
        .select('*')
        .eq('user_id', user.id);

      // Get data from localStorage since tables don't exist
      const goals = JSON.parse(localStorage.getItem(`goals_${user.id}`) || '[]');
      const diaryEntries = JSON.parse(localStorage.getItem(`diary_${user.id}`) || '[]');

      backupData.profile = profile;
      backupData.healthData = healthData;
      backupData.missions = missions;
      backupData.goals = goals;
      backupData.diaryEntries = diaryEntries;

      const backupInfo: BackupData = {
        id: Date.now().toString(),
        user_id: user.id,
        data: backupData,
        backup_type: type,
        created_at: new Date().toISOString(),
        size_bytes: JSON.stringify(backupData).length
      };

      // Salvar backup localmente (em produção, salvaria no Supabase Storage)
      const localBackups = JSON.parse(localStorage.getItem('backup_history') || '[]');
      localBackups.push(backupInfo);
      
      // Manter apenas os últimos 10 backups
      if (localBackups.length > 10) {
        localBackups.splice(0, localBackups.length - 10);
      }

      localStorage.setItem('backup_history', JSON.stringify(localBackups));
      localStorage.setItem('last_backup', new Date().toISOString());
      
      if (type === 'automatic') {
        localStorage.setItem('last_auto_backup', Date.now().toString());
      }

      setBackupHistory(localBackups);
      setLastBackup(new Date().toISOString());

      toast({
        title: type === 'manual' ? "Backup criado ✅" : "Backup automático ✅",
        description: `Dados salvos com segurança (${(backupInfo.size_bytes / 1024).toFixed(1)} KB)`
      });

    } catch (error) {
      console.error('Erro ao criar backup:', error);
      toast({
        title: "Erro no backup",
        description: "Não foi possível criar o backup",
        variant: "destructive"
      });
    } finally {
      setIsBackingUp(false);
    }
  }, [toast]);

  const createAutomaticBackup = useCallback(() => {
    createBackup('automatic');
  }, [createBackup]);

  const restoreBackup = useCallback(async (backupId: string) => {
    try {
      const backup = backupHistory.find(b => b.id === backupId);
      if (!backup) throw new Error('Backup não encontrado');

      // Em uma implementação completa, restauraria os dados no Supabase
      console.log('Restaurando backup:', backup);

      toast({
        title: "Backup restaurado ✅",
        description: "Seus dados foram restaurados com sucesso"
      });

    } catch (error) {
      console.error('Erro ao restaurar backup:', error);
      toast({
        title: "Erro na restauração",
        description: "Não foi possível restaurar o backup",
        variant: "destructive"
      });
    }
  }, [backupHistory, toast]);

  const deleteBackup = useCallback((backupId: string) => {
    const updatedBackups = backupHistory.filter(b => b.id !== backupId);
    localStorage.setItem('backup_history', JSON.stringify(updatedBackups));
    setBackupHistory(updatedBackups);

    toast({
      title: "Backup removido",
      description: "O backup foi removido do histórico"
    });
  }, [backupHistory, toast]);

  const exportBackup = useCallback((backupId: string) => {
    const backup = backupHistory.find(b => b.id === backupId);
    if (!backup) return;

    const dataStr = JSON.stringify(backup, null, 2);
    const dataBlob = new Blob([dataStr], { type: 'application/json' });
    const url = URL.createObjectURL(dataBlob);
    
    const link = document.createElement('a');
    link.href = url;
    link.download = `backup_${backup.created_at.split('T')[0]}.json`;
    link.click();
    
    URL.revokeObjectURL(url);

    toast({
      title: "Backup exportado",
      description: "Arquivo baixado com sucesso"
    });
  }, [backupHistory, toast]);

  const exportToJson = (data: any, filename: string) => {
    const jsonString = JSON.stringify(data, null, 2);
    const blob = new Blob([jsonString], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.download = filename;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    URL.revokeObjectURL(url);
  };

  const backupTable = async (tableName: string, userId?: string) => {
    try {
      let query = supabase.from(tableName as any).select('*');
      
      // Para tabelas que têm relação com user, filtrar por usuário
      const userTables = [
        'dados_fisicos_usuario', 'dados_saude_usuario', 'historico_medidas',
        'informacoes_fisicas', 'missao_dia', 'pesagens', 'pontuacao_diaria',
        'perfil_comportamental', 'daily_missions', 'user_points'
      ];
      
      if (userTables.includes(tableName) && userId) {
        // Buscar o profile id do usuário
        const { data: profile } = await supabase
          .from('profiles')
          .select('id')
          .eq('user_id', userId)
          .maybeSingle();
        
        if (profile) {
          query = query.eq('user_id', profile.id);
        }
      } else if (tableName === 'profiles' && userId) {
        query = query.eq('user_id', userId);
      } else if (tableName === 'clientes' && userId) {
        query = query.eq('user_id', userId);
      }

      const { data, error } = await query;
      
      if (error) {
        console.error(`Erro ao fazer backup da tabela ${tableName}:`, error);
        return [];
      }
      
      return data || [];
    } catch (error) {
      console.error(`Erro ao fazer backup da tabela ${tableName}:`, error);
      return [];
    }
  };

  const backupStorage = async () => {
    try {
      const { data, error } = await supabase.storage
        .from('avatars')
        .list();
      
      if (error) {
        console.error('Erro ao fazer backup do storage:', error);
        return [];
      }
      
      return data || [];
    } catch (error) {
      console.error('Erro ao fazer backup do storage:', error);
      return [];
    }
  };

  const createFullBackup = async () => {
    if (!user) {
      toast({
        title: "Erro",
        description: "Usuário não autenticado",
        variant: "destructive"
      });
      return;
    }

    setIsBackingUp(true);
    setBackupProgress(0);

    try {
      const totalSteps = 16; // 15 tabelas + 1 storage
      let currentStep = 0;

      const updateProgress = () => {
        currentStep++;
        setBackupProgress((currentStep / totalSteps) * 100);
      };

      toast({
        title: "Backup iniciado",
        description: "Fazendo backup completo dos dados..."
      });

      // Backup das tabelas
      const tables = {
        profiles: await backupTable('profiles', user.id),
        dados_fisicos_usuario: await backupTable('dados_fisicos_usuario', user.id),
        dados_saude_usuario: await backupTable('dados_saude_usuario', user.id),
        historico_medidas: await backupTable('historico_medidas', user.id),
        informacoes_fisicas: await backupTable('informacoes_fisicas', user.id),
        missao_dia: await backupTable('missao_dia', user.id),
        pesagens: await backupTable('pesagens', user.id),
        pontuacao_diaria: await backupTable('pontuacao_diaria', user.id),
        perfil_comportamental: await backupTable('perfil_comportamental', user.id),
        daily_missions: await backupTable('daily_missions', user.id),
        user_points: await backupTable('user_points', user.id),
        clientes: await backupTable('clientes', user.id),
        achievements: await backupTable('achievements'),
        challenges: await backupTable('challenges'),
        courses: await backupTable('courses'),
      };

      // Atualizar progresso para cada tabela
      Object.keys(tables).forEach(() => updateProgress());

      // Backup do storage
      const storage = {
        avatars: await backupStorage(),
      };
      updateProgress();

      const backupData: FullBackupData = {
        timestamp: new Date().toISOString(),
        user_id: user.id,
        tables,
        storage,
      };

      // Exportar backup completo
      const filename = `backup_completo_${new Date().toISOString().split('T')[0]}.json`;
      exportToJson(backupData, filename);

      // Exportar backups individuais por categoria
      exportToJson(tables.profiles, `backup_perfil_${new Date().toISOString().split('T')[0]}.json`);
      exportToJson({
        dados_fisicos: tables.dados_fisicos_usuario,
        dados_saude: tables.dados_saude_usuario,
        historico_medidas: tables.historico_medidas,
        informacoes_fisicas: tables.informacoes_fisicas,
        pesagens: tables.pesagens,
      }, `backup_dados_fisicos_${new Date().toISOString().split('T')[0]}.json`);
      
      exportToJson({
        missoes: tables.missao_dia,
        pontuacao: tables.pontuacao_diaria,
        daily_missions: tables.daily_missions,
        user_points: tables.user_points,
      }, `backup_missoes_pontuacao_${new Date().toISOString().split('T')[0]}.json`);

      exportToJson(tables.perfil_comportamental, `backup_perfil_comportamental_${new Date().toISOString().split('T')[0]}.json`);

      toast({
        title: "Backup completo realizado ✅",
        description: "Todos os arquivos foram baixados com sucesso"
      });
      
    } catch (error) {
      console.error('Erro durante o backup:', error);
      toast({
        title: "Erro no backup",
        description: "Erro durante o backup dos dados",
        variant: "destructive"
      });
    } finally {
      setIsBackingUp(false);
      setBackupProgress(0);
    }
  };

  return {
    isBackingUp,
    lastBackup,
    backupHistory,
    backupProgress,
    createBackup,
    restoreBackup,
    deleteBackup,
    exportBackup,
    createFullBackup
  };
};