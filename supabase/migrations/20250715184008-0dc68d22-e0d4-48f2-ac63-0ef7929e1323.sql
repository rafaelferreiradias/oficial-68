-- Criar tabela de pontuação diária para o sistema de ranking completo
CREATE TABLE IF NOT EXISTS public.pontuacao_diaria (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  data DATE NOT NULL,
  pontos_liquido_manha INTEGER DEFAULT 0,
  pontos_conexao_interna INTEGER DEFAULT 0,
  pontos_energia_acordar INTEGER DEFAULT 0,
  pontos_sono INTEGER DEFAULT 0,
  pontos_agua INTEGER DEFAULT 0,
  pontos_atividade_fisica INTEGER DEFAULT 0,
  pontos_estresse INTEGER DEFAULT 0,
  pontos_fome_emocional INTEGER DEFAULT 0,
  pontos_gratidao INTEGER DEFAULT 0,
  pontos_pequena_vitoria INTEGER DEFAULT 0,
  pontos_intencao_amanha INTEGER DEFAULT 0,
  pontos_avaliacao_dia INTEGER DEFAULT 0,
  total_pontos_dia INTEGER DEFAULT 0,
  categoria_dia TEXT DEFAULT 'baixa' CHECK (categoria_dia IN ('baixa', 'medio', 'excelente')),
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id, data)
);

-- Habilitar RLS
ALTER TABLE public.pontuacao_diaria ENABLE ROW LEVEL SECURITY;

