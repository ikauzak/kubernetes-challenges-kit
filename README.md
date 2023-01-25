## O que é este repositório?

Este repositório armazena diversos exercícios para a fixação dos conceitos básicos Kubernetes, juntamente com um laboratório pré criado para ser executado em máquina virtual.

## Objetivo

O objetivo é utilizar esse material como um apoio para os alunos que se interessam por Kubernetes, passando alguns desafios aos quais possam tentar resolver por conta própria.

Arquivos de exemplos do diretório `apostila`:
```sh
.
├── atividades
│   ├── 1
│   │   └── task-01.yaml
│   ├── 2
│   ├── 3
│   ├── 4
│   │   ├── order-credentials.yaml
│   │   └── order-processing.yaml
│   ├── 5
│   │   └── ingress.yaml
│   ├── 6
│   └── poupadev-api
│       ├── deploy.yaml
│       ├── ingress.yaml
│       └── service.yaml
├── capítulo-2
│   └── 1
│       └── multi-resources.yaml
├── capítulo-3
│   └── 1
│       ├── daemonset.yaml
│       ├── deploy.yaml
│       └── pod.yaml
├── capítulo-4
│   ├── 1
│   │   ├── game-config-env-file.yaml
│   │   ├── game-config-env-pod.yaml
│   │   ├── game-config-file.yaml
│   │   ├── game-config-multi-env-pod.yaml
│   │   ├── game-config-multi-env.yaml
│   │   └── game-config-pod.yaml
│   └── 2
│       ├── dbcredentials-env-pod.yaml
│       ├── dbcredentials.yaml
│       ├── pod-pullsecret.yaml
│       └── registry.yaml
├── capítulo-5
│   ├── 1
│   │   └── resources.yaml
│   └── 2
│       ├── http-probe.yaml
│       └── probes.yaml
└── capítulo-6
    ├── 1
    │   ├── app.yaml
    │   ├── service-clusterip.yaml
    │   └── service-nodeport.yaml
    └── 2
        └── ingress.yaml
```

## Laboratório

O laboratório é provisionado na nuvem Azure, assim os usuários poderão acessar o ambiente remoto sem a necessidade de dispor de recursos locais para o aprendizado.

### Acessando o ambiente

O ambiente será liberado pelo instrutor somente durante o horário da aula.

1. Inicialize o container toolbox mapeando o volume deste repositório em `/app`. Este container possui as ferramentas necessárias para o acesso ao laboratório.
```sh
$ docker run -it --rm --network=host -v $(pwd):/app ikauzak/toolbox:latest
```

2. Ao acessar o ambiente, faça o `az login` e autentique com as credencias fornecidas pelo instrutor.
```sh
# az login
To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code XXXXXX to authenticate.

# az aks get-credentials --resource-group NOME_DO_RECURSO --name NOME_DO_CLUSTER

# kubelogin convert-kubeconfig -l azurecli
```

3. A partir deste momento, o seu usuário estará autenticado no ambiente para iniciar o laboratório.

4. Crie a sua namespace no cluster para iniciar as atividades:

```
# kubectl create ns MINHA_NOVA_NAMESPACE
# kn MINHA_NOVA_NAMESPACE
```
