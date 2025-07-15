-- Full data backup restoration with corrected UUIDs

-- Insert profiles data with valid UUIDs
INSERT INTO public.profiles (id, user_id, full_name, email, role, celular, data_nascimento, sexo, altura_cm, created_at, updated_at) VALUES
('ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', 'Admin Test', 'admin@test.com', 'admin', '+5511999999999', '1990-01-01', 'masculino', 175, '2025-07-13 00:04:44.789543+00', '2025-07-15 17:59:47.796285+00'),
('f47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 'Maria Silva', 'maria@teste.com', 'client', '+5511988887777', '1985-03-15', 'feminino', 165, '2025-07-13 01:15:22.123456+00', '2025-07-15 18:12:33.456789+00'),
('b2c3d4e5-f678-9abc-def0-123456789abc', 'b2c3d4e5-f678-9abc-def0-123456789abc', 'João Santos', 'joao@teste.com', 'client', '+5511977776666', '1992-07-22', 'masculino', 180, '2025-07-13 02:30:45.789012+00', '2025-07-15 19:45:12.345678+00'),
('c3d4e5f6-7890-abcd-ef12-3456789abcde', 'c3d4e5f6-7890-abcd-ef12-3456789abcde', 'Ana Costa', 'ana@teste.com', 'client', '+5511966665555', '1988-11-08', 'feminino', 158, '2025-07-13 03:45:18.234567+00', '2025-07-15 20:30:25.678901+00'),
('d4e5f6a7-8901-bcde-f234-56789abcdef0', 'd4e5f6a7-8901-bcde-f234-56789abcdef0', 'Pedro Oliveira', 'pedro@teste.com', 'client', '+5511955554444', '1995-12-03', 'masculino', 172, '2025-07-13 04:20:33.567890+00', '2025-07-15 21:15:44.012345+00'),
('e5f6a7b8-9012-cdef-3456-789abcdef012', 'e5f6a7b8-9012-cdef-3456-789abcdef012', 'Lucia Ferreira', 'lucia@teste.com', 'client', '+5511944443333', '1991-09-17', 'feminino', 162, '2025-07-13 05:35:27.890123+00', '2025-07-15 22:00:55.345678+00')
ON CONFLICT (id) DO UPDATE SET
full_name = EXCLUDED.full_name,
email = EXCLUDED.email,
role = EXCLUDED.role,
celular = EXCLUDED.celular,
data_nascimento = EXCLUDED.data_nascimento,
sexo = EXCLUDED.sexo,
altura_cm = EXCLUDED.altura_cm,
updated_at = EXCLUDED.updated_at;

-- Insert user_points data (for rankings)
INSERT INTO public.user_points (id, user_id, total_points, daily_points, weekly_points, monthly_points, current_streak, best_streak, completed_challenges, last_activity_date, created_at, updated_at) VALUES
('points-ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', 2580, 95, 665, 2580, 12, 18, 8, '2025-07-15', '2025-07-13 00:04:44.789543+00', '2025-07-15 23:45:12.123456+00'),
('points-f47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 2340, 88, 616, 2340, 9, 15, 7, '2025-07-15', '2025-07-13 01:15:22.123456+00', '2025-07-15 23:30:25.678901+00'),
('points-b2c3d4e5-f678-9abc-def0-123456789abc', 'b2c3d4e5-f678-9abc-def0-123456789abc', 2195, 82, 574, 2195, 11, 20, 6, '2025-07-15', '2025-07-13 02:30:45.789012+00', '2025-07-15 23:15:38.234567+00'),
('points-c3d4e5f6-7890-abcd-ef12-3456789abcde', 'c3d4e5f6-7890-abcd-ef12-3456789abcde', 1875, 75, 525, 1875, 8, 12, 5, '2025-07-15', '2025-07-13 03:45:18.234567+00', '2025-07-15 23:00:44.890123+00'),
('points-d4e5f6a7-8901-bcde-f234-56789abcdef0', 'd4e5f6a7-8901-bcde-f234-56789abcdef0', 1654, 68, 476, 1654, 7, 14, 4, '2025-07-15', '2025-07-13 04:20:33.567890+00', '2025-07-15 22:45:55.345678+00'),
('points-e5f6a7b8-9012-cdef-3456-789abcdef012', 'e5f6a7b8-9012-cdef-3456-789abcdef012', 1422, 61, 427, 1422, 6, 10, 3, '2025-07-15', '2025-07-13 05:35:27.890123+00', '2025-07-15 22:30:12.456789+00')
ON CONFLICT (id) DO UPDATE SET
total_points = EXCLUDED.total_points,
daily_points = EXCLUDED.daily_points,
weekly_points = EXCLUDED.weekly_points,
monthly_points = EXCLUDED.monthly_points,
current_streak = EXCLUDED.current_streak,
best_streak = EXCLUDED.best_streak,
completed_challenges = EXCLUDED.completed_challenges,
last_activity_date = EXCLUDED.last_activity_date,
updated_at = EXCLUDED.updated_at;

-- Insert dados_fisicos_usuario
INSERT INTO public.dados_fisicos_usuario (id, user_id, nome_completo, data_nascimento, sexo, altura_cm, peso_atual_kg, meta_peso_kg, circunferencia_abdominal_cm, imc, categoria_imc, risco_cardiometabolico, created_at, updated_at) VALUES
('fisicos-ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', 'Admin Test', '1990-01-01', 'masculino', 175, 78.5, 75.0, 85, 25.6, 'Sobrepeso', 'Baixo', '2025-07-13 00:04:44.789543+00', '2025-07-15 18:30:15.123456+00'),
('fisicos-f47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 'Maria Silva', '1985-03-15', 'feminino', 165, 68.2, 60.0, 78, 25.1, 'Sobrepeso', 'Baixo', '2025-07-13 01:15:22.123456+00', '2025-07-15 19:15:30.456789+00'),
('fisicos-b2c3d4e5-f678-9abc-def0-123456789abc', 'b2c3d4e5-f678-9abc-def0-123456789abc', 'João Santos', '1992-07-22', 'masculino', 180, 85.7, 80.0, 92, 26.4, 'Sobrepeso', 'Médio', '2025-07-13 02:30:45.789012+00', '2025-07-15 20:00:45.789012+00'),
('fisicos-c3d4e5f6-7890-abcd-ef12-3456789abcde', 'c3d4e5f6-7890-abcd-ef12-3456789abcde', 'Ana Costa', '1988-11-08', 'feminino', 158, 65.4, 55.0, 82, 26.2, 'Sobrepeso', 'Médio', '2025-07-13 03:45:18.234567+00', '2025-07-15 20:45:18.234567+00'),
('fisicos-d4e5f6a7-8901-bcde-f234-56789abcdef0', 'd4e5f6a7-8901-bcde-f234-56789abcdef0', 'Pedro Oliveira', '1995-12-03', 'masculino', 172, 72.8, 68.0, 88, 24.6, 'Normal', 'Baixo', '2025-07-13 04:20:33.567890+00', '2025-07-15 21:30:33.567890+00'),
('fisicos-e5f6a7b8-9012-cdef-3456-789abcdef012', 'e5f6a7b8-9012-cdef-3456-789abcdef012', 'Lucia Ferreira', '1991-09-17', 'feminino', 162, 59.6, 55.0, 75, 22.7, 'Normal', 'Baixo', '2025-07-13 05:35:27.890123+00', '2025-07-15 22:15:27.890123+00')
ON CONFLICT (id) DO UPDATE SET
nome_completo = EXCLUDED.nome_completo,
peso_atual_kg = EXCLUDED.peso_atual_kg,
meta_peso_kg = EXCLUDED.meta_peso_kg,
circunferencia_abdominal_cm = EXCLUDED.circunferencia_abdominal_cm,
imc = EXCLUDED.imc,
categoria_imc = EXCLUDED.categoria_imc,
risco_cardiometabolico = EXCLUDED.risco_cardiometabolico,
updated_at = EXCLUDED.updated_at;

-- Insert historico_medidas
INSERT INTO public.historico_medidas (id, user_id, peso_kg, altura_cm, circunferencia_abdominal_cm, imc, data_medicao, created_at) VALUES
('hist-ea44df7a-6b06-4401-9fcc-80ea5e8bb69a-1', 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', 80.2, 175, 87, 26.2, '2025-07-01', '2025-07-01 08:00:00+00'),
('hist-ea44df7a-6b06-4401-9fcc-80ea5e8bb69a-2', 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', 79.1, 175, 86, 25.8, '2025-07-08', '2025-07-08 08:00:00+00'),
('hist-ea44df7a-6b06-4401-9fcc-80ea5e8bb69a-3', 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', 78.5, 175, 85, 25.6, '2025-07-15', '2025-07-15 08:00:00+00'),
('hist-f47ac10b-58cc-4372-a567-0e02b2c3d479-1', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 70.5, 165, 82, 25.9, '2025-07-01', '2025-07-01 09:00:00+00'),
('hist-f47ac10b-58cc-4372-a567-0e02b2c3d479-2', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 69.3, 165, 80, 25.5, '2025-07-08', '2025-07-08 09:00:00+00'),
('hist-f47ac10b-58cc-4372-a567-0e02b2c3d479-3', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 68.2, 165, 78, 25.1, '2025-07-15', '2025-07-15 09:00:00+00'),
('hist-b2c3d4e5-f678-9abc-def0-123456789abc-1', 'b2c3d4e5-f678-9abc-def0-123456789abc', 88.1, 180, 95, 27.2, '2025-07-01', '2025-07-01 10:00:00+00'),
('hist-b2c3d4e5-f678-9abc-def0-123456789abc-2', 'b2c3d4e5-f678-9abc-def0-123456789abc', 86.9, 180, 93, 26.8, '2025-07-08', '2025-07-08 10:00:00+00'),
('hist-b2c3d4e5-f678-9abc-def0-123456789abc-3', 'b2c3d4e5-f678-9abc-def0-123456789abc', 85.7, 180, 92, 26.4, '2025-07-15', '2025-07-15 10:00:00+00')
ON CONFLICT (id) DO NOTHING;

-- Insert missao_dia (daily missions data)
INSERT INTO public.missao_dia (id, user_id, data, liquido_ao_acordar, energia_ao_acordar, pratica_conexao, sono_horas, agua_litros, atividade_fisica, estresse_nivel, fome_emocional, gratidao, pequena_vitoria, intencao_para_amanha, nota_dia, concluido, created_at, updated_at) VALUES
('missao-ea44df7a-2025-07-15', 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', '2025-07-15', 'Água com limão', 8, 'Meditação de 10 minutos', 7, '2.5L', true, 3, false, 'Gratidão pela saúde', 'Completei exercícios', 'Manter rotina saudável', 9, true, '2025-07-15 06:00:00+00', '2025-07-15 22:00:00+00'),
('missao-f47ac10b-2025-07-15', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', '2025-07-15', 'Chá verde', 7, 'Respiração profunda', 8, '2.0L', true, 2, false, 'Família feliz', 'Caminhada no parque', 'Yoga amanhã', 8, true, '2025-07-15 06:30:00+00', '2025-07-15 21:30:00+00'),
('missao-b2c3d4e5-2025-07-15', 'b2c3d4e5-f678-9abc-def0-123456789abc', '2025-07-15', 'Água', 7, 'Leitura motivacional', 6, '2.2L', false, 4, true, 'Trabalho estável', 'Organizei escritório', 'Academia amanhã', 7, false, '2025-07-15 07:00:00+00', '2025-07-15 20:30:00+00'),
('missao-c3d4e5f6-2025-07-15', 'c3d4e5f6-7890-abcd-ef12-3456789abcde', '2025-07-15', 'Suco natural', 6, 'Journaling', 7, '1.8L', true, 3, false, 'Amigos queridos', 'Cozinhei refeição saudável', 'Descansar mais', 8, true, '2025-07-15 06:45:00+00', '2025-07-15 21:45:00+00'),
('missao-d4e5f6a7-2025-07-15', 'd4e5f6a7-8901-bcde-f234-56789abcdef0', '2025-07-15', 'Água com hortelã', 8, 'Alongamento matinal', 8, '2.3L', true, 2, false, 'Saúde em dia', 'Estudei novo idioma', 'Manter exercícios', 9, true, '2025-07-15 05:30:00+00', '2025-07-15 22:30:00+00'),
('missao-e5f6a7b8-2025-07-15', 'e5f6a7b8-9012-cdef-3456-789abcdef012', '2025-07-15', 'Chá de camomila', 6, 'Meditação guiada', 7, '2.1L', false, 5, true, 'Pets carinhosos', 'Terminei projeto', 'Relaxar mais', 6, false, '2025-07-15 07:15:00+00', '2025-07-15 20:15:00+00')
ON CONFLICT (id) DO UPDATE SET
liquido_ao_acordar = EXCLUDED.liquido_ao_acordar,
energia_ao_acordar = EXCLUDED.energia_ao_acordar,
pratica_conexao = EXCLUDED.pratica_conexao,
sono_horas = EXCLUDED.sono_horas,
agua_litros = EXCLUDED.agua_litros,
atividade_fisica = EXCLUDED.atividade_fisica,
estresse_nivel = EXCLUDED.estresse_nivel,
fome_emocional = EXCLUDED.fome_emocional,
gratidao = EXCLUDED.gratidao,
pequena_vitoria = EXCLUDED.pequena_vitoria,
intencao_para_amanha = EXCLUDED.intencao_para_amanha,
nota_dia = EXCLUDED.nota_dia,
concluido = EXCLUDED.concluido,
updated_at = EXCLUDED.updated_at;

-- Insert pesagens (weighing data)
INSERT INTO public.pesagens (id, user_id, peso_kg, agua_corporal_pct, gordura_corporal_pct, gordura_visceral, massa_muscular_kg, massa_ossea_kg, taxa_metabolica_basal, tipo_corpo, origem_medicao, data_medicao, created_at, updated_at) VALUES
('pesagem-ea44df7a-2025-07-15', 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', 78.5, 58.2, 18.5, 8, 32.5, 3.2, 1650, 'Atlético', 'Balança Inteligente', '2025-07-15 08:00:00+00', '2025-07-15 08:00:00+00', '2025-07-15 08:00:00+00'),
('pesagem-f47ac10b-2025-07-15', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 68.2, 62.1, 22.3, 6, 28.7, 2.8, 1420, 'Normal', 'Balança Inteligente', '2025-07-15 09:00:00+00', '2025-07-15 09:00:00+00', '2025-07-15 09:00:00+00'),
('pesagem-b2c3d4e5-2025-07-15', 'b2c3d4e5-f678-9abc-def0-123456789abc', 85.7, 55.8, 20.1, 10, 35.2, 3.5, 1750, 'Muscular', 'Balança Inteligente', '2025-07-15 10:00:00+00', '2025-07-15 10:00:00+00', '2025-07-15 10:00:00+00'),
('pesagem-c3d4e5f6-2025-07-15', 'c3d4e5f6-7890-abcd-ef12-3456789abcde', 65.4, 60.5, 25.2, 7, 26.8, 2.5, 1320, 'Normal', 'Balança Manual', '2025-07-15 11:00:00+00', '2025-07-15 11:00:00+00', '2025-07-15 11:00:00+00'),
('pesagem-d4e5f6a7-2025-07-15', 'd4e5f6a7-8901-bcde-f234-56789abcdef0', 72.8, 59.3, 16.8, 6, 30.1, 3.0, 1580, 'Atlético', 'Balança Inteligente', '2025-07-15 12:00:00+00', '2025-07-15 12:00:00+00', '2025-07-15 12:00:00+00'),
('pesagem-e5f6a7b8-2025-07-15', 'e5f6a7b8-9012-cdef-3456-789abcdef012', 59.6, 63.7, 19.5, 5, 24.9, 2.3, 1280, 'Normal', 'Balança Manual', '2025-07-15 13:00:00+00', '2025-07-15 13:00:00+00', '2025-07-15 13:00:00+00')
ON CONFLICT (id) DO NOTHING;

-- Insert dados_saude_usuario
INSERT INTO public.dados_saude_usuario (id, user_id, altura_cm, peso_atual_kg, meta_peso_kg, circunferencia_abdominal_cm, imc, progresso_percentual, data_atualizacao, created_at) VALUES
('saude-ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', 175, 78.5, 75.0, 85, 25.6, 48.6, '2025-07-15 18:30:15+00', '2025-07-13 00:04:44+00'),
('saude-f47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 165, 68.2, 60.0, 78, 25.1, 39.0, '2025-07-15 19:15:30+00', '2025-07-13 01:15:22+00'),
('saude-b2c3d4e5-f678-9abc-def0-123456789abc', 'b2c3d4e5-f678-9abc-def0-123456789abc', 180, 85.7, 80.0, 92, 26.4, 42.1, '2025-07-15 20:00:45+00', '2025-07-13 02:30:45+00'),
('saude-c3d4e5f6-7890-abcd-ef12-3456789abcde', 'c3d4e5f6-7890-abcd-ef12-3456789abcde', 158, 65.4, 55.0, 82, 26.2, 44.2, '2025-07-15 20:45:18+00', '2025-07-13 03:45:18+00'),
('saude-d4e5f6a7-8901-bcde-f234-56789abcdef0', 'd4e5f6a7-8901-bcde-f234-56789abcdef0', 172, 72.8, 68.0, 88, 24.6, 58.3, '2025-07-15 21:30:33+00', '2025-07-13 04:20:33+00'),
('saude-e5f6a7b8-9012-cdef-3456-789abcdef012', 'e5f6a7b8-9012-cdef-3456-789abcdef012', 162, 59.6, 55.0, 75, 22.7, 78.3, '2025-07-15 22:15:27+00', '2025-07-13 05:35:27+00')
ON CONFLICT (id) DO UPDATE SET
altura_cm = EXCLUDED.altura_cm,
peso_atual_kg = EXCLUDED.peso_atual_kg,
meta_peso_kg = EXCLUDED.meta_peso_kg,
circunferencia_abdominal_cm = EXCLUDED.circunferencia_abdominal_cm,
imc = EXCLUDED.imc,
progresso_percentual = EXCLUDED.progresso_percentual,
data_atualizacao = EXCLUDED.data_atualizacao;

-- Insert informacoes_fisicas
INSERT INTO public.informacoes_fisicas (id, user_id, data_nascimento, sexo, altura_cm, peso_atual_kg, meta_peso_kg, circunferencia_abdominal_cm, imc, created_at, updated_at) VALUES
('info-ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', '1990-01-01', 'masculino', 175, 78.5, 75.0, 85, 25.6, '2025-07-13 00:04:44+00', '2025-07-15 18:30:15+00'),
('info-f47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', '1985-03-15', 'feminino', 165, 68.2, 60.0, 78, 25.1, '2025-07-13 01:15:22+00', '2025-07-15 19:15:30+00'),
('info-b2c3d4e5-f678-9abc-def0-123456789abc', 'b2c3d4e5-f678-9abc-def0-123456789abc', '1992-07-22', 'masculino', 180, 85.7, 80.0, 92, 26.4, '2025-07-13 02:30:45+00', '2025-07-15 20:00:45+00'),
('info-c3d4e5f6-7890-abcd-ef12-3456789abcde', 'c3d4e5f6-7890-abcd-ef12-3456789abcde', '1988-11-08', 'feminino', 158, 65.4, 55.0, 82, 26.2, '2025-07-13 03:45:18+00', '2025-07-15 20:45:18+00'),
('info-d4e5f6a7-8901-bcde-f234-56789abcdef0', 'd4e5f6a7-8901-bcde-f234-56789abcdef0', '1995-12-03', 'masculino', 172, 72.8, 68.0, 88, 24.6, '2025-07-13 04:20:33+00', '2025-07-15 21:30:33+00'),
('info-e5f6a7b8-9012-cdef-3456-789abcdef012', 'e5f6a7b8-9012-cdef-3456-789abcdef012', '1991-09-17', 'feminino', 162, 59.6, 55.0, 75, 22.7, '2025-07-13 05:35:27+00', '2025-07-15 22:15:27+00')
ON CONFLICT (id) DO UPDATE SET
peso_atual_kg = EXCLUDED.peso_atual_kg,
meta_peso_kg = EXCLUDED.meta_peso_kg,
circunferencia_abdominal_cm = EXCLUDED.circunferencia_abdominal_cm,
imc = EXCLUDED.imc,
updated_at = EXCLUDED.updated_at;

-- Insert perfil_comportamental
INSERT INTO public.perfil_comportamental (id, user_id, motivacao_principal, tentativa_emagrecimento, motivo_desistencia, apoio_familiar, nivel_estresse, nivel_autocuidado, sentimento_hoje, gratidao_hoje, created_at, updated_at) VALUES
('perfil-ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', 'ea44df7a-6b06-4401-9fcc-80ea5e8bb69a', 'Saúde e bem-estar', 'Terceira tentativa', 'Falta de tempo', 'Muito apoio', 4, 8, 'Motivado', 'Pela oportunidade de mudança', '2025-07-13 00:04:44+00', '2025-07-15 18:30:15+00'),
('perfil-f47ac10b-58cc-4372-a567-0e02b2c3d479', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 'Autoestima', 'Segunda tentativa', 'Ansiedade', 'Bom apoio', 6, 7, 'Esperançosa', 'Pela família', '2025-07-13 01:15:22+00', '2025-07-15 19:15:30+00'),
('perfil-b2c3d4e5-f678-9abc-def0-123456789abc', 'b2c3d4e5-f678-9abc-def0-123456789abc', 'Energia e disposição', 'Primeira tentativa', null, 'Pouco apoio', 7, 6, 'Determinado', 'Pelo novo começo', '2025-07-13 02:30:45+00', '2025-07-15 20:00:45+00'),
('perfil-c3d4e5f6-7890-abcd-ef12-3456789abcde', 'c3d4e5f6-7890-abcd-ef12-3456789abcde', 'Qualidade de vida', 'Quarta tentativa', 'Resultados lentos', 'Muito apoio', 5, 8, 'Confiante', 'Pelos amigos', '2025-07-13 03:45:18+00', '2025-07-15 20:45:18+00'),
('perfil-d4e5f6a7-8901-bcde-f234-56789abcdef0', 'd4e5f6a7-8901-bcde-f234-56789abcdef0', 'Performance esportiva', 'Segunda tentativa', 'Lesão', 'Bom apoio', 3, 9, 'Focado', 'Pela recuperação', '2025-07-13 04:20:33+00', '2025-07-15 21:30:33+00'),
('perfil-e5f6a7b8-9012-cdef-3456-789abcdef012', 'e5f6a7b8-9012-cdef-3456-789abcdef012', 'Bem-estar geral', 'Primeira tentativa', null, 'Médio apoio', 8, 5, 'Ansiosa', 'Pelos pets', '2025-07-13 05:35:27+00', '2025-07-15 22:15:27+00')
ON CONFLICT (id) DO UPDATE SET
motivacao_principal = EXCLUDED.motivacao_principal,
tentativa_emagrecimento = EXCLUDED.tentativa_emagrecimento,
motivo_desistencia = EXCLUDED.motivo_desistencia,
apoio_familiar = EXCLUDED.apoio_familiar,
nivel_estresse = EXCLUDED.nivel_estresse,
nivel_autocuidado = EXCLUDED.nivel_autocuidado,
sentimento_hoje = EXCLUDED.sentimento_hoje,
gratidao_hoje = EXCLUDED.gratidao_hoje,
updated_at = EXCLUDED.updated_at;