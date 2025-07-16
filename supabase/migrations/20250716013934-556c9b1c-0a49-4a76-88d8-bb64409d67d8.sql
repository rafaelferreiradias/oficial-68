-- Limpar tabelas existentes primeiro
DROP TABLE IF EXISTS public.avaliacoes_semanais CASCADE;
DROP TABLE IF EXISTS public.dados_fisicos CASCADE;
DROP TABLE IF EXISTS public.dados_saude CASCADE;
DROP TABLE IF EXISTS public.missoes_diarias CASCADE;
DROP TABLE IF EXISTS public.pontuacoes CASCADE;
DROP TABLE IF EXISTS public.profiles CASCADE;

-- Criar tabela de perfis (profiles)
CREATE TABLE public.perfis (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  nome_completo TEXT,
  celular TEXT,
  data_nascimento DATE,
  sexo TEXT CHECK (sexo IN ('masculino', 'feminino', 'outro')),
  altura_cm INTEGER,
  funcao_do_usuario TEXT DEFAULT 'cliente',
  criado_em TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  atualizado_em TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de dados físicos do usuário  
CREATE TABLE public.dados_fisicos_usuario (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  peso_kg DECIMAL(5,2),
  gordura_corporal_pct DECIMAL(4,1),
  massa_muscular_kg DECIMAL(5,2),
  agua_corporal_pct DECIMAL(4,1),
  taxa_metabolica_basal INTEGER,
  gordura_visceral INTEGER,
  imc DECIMAL(4,2),
  altura_cm INTEGER,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de dados de saúde do usuário
CREATE TABLE public.dados_saude_usuario (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  peso_atual_kg DECIMAL(5,2),
  imc DECIMAL(4,2),
  altura_cm INTEGER,
  circunferencia_abdominal_cm DECIMAL(5,1),
  meta_peso_kg DECIMAL(5,2),
  data_atualizacao TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de pesagens
CREATE TABLE public.pesagens (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  peso_kg DECIMAL(5,2) NOT NULL,
  gordura_corporal_pct DECIMAL(4,1),
  massa_muscular_kg DECIMAL(5,2),
  agua_corporal_pct DECIMAL(4,1),
  taxa_metabolica_basal INTEGER,
  gordura_visceral INTEGER,
  imc DECIMAL(4,2),
  circunferencia_abdominal_cm DECIMAL(5,1),
  data_medicao TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  origem_medicao TEXT DEFAULT 'manual',
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de missões diárias
CREATE TABLE public.missoes_diarias (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  data_missao DATE NOT NULL,
  pontuacao_total INTEGER DEFAULT 0,
  missoes_completas INTEGER DEFAULT 0,
  total_missoes INTEGER DEFAULT 12,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id, data_missao)
);

-- Criar tabela de missões do usuário
CREATE TABLE public.missoes_usuario (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  missao_id INTEGER NOT NULL,
  data_missao DATE NOT NULL,
  completada BOOLEAN DEFAULT false,
  pontuacao INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de missão do dia
CREATE TABLE public.missao_dia (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  data DATE NOT NULL,
  missao_1_completa BOOLEAN DEFAULT false,
  missao_2_completa BOOLEAN DEFAULT false,
  missao_3_completa BOOLEAN DEFAULT false,
  missao_4_completa BOOLEAN DEFAULT false,
  missao_5_completa BOOLEAN DEFAULT false,
  pontuacao_total INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id, data)
);

-- Criar tabela de pontuação diária
CREATE TABLE public.pontuacao_diaria (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  data DATE NOT NULL,
  total_pontos_dia INTEGER DEFAULT 0,
  categoria_dia TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id, data)
);

-- Criar tabela de pontos do usuário
CREATE TABLE public.pontos_do_usuario (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  data_pontuacao DATE NOT NULL,
  pontos INTEGER NOT NULL DEFAULT 0,
  categoria TEXT,
  descricao TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de avaliações semanais
CREATE TABLE public.avaliacoes_semanais (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  semana_inicio DATE NOT NULL,
  pontuacao_media DECIMAL(4,2),
  total_pontos INTEGER DEFAULT 0,
  dias_completos INTEGER DEFAULT 0,
  observacoes TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id, semana_inicio)
);

-- Criar tabela de histórico de medidas
CREATE TABLE public.historico_medidas (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  tipo_medida TEXT NOT NULL,
  valor DECIMAL(8,2) NOT NULL,
  unidade TEXT NOT NULL,
  data_medida TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  observacoes TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de metas
CREATE TABLE public.metas (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  tipo_meta TEXT NOT NULL,
  valor_alvo DECIMAL(8,2) NOT NULL,
  valor_atual DECIMAL(8,2) DEFAULT 0,
  unidade TEXT NOT NULL,
  data_inicio DATE NOT NULL,
  data_fim DATE,
  status TEXT DEFAULT 'ativa' CHECK (status IN ('ativa', 'concluida', 'pausada')),
  descricao TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de conquistas
CREATE TABLE public.conquistas (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  nome TEXT NOT NULL,
  descricao TEXT,
  icone TEXT,
  criterio JSONB,
  pontos_recompensa INTEGER DEFAULT 0,
  ativa BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de conquistas do usuário
CREATE TABLE public.conquistas_do_usuario (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  conquista_id UUID NOT NULL REFERENCES public.conquistas(id) ON DELETE CASCADE,
  data_conquista TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id, conquista_id)
);

-- Criar tabela de desafios
CREATE TABLE public.desafios (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  nome TEXT NOT NULL,
  descricao TEXT,
  tipo TEXT NOT NULL,
  meta JSONB,
  recompensa INTEGER DEFAULT 0,
  data_inicio DATE NOT NULL,
  data_fim DATE NOT NULL,
  ativo BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de desafios do usuário
CREATE TABLE public.desafios_do_usuario (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  desafio_id UUID NOT NULL REFERENCES public.desafios(id) ON DELETE CASCADE,
  progresso DECIMAL(5,2) DEFAULT 0,
  concluido BOOLEAN DEFAULT false,
  data_inicio TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  data_conclusao TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id, desafio_id)
);

-- Criar tabela de entradas do diário
CREATE TABLE public.entradas_do_diario (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  data_entrada DATE NOT NULL,
  conteudo TEXT NOT NULL,
  humor INTEGER CHECK (humor >= 1 AND humor <= 5),
  energia INTEGER CHECK (energia >= 1 AND energia <= 5),
  stress INTEGER CHECK (stress >= 1 AND stress <= 5),
  tags TEXT[],
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de comentários
CREATE TABLE public.comentarios (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  entrada_diario_id UUID REFERENCES public.entradas_do_diario(id) ON DELETE CASCADE,
  conteudo TEXT NOT NULL,
  tipo TEXT DEFAULT 'publico' CHECK (tipo IN ('publico', 'privado')),
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de interações
CREATE TABLE public.interacoes (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  tipo_interacao TEXT NOT NULL,
  item_id UUID NOT NULL,
  valor INTEGER DEFAULT 1,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de favoritos
CREATE TABLE public.favoritos (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  item_tipo TEXT NOT NULL,
  item_id UUID NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id, item_tipo, item_id)
);

-- Criar tabela de testes
CREATE TABLE public.testes (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  nome TEXT NOT NULL,
  descricao TEXT,
  tipo TEXT NOT NULL,
  perguntas JSONB NOT NULL,
  ativo BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de respostas de teste
CREATE TABLE public.respostas_de_teste (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  teste_id UUID NOT NULL REFERENCES public.testes(id) ON DELETE CASCADE,
  respostas JSONB NOT NULL,
  resultado JSONB,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de perfil comportamental
CREATE TABLE public.perfil_comportamental (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  tipo_personalidade TEXT,
  motivadores JSONB,
  sabotadores JSONB,
  preferencias JSONB,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de sessões
CREATE TABLE public.sessoes (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  tipo_sessao TEXT NOT NULL,
  data_sessao TIMESTAMP WITH TIME ZONE NOT NULL,
  duracao_minutos INTEGER,
  conteudo JSONB,
  anotacoes TEXT,
  status TEXT DEFAULT 'agendada' CHECK (status IN ('agendada', 'concluida', 'cancelada')),
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Habilitar RLS em todas as tabelas
ALTER TABLE public.perfis ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.dados_fisicos_usuario ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.dados_saude_usuario ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pesagens ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.missoes_diarias ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.missoes_usuario ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.missao_dia ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pontuacao_diaria ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pontos_do_usuario ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.avaliacoes_semanais ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.historico_medidas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.metas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.conquistas_do_usuario ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.desafios_do_usuario ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.entradas_do_diario ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.comentarios ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.interacoes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.favoritos ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.respostas_de_teste ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.perfil_comportamental ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sessoes ENABLE ROW LEVEL SECURITY;

-- Políticas RLS para perfis
CREATE POLICY "Users can view their own profile" ON public.perfis FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert their own profile" ON public.perfis FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their own profile" ON public.perfis FOR UPDATE USING (auth.uid() = user_id);

-- Políticas RLS para dados_fisicos_usuario
CREATE POLICY "Users can manage their physical data" ON public.dados_fisicos_usuario FOR ALL USING (auth.uid() = user_id);

-- Políticas RLS para dados_saude_usuario
CREATE POLICY "Users can manage their health data" ON public.dados_saude_usuario FOR ALL USING (auth.uid() = user_id);

-- Políticas RLS para pesagens
CREATE POLICY "Users can manage their weighings" ON public.pesagens FOR ALL USING (auth.uid() = user_id);

-- Políticas RLS para missões
CREATE POLICY "Users can manage their missions" ON public.missoes_diarias FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can manage their user missions" ON public.missoes_usuario FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can manage their daily missions" ON public.missao_dia FOR ALL USING (auth.uid() = user_id);

-- Políticas RLS para pontuações
CREATE POLICY "Users can view their scores" ON public.pontuacao_diaria FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can view their points" ON public.pontos_do_usuario FOR ALL USING (auth.uid() = user_id);

-- Políticas RLS para avaliações
CREATE POLICY "Users can manage their evaluations" ON public.avaliacoes_semanais FOR ALL USING (auth.uid() = user_id);

-- Políticas RLS para histórico e metas
CREATE POLICY "Users can manage their measurements" ON public.historico_medidas FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can manage their goals" ON public.metas FOR ALL USING (auth.uid() = user_id);

-- Políticas RLS para conquistas e desafios do usuário
CREATE POLICY "Users can view their achievements" ON public.conquistas_do_usuario FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can view their challenges" ON public.desafios_do_usuario FOR ALL USING (auth.uid() = user_id);

-- Políticas RLS para diário e comentários
CREATE POLICY "Users can manage their diary" ON public.entradas_do_diario FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can manage their comments" ON public.comentarios FOR ALL USING (auth.uid() = user_id);

-- Políticas RLS para interações e favoritos
CREATE POLICY "Users can manage their interactions" ON public.interacoes FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can manage their favorites" ON public.favoritos FOR ALL USING (auth.uid() = user_id);

-- Políticas RLS para testes e perfil
CREATE POLICY "Users can view their test responses" ON public.respostas_de_teste FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can manage their behavioral profile" ON public.perfil_comportamental FOR ALL USING (auth.uid() = user_id);

-- Políticas RLS para sessões
CREATE POLICY "Users can view their sessions" ON public.sessoes FOR ALL USING (auth.uid() = user_id);

-- Políticas para tabelas públicas (conquistas, desafios, testes)
CREATE POLICY "Everyone can view achievements" ON public.conquistas FOR SELECT USING (true);
CREATE POLICY "Everyone can view challenges" ON public.desafios FOR SELECT USING (true);
CREATE POLICY "Everyone can view tests" ON public.testes FOR SELECT USING (true);

-- Função para atualizar timestamps
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers para atualizar timestamps automaticamente
CREATE TRIGGER update_perfis_updated_at BEFORE UPDATE ON public.perfis FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_dados_fisicos_updated_at BEFORE UPDATE ON public.dados_fisicos_usuario FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_dados_saude_updated_at BEFORE UPDATE ON public.dados_saude_usuario FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_missoes_diarias_updated_at BEFORE UPDATE ON public.missoes_diarias FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_missoes_usuario_updated_at BEFORE UPDATE ON public.missoes_usuario FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_missao_dia_updated_at BEFORE UPDATE ON public.missao_dia FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_metas_updated_at BEFORE UPDATE ON public.metas FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_entradas_diario_updated_at BEFORE UPDATE ON public.entradas_do_diario FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_comentarios_updated_at BEFORE UPDATE ON public.comentarios FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_perfil_comportamental_updated_at BEFORE UPDATE ON public.perfil_comportamental FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_sessoes_updated_at BEFORE UPDATE ON public.sessoes FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();