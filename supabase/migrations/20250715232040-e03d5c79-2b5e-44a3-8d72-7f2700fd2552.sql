-- Criar tabela para armazenar dados completos dos clientes
CREATE TABLE IF NOT EXISTS public.clientes (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT UNIQUE,
  nome_completo TEXT,
  funcao_do_usuario TEXT,
  telefone TEXT,
  data_nascimento DATE,
  sexo TEXT,
  altura_cm INTEGER,
  peso_inicial_kg NUMERIC,
  meta_peso_kg NUMERIC,
  circunferencia_abdominal_cm NUMERIC,
  status TEXT DEFAULT 'ativo',
  plano TEXT DEFAULT 'básico',
  data_cadastro TIMESTAMP WITH TIME ZONE DEFAULT now(),
  ultima_atividade TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Habilitar RLS
ALTER TABLE public.clientes ENABLE ROW LEVEL SECURITY;

-- Políticas RLS para clientes
CREATE POLICY "Admins podem ver todos os clientes" 
ON public.clientes 
FOR SELECT 
USING (is_admin(auth.uid()));

CREATE POLICY "Clientes podem ver seus próprios dados" 
ON public.clientes 
FOR SELECT 
USING (auth.uid() = user_id);

CREATE POLICY "Admins podem inserir clientes" 
ON public.clientes 
FOR INSERT 
WITH CHECK (is_admin(auth.uid()));

CREATE POLICY "Admins podem atualizar clientes" 
ON public.clientes 
FOR UPDATE 
USING (is_admin(auth.uid()));

CREATE POLICY "Clientes podem atualizar seus próprios dados" 
ON public.clientes 
FOR UPDATE 
USING (auth.uid() = user_id);

-- Criar trigger para atualizar updated_at
CREATE TRIGGER update_clientes_updated_at
BEFORE UPDATE ON public.clientes
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

-- Índices para melhor performance
CREATE INDEX idx_clientes_user_id ON public.clientes(user_id);
CREATE INDEX idx_clientes_email ON public.clientes(email);
CREATE INDEX idx_clientes_status ON public.clientes(status);
CREATE INDEX idx_clientes_data_cadastro ON public.clientes(data_cadastro);

-- Função para sincronizar dados do perfil com clientes
CREATE OR REPLACE FUNCTION public.sync_profile_to_clientes()
RETURNS TRIGGER AS $$
BEGIN
  -- Inserir ou atualizar na tabela clientes quando perfil é atualizado
  INSERT INTO public.clientes (
    user_id, 
    email, 
    nome_completo, 
    data_nascimento, 
    sexo, 
    altura_cm
  ) 
  VALUES (
    NEW.user_id,
    NEW.email,
    NEW.full_name,
    NEW.data_nascimento,
    NEW.sexo::TEXT,
    NEW.altura_cm
  )
  ON CONFLICT (user_id) 
  DO UPDATE SET
    email = EXCLUDED.email,
    nome_completo = EXCLUDED.nome_completo,
    data_nascimento = EXCLUDED.data_nascimento,
    sexo = EXCLUDED.sexo,
    altura_cm = EXCLUDED.altura_cm,
    updated_at = now();
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger para sincronizar dados
CREATE TRIGGER sync_profile_to_clientes_trigger
AFTER INSERT OR UPDATE ON public.profiles
FOR EACH ROW
EXECUTE FUNCTION public.sync_profile_to_clientes();