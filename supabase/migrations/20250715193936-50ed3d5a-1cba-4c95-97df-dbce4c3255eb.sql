-- Primeiro, verificar quais user_ids existem em pontuacao_diaria mas não em profiles
-- e criar os perfis que estão faltando

INSERT INTO public.profiles (id, user_id, full_name, email, role)
SELECT DISTINCT 
  pd.user_id as id,
  pd.user_id as user_id, 
  CASE pd.user_id
    WHEN 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a' THEN 'Admin Test'
    WHEN 'f47ac10b-58cc-4372-a567-0e02b2c3d479' THEN 'Maria Silva'
    WHEN 'b2c3d4e5-f678-9abc-def0-123456789abc' THEN 'João Santos'
    WHEN 'c3d4e5f6-7890-abcd-ef12-3456789abcde' THEN 'Ana Costa'
    WHEN 'd4e5f6a7-8901-bcde-f234-56789abcdef0' THEN 'Pedro Oliveira'
    WHEN 'e5f6a7b8-9012-cdef-3456-789abcdef012' THEN 'Lucia Ferreira'
    ELSE 'Usuário'
  END as full_name,
  CASE pd.user_id
    WHEN 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a' THEN 'admin@test.com'
    WHEN 'f47ac10b-58cc-4372-a567-0e02b2c3d479' THEN 'maria.silva@email.com'
    WHEN 'b2c3d4e5-f678-9abc-def0-123456789abc' THEN 'joao.santos@email.com'
    WHEN 'c3d4e5f6-7890-abcd-ef12-3456789abcde' THEN 'ana.costa@email.com'
    WHEN 'd4e5f6a7-8901-bcde-f234-56789abcdef0' THEN 'pedro.oliveira@email.com'
    WHEN 'e5f6a7b8-9012-cdef-3456-789abcdef012' THEN 'lucia.ferreira@email.com'
    ELSE 'usuario@email.com'
  END as email,
  CASE pd.user_id
    WHEN 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a' THEN 'admin'::app_role
    ELSE 'client'::app_role
  END as role
FROM public.pontuacao_diaria pd
LEFT JOIN public.profiles p ON pd.user_id = p.id
WHERE p.id IS NULL
ON CONFLICT (id) DO UPDATE SET
  full_name = EXCLUDED.full_name,
  email = EXCLUDED.email,
  role = EXCLUDED.role;