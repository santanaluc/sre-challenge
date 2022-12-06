## Sobre o Desafio: 

Esse é um teste feito para conhecer um pouco mais de cada candidato. Não é um teste objetivo e não há apenas uma solução que consideramos correta, o intuito é ser um estudo de caso com o propósito de conhecer o seu modo de trabalhar.

## Introdução

Temos neste repositório uma aplicação em Java com uma API REST que responde um Hello World quando recebe um GET na porta 8080. (ex: curl http://localhost:8080/)

## Tarefas: 

* US001 - Containerize essa aplicação. 
* US002 - Crie um Helm chart contendo todos os componentes necessários para essa aplicação rodar em um cluster de Kubernetes
* US003 - Crie uma instância EC2 utilizando um template de AWS CloudFormation ou Terraform.
* US004 - Acesse a instância EC2 criada e instale os componentes necessários para você subir a aplicação em um cluster Kubernetes (pode user o minikube).
* US005 - Aplique o chart criado e valide o funcionamento da aplicação.

Tarefa bônus - não obrigatória - apenas será um diferencial na sua entrega.
* USBONUS - Crie uma pipeline com AWS CodePipeline para automatizar a execução destes passos e subir essa infraestrutura na AWS.

## Alguma dicas que podem ser importantes:
* Qualidade da documentacão
* Utilizar boas práticas
* Organização do código
* Ser eficiente e simples

## Entrega do desafio:
Clone esse repositório e commite todas as modificações, depois que terminar, compacte o repositorio e nos envie, queremos analisar seus commits.