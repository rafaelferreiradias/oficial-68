-- Criar políticas RLS para profiles
CREATE POLICY "Users can view their own profile" 
ON public.profiles 
FOR SELECT 
USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own profile" 
ON public.profiles 
FOR UPDATE 
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own profile during registration" 
ON public.profiles 
FOR INSERT 
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Admins can view all profiles" 
ON public.profiles 
FOR SELECT 
USING (is_admin(auth.uid()));

CREATE POLICY "Admins can update all profiles" 
ON public.profiles 
FOR UPDATE 
USING (is_admin(auth.uid()));

-- Criar políticas RLS para user_points
CREATE POLICY "Users can view their own points" 
ON public.user_points 
FOR SELECT 
USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can update their own points" 
ON public.user_points 
FOR UPDATE 
USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Criar políticas RLS para dados_fisicos_usuario
CREATE POLICY "Users can view their own data" 
ON public.dados_fisicos_usuario 
FOR ALL 
USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Criar políticas RLS para dados_saude_usuario
CREATE POLICY "Users can view their own health data" 
ON public.dados_saude_usuario 
FOR ALL 
USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Criar políticas RLS para missao_dia
CREATE POLICY "Users can view their own missions" 
ON public.missao_dia 
FOR ALL 
USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Criar políticas RLS para pesagens
CREATE POLICY "Users can view their own weighings" 
ON public.pesagens 
FOR ALL 
USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Criar políticas RLS para historico_medidas
CREATE POLICY "Users can view their own measure history" 
ON public.historico_medidas 
FOR ALL 
USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Criar políticas RLS para informacoes_fisicas
CREATE POLICY "Users can view their own physical info" 
ON public.informacoes_fisicas 
FOR ALL 
USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Criar políticas RLS para perfil_comportamental
CREATE POLICY "Users can view their own behavioral profile" 
ON public.perfil_comportamental 
FOR ALL 
USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Criar políticas RLS para daily_missions
CREATE POLICY "Users can view their own daily missions" 
ON public.daily_missions 
FOR ALL 
USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Criar políticas RLS para challenges
CREATE POLICY "Challenges are viewable by all users" 
ON public.challenges 
FOR SELECT 
USING (auth.uid() IS NOT NULL);

-- Criar políticas RLS para achievements
CREATE POLICY "Achievements are viewable by all users" 
ON public.achievements 
FOR SELECT 
USING (auth.uid() IS NOT NULL);

-- Criar políticas RLS para courses
CREATE POLICY "Courses are viewable by all users" 
ON public.courses 
FOR SELECT 
USING (auth.uid() IS NOT NULL);

-- Criar políticas RLS para pontuacao_diaria
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

-- Criar políticas RLS para clientes
CREATE POLICY "Clientes podem ver seus próprios dados" 
ON public.clientes 
FOR SELECT 
USING (auth.uid() = user_id);

CREATE POLICY "Clientes podem atualizar seus próprios dados" 
ON public.clientes 
FOR UPDATE 
USING (auth.uid() = user_id);

CREATE POLICY "Admins podem ver todos os clientes" 
ON public.clientes 
FOR SELECT 
USING (is_admin(auth.uid()));

CREATE POLICY "Admins podem atualizar clientes" 
ON public.clientes 
FOR UPDATE 
USING (is_admin(auth.uid()));

CREATE POLICY "Admins podem inserir clientes" 
ON public.clientes 
FOR INSERT 
WITH CHECK (is_admin(auth.uid()));