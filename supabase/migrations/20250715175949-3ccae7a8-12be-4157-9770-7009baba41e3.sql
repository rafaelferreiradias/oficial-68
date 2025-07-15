-- Criar enum para roles de usuário
CREATE TYPE public.app_role AS ENUM ('admin', 'client');

-- Criar enum para sexo
CREATE TYPE public.sexo_enum AS ENUM ('masculino', 'feminino', 'outro');

-- Criar enum para categoria de desafios
CREATE TYPE public.challenge_category AS ENUM ('biologico', 'psicologico');

-- Criar enum para nível de desafios
CREATE TYPE public.challenge_level AS ENUM ('iniciante', 'intermediario', 'avancado');

-- Tabela de perfis dos usuários
CREATE TABLE public.profiles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE NOT NULL,
    full_name TEXT,
    email TEXT,
    celular TEXT,
    data_nascimento DATE,
    sexo sexo_enum,
    altura_cm INTEGER,
    role app_role DEFAULT 'client',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Tabela de pontuação dos usuários
CREATE TABLE public.user_points (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
    total_points INTEGER DEFAULT 0,
    daily_points INTEGER DEFAULT 0,
    weekly_points INTEGER DEFAULT 0,
    monthly_points INTEGER DEFAULT 0,
    current_streak INTEGER DEFAULT 0,
    best_streak INTEGER DEFAULT 0,
    completed_challenges INTEGER DEFAULT 0,
    last_activity_date DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Tabela de dados físicos completos do usuário
CREATE TABLE public.dados_fisicos_usuario (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
    nome_completo TEXT,
    altura_cm INTEGER,
    peso_atual_kg DECIMAL(5,2),
    circunferencia_abdominal_cm DECIMAL(5,2),
    data_nascimento DATE,
    sexo TEXT,
    imc DECIMAL(8,4),
    categoria_imc TEXT,
    risco_cardiometabolico TEXT,
    meta_peso_kg DECIMAL(5,2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Tabela de dados de saúde atualizados
CREATE TABLE public.dados_saude_usuario (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
    altura_cm INTEGER,
    peso_atual_kg DECIMAL(5,2),
    circunferencia_abdominal_cm DECIMAL(5,2),
    meta_peso_kg DECIMAL(5,2),
    imc DECIMAL(8,4),
    progresso_percentual DECIMAL(5,2),
    data_atualizacao TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Tabela de missões diárias
CREATE TABLE public.missao_dia (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
    data DATE NOT NULL,
    agua_litros TEXT,
    atividade_fisica BOOLEAN,
    energia_ao_acordar INTEGER,
    estresse_nivel INTEGER,
    fome_emocional BOOLEAN,
    gratidao TEXT,
    liquido_ao_acordar TEXT,
    intencao_para_amanha TEXT,
    nota_dia INTEGER,
    pequena_vitoria TEXT,
    pratica_conexao TEXT,
    sono_horas INTEGER,
    concluido BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Tabela de pesagens (medições de balança)
CREATE TABLE public.pesagens (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
    peso_kg DECIMAL(5,2),
    agua_corporal_pct DECIMAL(5,2),
    gordura_corporal_pct DECIMAL(5,2),
    gordura_visceral INTEGER,
    massa_muscular_kg DECIMAL(5,2),
    massa_ossea_kg DECIMAL(5,2),
    taxa_metabolica_basal INTEGER,
    tipo_corpo TEXT,
    origem_medicao TEXT,
    data_medicao TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Tabela de histórico de medidas
CREATE TABLE public.historico_medidas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
    peso_kg DECIMAL(5,2),
    altura_cm INTEGER,
    circunferencia_abdominal_cm DECIMAL(5,2),
    imc DECIMAL(8,4),
    data_medicao DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Tabela de informações físicas básicas
CREATE TABLE public.informacoes_fisicas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
    altura_cm INTEGER,
    peso_atual_kg DECIMAL(5,2),
    circunferencia_abdominal_cm DECIMAL(5,2),
    data_nascimento DATE,
    sexo TEXT,
    imc DECIMAL(8,4),
    meta_peso_kg DECIMAL(5,2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Tabela de perfil comportamental
CREATE TABLE public.perfil_comportamental (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
    apoio_familiar TEXT,
    gratidao_hoje TEXT,
    motivacao_principal TEXT,
    motivo_desistencia TEXT,
    motivo_desistencia_outro TEXT,
    nivel_autocuidado INTEGER,
    nivel_estresse INTEGER,
    sentimento_hoje TEXT,
    tentativa_emagrecimento TEXT,
    tentativa_emagrecimento_outro TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Tabela de missões diárias completadas
CREATE TABLE public.daily_missions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
    mission_id TEXT NOT NULL,
    mission_date DATE NOT NULL,
    completed BOOLEAN DEFAULT false,
    completed_at TIMESTAMP WITH TIME ZONE,
    points_earned INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Tabela de desafios
CREATE TABLE public.challenges (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
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

-- Tabela de conquistas
CREATE TABLE public.achievements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT,
    condition_type TEXT,
    condition_value JSONB,
    icon TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Tabela de cursos
CREATE TABLE public.courses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT,
    thumbnail TEXT,
    video_url TEXT,
    category TEXT,
    duration_minutes INTEGER,
    is_premium BOOLEAN DEFAULT false,
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

-- Função para verificar se o usuário é admin
CREATE OR REPLACE FUNCTION public.is_admin(user_id UUID)
RETURNS BOOLEAN
LANGUAGE SQL
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles 
    WHERE profiles.user_id = $1 AND role = 'admin'
  );
$$;

-- Políticas RLS para profiles
CREATE POLICY "Users can view their own profile" ON public.profiles
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own profile" ON public.profiles
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Admins can view all profiles" ON public.profiles
    FOR SELECT USING (public.is_admin(auth.uid()));

CREATE POLICY "Admins can update all profiles" ON public.profiles
    FOR UPDATE USING (public.is_admin(auth.uid()));

-- Políticas RLS para user_points
CREATE POLICY "Users can view their own points" ON public.user_points
    FOR SELECT USING (user_id IN (SELECT id FROM public.profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can update their own points" ON public.user_points
    FOR UPDATE USING (user_id IN (SELECT id FROM public.profiles WHERE user_id = auth.uid()));

-- Políticas RLS gerais para dados do usuário
CREATE POLICY "Users can view their own data" ON public.dados_fisicos_usuario
    FOR ALL USING (user_id IN (SELECT id FROM public.profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can view their own health data" ON public.dados_saude_usuario
    FOR ALL USING (user_id IN (SELECT id FROM public.profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can view their own missions" ON public.missao_dia
    FOR ALL USING (user_id IN (SELECT id FROM public.profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can view their own weighings" ON public.pesagens
    FOR ALL USING (user_id IN (SELECT id FROM public.profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can view their own measure history" ON public.historico_medidas
    FOR ALL USING (user_id IN (SELECT id FROM public.profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can view their own physical info" ON public.informacoes_fisicas
    FOR ALL USING (user_id IN (SELECT id FROM public.profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can view their own behavioral profile" ON public.perfil_comportamental
    FOR ALL USING (user_id IN (SELECT id FROM public.profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can view their own daily missions" ON public.daily_missions
    FOR ALL USING (user_id IN (SELECT id FROM public.profiles WHERE user_id = auth.uid()));

-- Políticas para dados públicos
CREATE POLICY "Challenges are viewable by all users" ON public.challenges
    FOR SELECT USING (auth.uid() IS NOT NULL);

CREATE POLICY "Achievements are viewable by all users" ON public.achievements
    FOR SELECT USING (auth.uid() IS NOT NULL);

CREATE POLICY "Courses are viewable by all users" ON public.courses
    FOR SELECT USING (auth.uid() IS NOT NULL);

-- Trigger para atualizar timestamps
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Aplicar triggers de updated_at
CREATE TRIGGER update_profiles_updated_at
    BEFORE UPDATE ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_user_points_updated_at
    BEFORE UPDATE ON public.user_points
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_dados_fisicos_usuario_updated_at
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