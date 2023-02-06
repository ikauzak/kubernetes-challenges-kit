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
│   └── awesome-social-media
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

## Criação do ambiente

No diretório `cluster`, está um código escrito em **Terraform** para o provisionamento de um cluster Kubernetes básico. A sua inicialização pode ser feita de maneira simples seguindo essas etapas:

### Pré requisitos

Para o provisionamento deste ambiente, você precisará instalar o **Terraform** em seu local de trabalho. Siga as seguintes etapas:

1. [Acesse este link](https://developer.hashicorp.com/terraform/downloads) para baixar a versão mais atualizada do **Terraform**.

2. Escolha a versão apropriada do seu Sistema Operacional (Windows, Linux ou macOS), e em seguida o tipo de binário do seu sistema (386 ou AMD64)

3. Siga as instruções da [documentação](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform) de instalação do **Terraform**

4. Em caso de seu sistema operacional for **Windows** veja a resolução deste [link](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform) para configurar PATH no seu sistema através da interface.

5. Configure o `az login` em seu ambiente de trabalho fazendo os seguintes passos:

```sh
$ az login
```

Ao autenticar com sua conta, você pode confirmar o *subscription* da sua conta usando:

```sh
$ az account list
```

Uma segunda opção para autenticação é utilizando um [Service Principal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret) com a permissão de `Contributor`

6. Faça o download do **kubectl** através do [link](https://kubernetes.io/docs/tasks/tools/#kubectl) e siga as instruções do sistema operacional escolhido.

> Caso prefira executar o **kubectl** em container, siga as instruções na sessão [Acessando o ambiente](#acessando-o-ambiente).

> Importante notar que o seu usuário precisa de no mínimo privilégios de `Contributor` na conta Azure.

### Ajustes básicos

Antes de iniciar o script, precisamos revisar e reconfigurar algumas variáveis:

1. Acesse o diretório `cluster` e localize o arquivo `variables.tf`

2. Substitua os valores **null** das variaveis `cluster_location` e `cluster_resource_group_name`. Por exemplo:

```terraform
variable "cluster_location" {
  type        = string
  description = "Nome da localização do cluster e dos recursos"
  default     = "brazilsouth"
}

variable "cluster_resource_group_name" {
  type        = string
  description = "Nome do resource group do cluster"
  default     = "meu-resource-group"
}
```
> Importante destacar que o custo do seu ambiente pode variar conforme a localização do cluster, consulte com mais detalhes sobre as regiões do Azure.

3. A restante das variáveis já estão pré-definidas com valores iniciais para o provisionamento do ambiente. Caso deseje alterar o tamanho das máquinas do cluster, nome ou quantidade de máquinas, você também pode alterar as variáveis que são responsáveis por definirem essa infraestrutra:

```terraform 
variable "cluster_name" {
  type        = string
  description = "Nome do cluster a ser criado"
  default     = "mycluster"
}

variable "nodepool_vm_size" {
  type        = string
  description = "Tipo de vm do nodepool de sistema padrão"
  default     = "Standard_B4ms"
}

variable "nodepool_min_count" {
  type        = number
  description = "Minimo de nodes a serem criados no nodepool"
  default     = 1
}

variable "nodepool_max_count" {
  type        = number
  description = "Máximo de nodes a serem criados no nodepool"
  default     = 3
}
```

### Inicialização e criação

Para inicializar a sua criação:

```sh
$ terraform init
```

Faça um *plan* dos recursos a serem criados:

```sh
$ terraform plan
```

Provisione o ambiente ao aceitar o comando:

```sh
$ terraform apply
```

O laboratório leva em média de 10 minutos para ficar pronto.

### Acessando o ambiente

#### Método local
1. Execute o comando a baixo para resgatar as credenciais do cluster:

```sh
$ az aks get-credentials --resource-group NOME_DO_RESOURCE_GROUP --name NOME_DO_CLUSTER
```

2. Se tudo ocorrer bem, o seu terminal estará conectado no custer. Experimente usar um comando básico para testar a sua conectividade.

```sh
$ kubectl get nodes
```

#### Método via container

1. Inicialize o container toolbox mapeando o volume deste repositório em `/app`. Este container possui as ferramentas necessárias para o acesso ao laboratório.
```sh
$ docker run -it --rm --network=host -v $(pwd):/app ikauzak/toolbox:latest
```

2. Ao acessar o ambiente, faça o `az login` e autentique com as credencias fornecidas pelo instrutor.
```sh
# az login
To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code XXXXXX to authenticate.

# az aks get-credentials --resource-group NOME_DO_RECURSO --name NOME_DO_CLUSTER
```

3. A partir deste momento, o seu usuário estará autenticado no ambiente para iniciar o laboratório.

4. Crie a sua namespace no cluster para iniciar as atividades:

```
# kubectl create ns MINHA_NOVA_NAMESPACE
# kn MINHA_NOVA_NAMESPACE
```
