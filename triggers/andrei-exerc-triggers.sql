/* Exercício - Triggers */

USE escola3;

/* A. Criar um gatilho chamado subtrair alunos da aula, que será executado após a
	  ação de exclusão na tabela de chamadas. O gatilho em questão irá
	  decrementar a quantidade de alunos presentes na aula. */

/* B. Criar e executar um comando SQL que dispare o gatilho criado acima. */

/* C. Criar uma tabela chamada alteracoes_chamada, com os campos ID, ID da
	  chamada, quantidade de faltas anterior e nova quantidade de faltas. Preste
	  atenção nas chaves estrangeiras. */

/* D. Criar uma trigger chamada guardar_alteracao_chamada, que será executado
	  após updates na tabela de chamadas, o qual irá inserir na tabela
	  alteracoes_chamada o ID da chamada alterada, a quantidade de faltas antiga
	  e a quantidade de faltas nova. */

/* E. Criar e executar um comando SQL que dispare a trigger
	  guardar_alteracao_chamada. */