-- Criar políticas RLS
CREATE POLICY "Users can view their own daily scores" 
ON public.pontuacao_diaria 
FOR SELECT 
USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can insert their own daily scores" 
ON public.pontuacao_diaria 
FOR INSERT 
WITH CHECK (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can update their own daily scores" 
ON public.pontuacao_diaria 
FOR UPDATE 
USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Inserir dados de exemplo para pontuação diária com base nos usuários do backup
INSERT INTO public.pontuacao_diaria (
  id, user_id, data,
  pontos_liquido_manha, pontos_conexao_interna, pontos_energia_acordar,
  pontos_sono, pontos_agua, pontos_atividade_fisica,
  pontos_estresse, pontos_fome_emocional, pontos_gratidao,
  pontos_pequena_vitoria, pontos_intencao_amanha, pontos_avaliacao_dia,
  total_pontos_dia, categoria_dia,
  created_at, updated_at
) VALUES
-- Admin Test (ea44df7a) - Pontuação alta
('pont-ea44df7a-2025-07-15', 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', '2025-07-15',
 15, 15, 20, 15, 10, 20, 12, 15, 10, 10, 10, 18, 170, 'excelente',
 '2025-07-15 06:00:00+00', '2025-07-15 22:00:00+00'),
('pont-ea44df7a-2025-07-14', 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', '2025-07-14',
 12, 12, 18, 12, 8, 18, 10, 12, 8, 8, 8, 15, 141, 'excelente',
 '2025-07-14 06:00:00+00', '2025-07-14 22:00:00+00'),

-- Maria Silva (f47ac10b) - Pontuação boa
('pont-f47ac10b-2025-07-15', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', '2025-07-15',
 12, 12, 16, 12, 8, 16, 8, 12, 8, 8, 8, 14, 134, 'excelente',
 '2025-07-15 06:30:00+00', '2025-07-15 21:30:00+00'),
('pont-f47ac10b-2025-07-14', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', '2025-07-14',
 10, 10, 14, 10, 6, 14, 6, 10, 6, 6, 6, 12, 110, 'excelente',
 '2025-07-14 06:30:00+00', '2025-07-14 21:30:00+00'),

-- João Santos (b2c3d4e5) - Pontuação média
('pont-b2c3d4e5-2025-07-15', 'b2c3d4e5-f678-9abc-def0-123456789abc', '2025-07-15',
 8, 8, 12, 8, 6, 0, 4, 0, 6, 6, 6, 10, 74, 'medio',
 '2025-07-15 07:00:00+00', '2025-07-15 20:30:00+00'),
('pont-b2c3d4e5-2025-07-14', 'b2c3d4e5-f678-9abc-def0-123456789abc', '2025-07-14',
 6, 6, 10, 6, 4, 0, 2, 0, 4, 4, 4, 8, 54, 'baixa',
 '2025-07-14 07:00:00+00', '2025-07-14 20:30:00+00'),

-- Ana Costa (c3d4e5f6) - Pontuação boa
('pont-c3d4e5f6-2025-07-15', 'c3d4e5f6-7890-abcd-ef12-3456789abcde', '2025-07-15',
 10, 10, 14, 10, 6, 14, 8, 10, 6, 6, 6, 12, 112, 'excelente',
 '2025-07-15 06:45:00+00', '2025-07-15 21:45:00+00'),
('pont-c3d4e5f6-2025-07-14', 'c3d4e5f6-7890-abcd-ef12-3456789abcde', '2025-07-14',
 8, 8, 12, 8, 4, 12, 6, 8, 4, 4, 4, 10, 88, 'medio',
 '2025-07-14 06:45:00+00', '2025-07-14 21:45:00+00'),

-- Pedro Oliveira (d4e5f6a7) - Pontuação excelente
('pont-d4e5f6a7-2025-07-15', 'd4e5f6a7-8901-bcde-f234-56789abcdef0', '2025-07-15',
 14, 14, 18, 14, 8, 18, 10, 14, 8, 8, 8, 16, 150, 'excelente',
 '2025-07-15 05:30:00+00', '2025-07-15 22:30:00+00'),
('pont-d4e5f6a7-2025-07-14', 'd4e5f6a7-8901-bcde-f234-56789abcdef0', '2025-07-14',
 12, 12, 16, 12, 6, 16, 8, 12, 6, 6, 6, 14, 126, 'excelente',
 '2025-07-14 05:30:00+00', '2025-07-14 22:30:00+00'),

-- Lucia Ferreira (e5f6a7b8) - Pontuação baixa
('pont-e5f6a7b8-2025-07-15', 'e5f6a7b8-9012-cdef-3456-789abcdef012', '2025-07-15',
 6, 6, 8, 6, 4, 0, 2, 0, 4, 4, 4, 6, 50, 'baixa',
 '2025-07-15 07:15:00+00', '2025-07-15 20:15:00+00'),
('pont-e5f6a7b8-2025-07-14', 'e5f6a7b8-9012-cdef-3456-789abcdef012', '2025-07-14',
 4, 4, 6, 4, 2, 0, 0, 0, 2, 2, 2, 4, 30, 'baixa',
 '2025-07-14 07:15:00+00', '2025-07-14 20:15:00+00')
ON CONFLICT (user_id, data) DO UPDATE SET
pontos_liquido_manha = EXCLUDED.pontos_liquido_manha,
pontos_conexao_interna = EXCLUDED.pontos_conexao_interna,
pontos_energia_acordar = EXCLUDED.pontos_energia_acordar,
pontos_sono = EXCLUDED.pontos_sono,
pontos_agua = EXCLUDED.pontos_agua,
pontos_atividade_fisica = EXCLUDED.pontos_atividade_fisica,
pontos_estresse = EXCLUDED.pontos_estresse,
pontos_fome_emocional = EXCLUDED.pontos_fome_emocional,
pontos_gratidao = EXCLUDED.pontos_gratidao,
pontos_pequena_vitoria = EXCLUDED.pontos_pequena_vitoria,
pontos_intencao_amanha = EXCLUDED.pontos_intencao_amanha,
pontos_avaliacao_dia = EXCLUDED.pontos_avaliacao_dia,
total_pontos_dia = EXCLUDED.total_pontos_dia,
categoria_dia = EXCLUDED.categoria_dia,
updated_at = EXCLUDED.updated_at;

-- Criar trigger para atualizar o timestamp
CREATE TRIGGER update_pontuacao_diaria_updated_at
BEFORE UPDATE ON public.pontuacao_diaria
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();