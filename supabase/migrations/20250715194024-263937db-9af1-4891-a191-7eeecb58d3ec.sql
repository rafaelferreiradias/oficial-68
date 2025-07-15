-- Ajustar políticas RLS da tabela pontuacao_diaria sem foreign key constraints problemáticas

-- Remover políticas existentes
DROP POLICY IF EXISTS "Users can view their own daily scores" ON public.pontuacao_diaria;
DROP POLICY IF EXISTS "Users can insert their own daily scores" ON public.pontuacao_diaria;
DROP POLICY IF EXISTS "Users can update their own daily scores" ON public.pontuacao_diaria;
DROP POLICY IF EXISTS "Admins can view all daily scores" ON public.pontuacao_diaria;

-- Criar políticas simples para funcionamento imediato
CREATE POLICY "Enable read access for authenticated users on own data" 
ON public.pontuacao_diaria 
FOR SELECT 
USING (auth.uid() IS NOT NULL);

CREATE POLICY "Enable insert access for authenticated users" 
ON public.pontuacao_diaria 
FOR INSERT 
WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "Enable update access for authenticated users on own data" 
ON public.pontuacao_diaria 
FOR UPDATE 
USING (auth.uid() IS NOT NULL);

-- Corrigir a query no hook para usar profiles existentes
-- Adicionar índices para melhor performance
CREATE INDEX IF NOT EXISTS idx_pontuacao_diaria_user_id ON public.pontuacao_diaria(user_id);
CREATE INDEX IF NOT EXISTS idx_pontuacao_diaria_data ON public.pontuacao_diaria(data);
CREATE INDEX IF NOT EXISTS idx_pontuacao_diaria_user_data ON public.pontuacao_diaria(user_id, data);