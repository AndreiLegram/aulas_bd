USE escola_db;

INSERT INTO areas VALUES
(1000000, 'Sistemas'),
(2000000, 'Matemática'),
(3000000, 'Linguagens'),
(4000000, 'Física');

INSERT INTO cidades VALUES
(1100000, 'Bento Gonçalves', 'RS'),
(2200000, 'Florianópolis', 'SC'),
(3300000, 'Curitiba', 'PR'),
(4400000, 'Porto Alegre', 'RS');

INSERT INTO professores VALUES
(1010000, 'Ronaldo Serpa da Rosa', '12814187066', STR_TO_DATE('09/09/1970','%d/%m/%Y'), 'ronaldo.rosa@bento.ifrs.edu.br', 'Bento Gonçalves', '123', '', '', 1100000, 3000000),
(2020000, 'Thyago Salvá', '06431967062', STR_TO_DATE('04/05/1977','%d/%m/%Y'), 'thyago.salva@bento.ifrs.edu.br', 'Bento Gonçalves', '123', '', '', 2200000, 2000000),
(3030000, 'Mauricio Rosito', '42433391040', STR_TO_DATE('12/12/1974','%d/%m/%Y'), 'mauricio.rosito@bento.ifrs.edu.br', 'Bento Gonçalves', '123', '', '', 3300000, 1000000),
(4040000, 'Ivan Prá', '04687628095', STR_TO_DATE('12/10/1968','%d/%m/%Y'), 'ivan.pra@bento.ifrs.edu.br', 'Bento Gonçalves', '123', '', '', 4400000, 1000000),
(5050000, 'Delair Oliveira', '81691081019', STR_TO_DATE('05/04/1988','%d/%m/%Y'), 'delair.oliveira@bento.ifrs.edu.br', 'Bento Gonçalves', '123', '', '', 3300000, 2000000),
(6060000, 'Diego da Silva', '82537484002', STR_TO_DATE('02/02/1980','%d/%m/%Y'), 'diego.silva@bento.ifrs.edu.br', 'Bento Gonçalves', '123', '', '', 2200000, 3000000),
(7070000, 'Paulo Rocha', '79357502033', STR_TO_DATE('10/01/1990','%d/%m/%Y'), 'paulo.rocha@bento.ifrs.edu.br', 'Bento Gonçalves', '123', '', '', 1100000, 4000000),
(8080000, 'Lissandra Lazza', '52144978069', STR_TO_DATE('10/01/1960','%d/%m/%Y'), 'lissandra.lazza@bento.ifrs.edu.br', 'Bento Gonçalves', '123', '', '', 1100000, 4000000);

INSERT INTO alunos VALUES
(1001000, 'Andrei Legramante', '59620213041', STR_TO_DATE('05/01/2003','%d/%m/%Y'), 'andrei.legramante@gmail.com', 'Bento Gonçalves', '123', '', '', 1100000),
(2002000, 'Pedro Ferrari', '17959849021', STR_TO_DATE('11/04/2004','%d/%m/%Y'), 'pedro.ferrari@gmail.com', 'Bento Gonçalves', '123', '', '', 2200000),
(3003000, 'Bernardo Marquetti', '82086396058', STR_TO_DATE('25/09/2004','%d/%m/%Y'), 'bernardo.marquetti@gmail.com', 'Bento Gonçalves', '123', '', '', 3300000),
(4004000, 'Sednei Rossetti', '68856354055', STR_TO_DATE('21/02/2002','%d/%m/%Y'), 'sednei.rossetti@gmail.com', 'Bento Gonçalves', '123', '', '', 4400000),
(5005000, 'Jeniffer Carvalho', '46395289063', STR_TO_DATE('02/10/2004','%d/%m/%Y'), 'roberto.caralho@gmail.com', 'Bento Gonçalves', '123', '', '', 1100000),
(6006000, 'Gabriel Netto', '94687338070', STR_TO_DATE('17/12/2003','%d/%m/%Y'), 'gabriel.netto@gmail.com', 'Bento Gonçalves', '123', '', '', 2200000),
(7007000, 'Gabriel Minetto', '57434037083', STR_TO_DATE('12/06/2005','%d/%m/%Y'), 'gabriel.minetto@gmail.com', 'Bento Gonçalves', '123', '', '', 1100000),
(8008000, 'XXX', '00524629005', STR_TO_DATE('12/06/2005','%d/%m/%Y'), 'gabriel.minetto@gmail.com', 'Bento Gonçalves', '123', '', '', 1100000);

INSERT INTO disciplinas VALUES
(1000100, 'Orientação a Objetos'),
(2000200, 'Modelagem de Software'),
(3000300, 'Banco de Dados'),
(4000400, 'Estatística Aplicada'),
(5000500, 'Álgebra Linear'),
(6000600, 'Português'),
(7000700, 'Inglês'),
(8000800, 'Óptica'),
(9000900, 'Cinemática');

INSERT INTO turmas VALUES
(1000010, '1º ano Info','2020'),
(2000020, '1º ano Info','2021'),
(3000030, '1º ano Info','2022'),
(4000040, '2º ano Info','2020'),
(5000050, '2º ano Info','2021'),
(6000060, '2º ano Info','2022'),
(7000070, '3º ano Info','2020'),
(8000080, '3º ano Info','2021'),
(9000090, '3º ano Info','2022');

INSERT INTO alunos_turmas VALUES
(3000030, 6006000),
(3000030, 7007000),
(2000020, 1001000),
(2000020, 2002000),
(6000060, 1001000),
(6000060, 2002000),
(1000010, 4004000),
(1000010, 5005000),
(5000050, 4004000),
(5000050, 5005000),
(9000090, 4004000),
(9000090, 5005000),
(1000010, 8008000);

INSERT INTO disciplinas_turmas VALUES
(3000030, 1000100),
(3000030, 2000200),
(3000030, 3000300),
(6000060, 1000100),
(6000060, 2000200),
(6000060, 3000300),
(9000090, 1000100),
(9000090, 2000200),
(9000090, 3000300),
(1000010, 4000400),
(1000010, 6000600),
(1000010, 8000800);
