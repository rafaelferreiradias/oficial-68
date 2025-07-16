-- Criar tabela de profiles dos usuários
CREATE TABLE public.profiles (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name TEXT,
  celular TEXT,
  data_nascimento DATE,
  sexo TEXT CHECK (sexo IN ('masculino', 'feminino', 'outro')),
  altura_cm INTEGER,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Criar tabela de dados físicos
CREATE TABLE public.dados_fisicos (
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

-- Criar tabela de dados de saúde
CREATE TABLE public.dados_saude (
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

-- Criar tabela de avaliacoes semanais
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

-- Criar tabela de pontuações
CREATE TABLE public.pontuacoes (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  data_pontuacao DATE NOT NULL,
  pontos INTEGER NOT NULL DEFAULT 0,
  categoria TEXT,
  descricao TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Habilitar RLS em todas as tabelas
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.dados_fisicos ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.dados_saude ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.missoes_diarias ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.avaliacoes_semanais ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pontuacoes ENABLE ROW LEVEL SECURITY;

-- Políticas para profiles
CREATE POLICY "Users can view their own profile" ON public.profiles FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert their own profile" ON public.profiles FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their own profile" ON public.profiles FOR UPDATE USING (auth.uid() = user_id);

-- Políticas para dados_fisicos
CREATE POLICY "Users can view their own physical data" ON public.dados_fisicos FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert their own physical data" ON public.dados_fisicos FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their own physical data" ON public.dados_fisicos FOR UPDATE USING (auth.uid() = user_id);

-- Políticas para dados_saude
CREATE POLICY "Users can view their own health data" ON public.dados_saude FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert their own health data" ON public.dados_saude FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their own health data" ON public.dados_saude FOR UPDATE USING (auth.uid() = user_id);

-- Políticas para missoes_diarias
CREATE POLICY "Users can view their own missions" ON public.missoes_diarias FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert their own missions" ON public.missoes_diarias FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their own missions" ON public.missoes_diarias FOR UPDATE USING (auth.uid() = user_id);

-- Políticas para avaliacoes_semanais
CREATE POLICY "Users can view their own evaluations" ON public.avaliacoes_semanais FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert their own evaluations" ON public.avaliacoes_semanais FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their own evaluations" ON public.avaliacoes_semanais FOR UPDATE USING (auth.uid() = user_id);

-- Políticas para pontuacoes
CREATE POLICY "Users can view their own scores" ON public.pontuacoes FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert their own scores" ON public.pontuacoes FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Função para atualizar timestamps
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers para atualizar timestamps automaticamente
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_missoes_diarias_updated_at BEFORE UPDATE ON public.missoes_diarias FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();