import React, { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { supabase } from '@/integrations/supabase/client';
import { DisabledAdminFeature } from './DisabledAdminFeature';
import { BarChart, Users, Target } from 'lucide-react';

export const SimplifiedDataVisualization: React.FC = () => {
  const [dailyMissions, setDailyMissions] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchSimplifiedData();
  }, []);

  const fetchSimplifiedData = async () => {
    try {
      // Buscar apenas dados de missões que existem
      const { data: missions, error: missionsError } = await supabase
        .from('missao_dia')
        .select('user_id, data, concluido, created_at')
        .order('data', { ascending: false })
        .limit(50);

      if (missionsError) throw missionsError;

      setDailyMissions(missions || []);
    } catch (error) {
      console.error('Erro ao buscar dados:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {[1, 2, 3].map(i => (
          <Card key={i} className="animate-pulse">
            <CardHeader className="h-20 bg-gray-200 rounded-t-lg" />
            <CardContent className="h-40 bg-gray-100" />
          </Card>
        ))}
      </div>
    );
  }

  const completedMissions = dailyMissions.filter(m => m.concluido).length;
  const totalMissions = dailyMissions.length;
  const completionRate = totalMissions > 0 ? (completedMissions / totalMissions) * 100 : 0;

  return (
    <div className="space-y-6">
      {/* Estatísticas Básicas */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Missões Concluídas</CardTitle>
            <Users className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{completedMissions}</div>
            <p className="text-xs text-muted-foreground">
              de {totalMissions} missões registradas
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Taxa de Conclusão</CardTitle>
            <BarChart className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{completionRate.toFixed(1)}%</div>
            <p className="text-xs text-muted-foreground">
              média de conclusão
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Usuários Ativos</CardTitle>
            <Target className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {new Set(dailyMissions.map(m => m.user_id)).size}
            </div>
            <p className="text-xs text-muted-foreground">
              usuários únicos
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Funcionalidades em Desenvolvimento */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <DisabledAdminFeature
          title="Sistema de Metas"
          description="Visualização e gerenciamento de metas dos usuários estará disponível em breve."
        />
        
        <DisabledAdminFeature
          title="Análise Avançada"
          description="Gráficos e relatórios detalhados de engajamento e progresso dos usuários."
        />
      </div>
    </div>
  );
};

export default SimplifiedDataVisualization;