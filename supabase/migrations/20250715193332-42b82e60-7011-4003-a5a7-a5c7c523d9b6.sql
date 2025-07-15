-- Corrigir as políticas RLS da tabela pontuacao_diaria para referenciar profiles corretamente

-- Remover políticas existentes
DROP POLICY IF EXISTS "Users can view their own daily scores" ON public.pontuacao_diaria;
DROP POLICY IF EXISTS "Users can insert their own daily scores" ON public.pontuacao_diaria;
DROP POLICY IF EXISTS "Users can update their own daily scores" ON public.pontuacao_diaria;

-- Criar novas políticas mais eficientes usando user_id direto
CREATE POLICY "Users can view their own daily scores" 
ON public.pontuacao_diaria 
FOR SELECT 
USING (user_id = (SELECT id FROM profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can insert their own daily scores" 
ON public.pontuacao_diaria 
FOR INSERT 
WITH CHECK (user_id = (SELECT id FROM profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can update their own daily scores" 
ON public.pontuacao_diaria 
FOR UPDATE 
USING (user_id = (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Política para admins verem todos os dados
CREATE POLICY "Admins can view all daily scores" 
ON public.pontuacao_diaria 
FOR SELECT 
USING (is_admin(auth.uid()));

-- Verificar se as foreign keys estão corretas
ALTER TABLE public.pontuacao_diaria 
DROP CONSTRAINT IF EXISTS pontuacao_diaria_user_id_fkey;

ALTER TABLE public.pontuacao_diaria 
ADD CONSTRAINT pontuacao_diaria_user_id_fkey 
FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;