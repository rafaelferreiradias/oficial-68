-- EXECUTAR BACKUP COMPLETO DOS DADOS
-- Inserir perfis de usuários
INSERT INTO profiles (id, user_id, full_name, email, celular, data_nascimento, sexo, altura_cm, role, created_at, updated_at) VALUES
('89d64df0-4171-4a44-9c98-2607a6f942a4', '71f53b82-a7f7-4257-9386-97a250277218', 'Bruno lima', 'tvmensal10@gmail.com', '11973125846', '2020-12-20', 'feminino', 120, 'client', '2025-07-14 22:31:49.162783+00', '2025-07-14 22:31:49.162783+00'),
('4fbd0728-fae2-41d3-b61e-55fee7e7e17f', 'cc282936-7bb4-483f-a436-d284e224d44d', 'lucas feliciano', 'lucasfelciano@gmail.com', '1989191923131', NULL, NULL, NULL, 'client', '2025-07-14 17:20:20.725039+00', '2025-07-14 17:20:20.725039+00'),
('c3682707-d0af-4cac-b8e1-055fd33b581e', 'c41bb952-75a3-40d4-9a14-959516d2edbc', 'marcos feliciano dias', 'marcosflicianodias@gmail.com', '119731125846', NULL, NULL, NULL, 'client', '2025-07-14 16:17:39.054116+00', '2025-07-14 16:17:39.054116+00'),
('d95e278e-27e7-4f9e-968e-d61134609cf3', '7b474c77-f0f9-45b0-8a8a-94e663bb266d', 'Maria Pereira', 'mariapereira@gmail.com', '19228282828', NULL, NULL, NULL, 'client', '2025-07-14 14:33:31.521739+00', '2025-07-14 14:33:31.521739+00'),
('e1eac262-c36a-45ff-b945-405951d725f3', '8107ba54-dc1d-4827-b0f7-fb85f418e860', 'russa ruussa', 'russa@gmail.com', '192192192192', NULL, NULL, NULL, 'client', '2025-07-14 09:10:59.52383+00', '2025-07-14 09:10:59.52383+00'),
('8fcdc37f-da5d-4156-a73d-4eaed612dac3', 'd4c7e35c-2f66-4e5d-8d09-c0ba8d0d7187', 'rafael', 'admin@instituto.com', NULL, '1220-02-10', 'feminino', 170, 'admin', '2025-07-13 23:06:27.612669+00', '2025-07-15 00:48:56.762438+00'),
('06b73ad1-017d-4bf9-9577-c396e02929ef', '7b594aa9-7dec-4df9-9827-e94bf2dc9c2d', 'jessica oliveira', 'jessica@gmail.com', '11971254913', '2000-02-10', 'feminino', 170, 'client', '2025-07-13 03:36:00.159889+00', '2025-07-14 18:10:27.896624+00'),
('7d47f700-9089-4135-b916-365d8cf78956', '193fb614-3e07-48fd-b839-a91505014d3e', 'lucas fabricio', 'lucas@gmail.com', NULL, '2000-07-15', 'masculino', 178, 'client', '2025-07-13 03:03:15.761458+00', '2025-07-14 18:54:58.996516+00'),
('7c9b2491-f9a7-4098-a28a-e6d7e8410714', '7d2df58b-64a9-478e-afa6-9ea1f66af4c3', 'Bruno perine', 'bruno@gmail.com', NULL, '2000-02-10', 'masculino', 155, 'client', '2025-07-13 01:31:42.847462+00', '2025-07-15 16:38:15.633853+00'),
('37c07834-f0f8-4285-a454-1a780cfb423b', '3101092a-83e5-48b5-83a4-280db2ad28f7', 'RAFAEL F', 'rafael@gmail.com', NULL, '1993-07-20', 'masculino', 168, 'client', '2025-07-13 00:56:47.831187+00', '2025-07-15 16:48:47.47108+00');

