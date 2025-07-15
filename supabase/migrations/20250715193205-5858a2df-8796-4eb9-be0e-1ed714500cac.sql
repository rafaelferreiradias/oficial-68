-- Corrigir as funções sem search_path definido para melhorar segurança

-- Corrigir a função handle_new_user
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = 'public'
AS $function$
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
$function$;

-- Corrigir a função check_physical_data_complete
CREATE OR REPLACE FUNCTION public.check_physical_data_complete(user_uuid uuid)
RETURNS boolean
LANGUAGE sql
STABLE SECURITY DEFINER
SET search_path = 'public'
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

-- Verificar se o trigger já existe antes de criar
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- Criar o trigger para novos usuários
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();