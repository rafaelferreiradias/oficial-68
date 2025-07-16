-- Criar tipos enum
CREATE TYPE public.app_role AS ENUM ('admin', 'client');
CREATE TYPE public.challenge_category AS ENUM ('biologico', 'psicologico');
CREATE TYPE public.challenge_level AS ENUM ('iniciante', 'intermediario', 'avancado');
CREATE TYPE public.sexo_enum AS ENUM ('masculino', 'feminino', 'outro');

-- Criar tabela profiles
CREATE TABLE public.profiles (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL UNIQUE,
  full_name TEXT,
  email TEXT,
  celular TEXT,
  altura_cm INTEGER,
  sexo sexo_enum,
  data_nascimento DATE,
  role app_role DEFAULT 'client'::app_role,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Criar tabela user_points
CREATE TABLE public.user_points (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  total_points INTEGER DEFAULT 0,
  daily_points INTEGER DEFAULT 0,
  weekly_points INTEGER DEFAULT 0,
  monthly_points INTEGER DEFAULT 0,
  current_streak INTEGER DEFAULT 0,
  best_streak INTEGER DEFAULT 0,
  completed_challenges INTEGER DEFAULT 0,
  last_activity_date DATE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE
);

-- Criar tabela dados_fisicos_usuario
CREATE TABLE public.dados_fisicos_usuario (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  nome_completo TEXT,
  altura_cm INTEGER,
  peso_atual_kg NUMERIC,
  meta_peso_kg NUMERIC,
  circunferencia_abdominal_cm NUMERIC,
  sexo TEXT,
  data_nascimento DATE,
  imc NUMERIC,
  categoria_imc TEXT,
  risco_cardiometabolico TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE
);

-- Criar tabela dados_saude_usuario
CREATE TABLE public.dados_saude_usuario (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  altura_cm INTEGER,
  peso_atual_kg NUMERIC,
  meta_peso_kg NUMERIC,
  circunferencia_abdominal_cm NUMERIC,
  imc NUMERIC,
  progresso_percentual NUMERIC,
  data_atualizacao TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE
);

-- Criar tabela missao_dia
CREATE TABLE public.missao_dia (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  data DATE NOT NULL,
  liquido_ao_acordar TEXT,
  energia_ao_acordar INTEGER,
  atividade_fisica BOOLEAN,
  agua_litros TEXT,
  sono_horas INTEGER,
  estresse_nivel INTEGER,
  fome_emocional BOOLEAN,
  pratica_conexao TEXT,
  gratidao TEXT,
  pequena_vitoria TEXT,
  intencao_para_amanha TEXT,
  nota_dia INTEGER,
  concluido BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE
);

-- Criar tabela pesagens
CREATE TABLE public.pesagens (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  peso_kg NUMERIC,
  gordura_corporal_pct NUMERIC,
  agua_corporal_pct NUMERIC,
  massa_muscular_kg NUMERIC,
  massa_ossea_kg NUMERIC,
  gordura_visceral INTEGER,
  taxa_metabolica_basal INTEGER,
  tipo_corpo TEXT,
  origem_medicao TEXT,
  data_medicao TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE
);

-- Criar tabela historico_medidas
CREATE TABLE public.historico_medidas (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  peso_kg NUMERIC,
  altura_cm INTEGER,
  circunferencia_abdominal_cm NUMERIC,
  imc NUMERIC,
  data_medicao DATE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE
);

-- Criar tabela informacoes_fisicas
CREATE TABLE public.informacoes_fisicas (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  altura_cm INTEGER,
  peso_atual_kg NUMERIC,
  meta_peso_kg NUMERIC,
  circunferencia_abdominal_cm NUMERIC,
  sexo TEXT,
  data_nascimento DATE,
  imc NUMERIC,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE
);

-- Criar tabela perfil_comportamental
CREATE TABLE public.perfil_comportamental (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  motivacao_principal TEXT,
  tentativa_emagrecimento TEXT,
  tentativa_emagrecimento_outro TEXT,
  motivo_desistencia TEXT,
  motivo_desistencia_outro TEXT,
  apoio_familiar TEXT,
  nivel_estresse INTEGER,
  nivel_autocuidado INTEGER,
  sentimento_hoje TEXT,
  gratidao_hoje TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE
);

-- Criar tabela daily_missions
CREATE TABLE public.daily_missions (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  mission_id TEXT NOT NULL,
  mission_date DATE NOT NULL,
  completed BOOLEAN DEFAULT false,
  completed_at TIMESTAMP WITH TIME ZONE,
  points_earned INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE
);

-- Criar tabela challenges
CREATE TABLE public.challenges (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  category challenge_category,
  level challenge_level,
  points INTEGER DEFAULT 0,
  duration_days INTEGER,
  is_active BOOLEAN DEFAULT true,
  icon TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Criar tabela achievements
CREATE TABLE public.achievements (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  icon TEXT,
  condition_type TEXT,
  condition_value JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Criar tabela courses
CREATE TABLE public.courses (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  category TEXT,
  duration_minutes INTEGER,
  is_premium BOOLEAN DEFAULT false,
  thumbnail TEXT,
  video_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Criar tabela pontuacao_diaria
CREATE TABLE public.pontuacao_diaria (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  data DATE NOT NULL,
  pontos_liquido_manha INTEGER DEFAULT 0,
  pontos_energia_acordar INTEGER DEFAULT 0,
  pontos_atividade_fisica INTEGER DEFAULT 0,
  pontos_agua INTEGER DEFAULT 0,
  pontos_sono INTEGER DEFAULT 0,
  pontos_estresse INTEGER DEFAULT 0,
  pontos_fome_emocional INTEGER DEFAULT 0,
  pontos_conexao_interna INTEGER DEFAULT 0,
  pontos_gratidao INTEGER DEFAULT 0,
  pontos_pequena_vitoria INTEGER DEFAULT 0,
  pontos_intencao_amanha INTEGER DEFAULT 0,
  pontos_avaliacao_dia INTEGER DEFAULT 0,
  total_pontos_dia INTEGER DEFAULT 0,
  categoria_dia TEXT DEFAULT 'baixa'::text,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Criar tabela clientes
CREATE TABLE public.clientes (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID,
  nome_completo TEXT,
  email TEXT,
  telefone TEXT,
  sexo TEXT,
  data_nascimento DATE,
  altura_cm INTEGER,
  peso_inicial_kg NUMERIC,
  meta_peso_kg NUMERIC,
  circunferencia_abdominal_cm NUMERIC,
  plano TEXT DEFAULT 'básico'::text,
  status TEXT DEFAULT 'ativo'::text,
  funcao_do_usuario TEXT,
  data_cadastro TIMESTAMP WITH TIME ZONE DEFAULT now(),
  ultima_atividade TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Habilitar RLS em todas as tabelas
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_points ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.dados_fisicos_usuario ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.dados_saude_usuario ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.missao_dia ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pesagens ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.historico_medidas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.informacoes_fisicas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.perfil_comportamental ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.daily_missions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.challenges ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.achievements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pontuacao_diaria ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.clientes ENABLE ROW LEVEL SECURITY;

-- Criar funções de suporte
CREATE OR REPLACE FUNCTION public.is_admin(user_id uuid)
RETURNS boolean
LANGUAGE sql
STABLE SECURITY DEFINER
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles 
    WHERE profiles.user_id = $1 AND role = 'admin'
  );
$$;

CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path TO 'public'
AS $$
BEGIN
  INSERT INTO public.profiles (user_id, full_name, email, role)
  VALUES (
    NEW.id,
    NEW.raw_user_meta_data->>'full_name',
    NEW.email,
    'client'::app_role
  );
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION public.check_physical_data_complete(user_uuid uuid)
RETURNS boolean
LANGUAGE sql
STABLE SECURITY DEFINER
SET search_path TO 'public'
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.dados_fisicos_usuario 
    WHERE user_id IN (
      SELECT id FROM public.profiles WHERE user_id = user_uuid
    )
    AND altura_cm IS NOT NULL 
    AND peso_atual_kg IS NOT NULL 
    AND sexo IS NOT NULL
  );
$$;

-- Criar trigger para novos usuários
CREATE OR REPLACE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Criar triggers para updated_at
CREATE TRIGGER update_profiles_updated_at
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_user_points_updated_at
  BEFORE UPDATE ON public.user_points
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_dados_fisicos_updated_at
  BEFORE UPDATE ON public.dados_fisicos_usuario
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_missao_dia_updated_at
  BEFORE UPDATE ON public.missao_dia
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_pesagens_updated_at
  BEFORE UPDATE ON public.pesagens
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_informacoes_fisicas_updated_at
  BEFORE UPDATE ON public.informacoes_fisicas
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_perfil_comportamental_updated_at
  BEFORE UPDATE ON public.perfil_comportamental
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_challenges_updated_at
  BEFORE UPDATE ON public.challenges
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_courses_updated_at
  BEFORE UPDATE ON public.courses
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_pontuacao_diaria_updated_at
  BEFORE UPDATE ON public.pontuacao_diaria
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_clientes_updated_at
  BEFORE UPDATE ON public.clientes
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();