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

O laboratório é provisionado utilizando as ferramentas [**Virtual Box**](https://www.virtualbox.org/) e [**Vagrant**](https://www.vagrantup.com/).

É necessário a instalação dessas ferramentas para a criação do laboratório, sigam as instruções de instalação na documentação de cada ferramenta. Ambos são compatíveis com sistemas Windows, Linux e macOS.

### Motivação
Este laboratório foi criado com o intuito de ganhar tempo, padronização e praticidade na hora de montar o ambiente para aprendizado.

### O ambiente

1. VM master: Máquina virtual responsável por gerenciar o cluster Kubernetes.
2. VM worker-01 e worker-02: Máquinas responsáveis por executar containers no cluster.

### Requisitos
Para o bom funcionamento do ambiente, os requisistos **minímos** são:

```yaml
master:
  memória ram: 4GB
  vcpu: 2
  espaço em disco: 10GB

workers (cada):
  memória ram: 2GB
  vcpu: 1
  espaço em disco: 10GB
```

> Os recursos de memória ram e cpu podem ser alterados no arquivo `Vagrantfile` nas linhas que contenham as indicações `vb.memory` e `vb.cpus`.

Caso o ambiente com 02 workers fique muito pesado para o laboratório, é possível diminuir o número de workers para 01 dentro do arquivo `Vagrantfile`

```rb
- NUM_WORKER_NODES=2
+ NUM_WORKER_NODES=1
```

### Rede
É importante verificar o bloco de endereço IP que está em uso pelo VirtualBox, por padrão o script utiliza a rede "192.168.56.0/24".

```yaml
master: 192.168.56.10
worker-01: 192.168.56.11
worker-02: 192.168.56.12
```

### Comandos básicos para gerenciar o laboratório:
Para a inicialização do ambiente:
```sh
$ vagrant up
```
> O tempo médio da primeira incialização é de 10 a 15 minutos (dependendo da velocidade de conexão com a Internet).

Para acessar o cluster:
```sh
$ vagrant ssh master
```

Após o acesso ao ambiente, abra o diretório `/vagrant` para começar os execícios.
```sh
$ cd /vagrant
```

Para desligar o ambiente:
```sh
$ vagrant halt
```

Para remoção completa do ambiente:
```sh
$ vagrant destroy
```
> Esse comando removerá a vm por completa do Virtual Box, no entanto, o conteúdo do diretório `/vagrant` da vm ficará disponível neste diretório de forma intacta.