-- Inserir pontos dos usuários
INSERT INTO user_points (id, user_id, total_points, daily_points, weekly_points, monthly_points, current_streak, best_streak, completed_challenges, last_activity_date, created_at, updated_at) VALUES
('8944e2ea-e627-4354-b5a7-c47c553c0d81', '7c9b2491-f9a7-4098-a28a-e6d7e8410714', 115, 115, 115, 115, 1, 1, 0, '2025-07-13', '2025-07-13 01:34:43.409411+00', '2025-07-13 02:30:28.852036+00'),
('bd5bc3bd-350b-4e5d-a08d-caae245c8a6d', '06b73ad1-017d-4bf9-9577-c396e02929ef', 50, 50, 50, 50, 1, 1, 0, '2025-07-15', '2025-07-13 03:36:24.179716+00', '2025-07-15 14:44:46.812549+00');

-- Inserir dados físicos
INSERT INTO dados_fisicos_usuario (id, user_id, nome_completo, altura_cm, peso_atual_kg, circunferencia_abdominal_cm, data_nascimento, sexo, imc, categoria_imc, risco_cardiometabolico, meta_peso_kg, created_at, updated_at) VALUES
('f9d70213-9883-44e1-8ff7-735828c1b340', 'c8c593d0-c70c-4623-882e-a2644a562847', 'Luciano e murilo', 178, 90, 75, '1979-08-18', 'Feminino', 28.4055043555106678, 'Sobrepeso', 'Baixo', NULL, '2025-07-13 06:37:53.25856+00', '2025-07-13 06:37:53.25856+00'),
('cebc030b-86c0-4e18-b6e0-30f7b4f87aa3', 'e09e6a63-1109-46b9-ba9a-84ebe6fe3031', 'Junior dias', 190, 180, 170, '20000-10-10', 'Masculino', 49.8614958448753463, 'Obesidade grau III', 'Alto', NULL, '2025-07-13 05:57:21.455394+00', '2025-07-13 05:57:21.455394+00'),
('4e5765a5-f0dd-445e-9373-e0f93de51e16', '8524bde2-05ab-4469-9815-f1fe1f99126b', 'kiko', 180, 90, 119, '20000-09-09', 'Masculino', 27.7777777777777778, 'Sobrepeso', 'Alto', NULL, '2025-07-13 05:35:15.32547+00', '2025-07-13 05:35:15.32547+00'),
('781c776d-1fd2-4ece-a970-bafe2226858a', 'a5f2d558-f733-437a-ab33-3d9d30fbd0c0', 'surfa dias', 170, 89, 90, '1122-02-12', 'Outro', 30.7958477508650519, 'Obesidade grau I', 'Baixo', NULL, '2025-07-13 05:23:58.1777+00', '2025-07-13 05:23:58.1777+00'),
('2af44f49-98a3-4ef4-bc03-f626e0736b7b', '62290e6c-290d-4424-bdb3-b7276d490f46', 'BRUNA PERINE', 180, 90, 90, '20000-02-20', 'Masculino', 27.7777777777777778, 'Sobrepeso', 'Baixo', NULL, '2025-07-13 05:05:27.875067+00', '2025-07-13 05:05:27.875067+00'),
('edee8d33-267a-426d-aa08-1b3d72764cb4', '7fbfe4c3-dcde-4903-94dd-6a4c91921cf9', 'Lucas Silva', 175, 80, 90, '1993-07-20', 'Masculino', 26.1224489795918367, 'Sobrepeso', 'Baixo', NULL, '2025-07-13 04:44:14.467502+00', '2025-07-13 04:44:14.467502+00'),
('8b3dc9ae-cea2-4da2-899c-10ba1cecee70', '7d47f700-9089-4135-b916-365d8cf78956', 'Marcia', 190, 90, 140, '1993-07-20', 'Masculino', 24.9307479224376731, 'Peso normal', 'Alto', NULL, '2025-07-13 03:45:01.030069+00', '2025-07-13 03:45:01.030069+00');