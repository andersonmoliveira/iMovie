# iMovie

Um aplicativo iOS de listagem de filmes, desenvolvido em Swift com UIKit e arquitetura MVVM. O app consome dados de uma API REST aberta e exibe filmes em uma interface de fácil navegação, com suporte a paginação e pull-to-refresh.

O projeto foi **modularizado**, seguindo boas práticas de arquitetura, separando responsabilidades em bibliotecas distintas para maior reutilização e manutenção.

---

## Contexto do Problema

Ao trabalhar com listas de filmes que possuem imagens (posters) carregadas da internet, surgem alguns desafios comuns:

- **Reuso de células**: Ao usar `UICollectionView` ou `UITableView`, células são reutilizadas. Se o download das imagens não for controlado, a célula pode exibir a imagem de outro filme enquanto a nova imagem é carregada, causando um efeito visual confuso.
- **Paginação e carregamento incremental**: Listas grandes de filmes podem ser pesadas para carregar de uma só vez, tornando necessário buscar dados em páginas.
- **Atualização e UX**: O usuário precisa ver quando novos dados estão sendo carregados, além de poder atualizar a lista facilmente.

---

## Solução Proposta

O iMovie implementa soluções para esses problemas:

1. **Modularização do projeto**  
   - **CoreUIKit**: biblioteca modular com componentes visuais reutilizáveis, como cards de filmes, placeholders e loaders.  
   - **CoreNetwork**: biblioteca responsável por todos os serviços de rede, encapsulando requisições HTTP, parsing de dados e tratamento de erros.  
   - Ambas as bibliotecas são integradas via **Swift Package Manager (SPM)**, facilitando reutilização em outros projetos e manutenção do código.

2. **Testes automatizados**  
   - **CoreUIKit**: testada com **Snapshot Testing**, garantindo que os componentes visuais renderizem corretamente em diferentes estados e modos (light/dark).  
   - **CoreNetwork**: testada com **unit tests**, garantindo que os serviços de rede, parsing e tratamento de erros funcionem corretamente.

3. **Download de imagens seguro**  
   Cada célula verifica se a imagem recebida corresponde ao filme atual antes de atualizar a interface, evitando que a imagem troque indevidamente devido ao reuso de células. Além disso, a aplicação pode utilizar cache para melhorar performance e reduzir consumo de rede.

4. **Paginação incremental**  
   Ao rolar até o fim da lista, o app busca automaticamente a próxima página de filmes da API. A primeira página pode ser recarregada através do pull-to-refresh.

5. **Pull-to-refresh**  
   Permite ao usuário atualizar a lista e resetar a paginação, garantindo que sempre veja os filmes mais recentes.

6. **Tratamento de erros com alertas**  
   Caso ocorra um erro de rede ou falha na API, o usuário é notificado através de alertas amigáveis, com a opção de tentar novamente.

7. **Uso de GCD e Swift Concurrency**  
   - **Swift Concurrency (`async/await`)** é utilizado para buscar dados da API e baixar imagens de forma assíncrona, garantindo código mais legível e evitando callback hell.  
   - **GCD (`DispatchQueue`)** é utilizado para atualizar a interface de forma segura na main thread, garantindo que operações de UI não sejam executadas em background threads.

---

## Tecnologias Utilizadas

- Swift 5
- UIKit
- MVVM
- Swift Package Manager (SPM)
- CoreUIKit (componentes visuais) com Snapshot Testing
- CoreNetwork (serviços de rede) com Unit Tests
- Concurrency com async/await e GCD
- UICollectionView com cells reutilizáveis e carregamento incremental

---

## Funcionalidades

- Listagem de filmes com posters e títulos.
- Paginação automática conforme o usuário rola a tela.
- Pull-to-refresh para atualizar a lista.
- Download seguro de imagens com controle de reuso de células.
- Exibição de alertas em caso de erros.
- Modularização com CoreUIKit e CoreNetwork.
- Uso de Swift Concurrency e GCD para operações assíncronas e updates de UI seguros.
- Testes automatizados garantindo qualidade das bibliotecas.

---

## Como Rodar

1. Clone o repositório:
   ```bash
   git clone https://github.com/andersonmoliveira/iMovie.git

## Como Testar o App

Para testar o iMovie, é necessário obter uma **API Key** do The Movie Database (TMDb), que será utilizada para acessar os dados da API de filmes.

### Passo 1: Criar uma conta no TMDb

1. Acesse o site do TMDb: [https://www.themoviedb.org/](https://www.themoviedb.org/)
2. Clique em **"Login"** e depois em **"Sign Up"** para criar uma conta gratuita.
3. Complete o cadastro e confirme seu e-mail.

---

### Passo 2: Gerar uma API Key

1. Faça login na sua conta TMDb.
2. Clique na sua foto de perfil → **Settings** → **API**.
3. Na seção **API Key (v3)**, clique em **"Create"** para gerar uma nova chave.
4. Preencha os campos solicitados (nome do projeto, finalidade, etc.) e aceite os termos.
5. Copie a chave gerada (algo como `1234567890abcdef1234567890abcdef`).

---

### Passo 3: Configurar a API Key no projeto

O iMovie utiliza um arquivo de configuração `Keys.xcconfig` para armazenar a API Key de forma segura, sem expor diretamente no código fonte.

1. Abra o projeto no Xcode.
2. Localize o arquivo `Keys.xcconfig` no projeto, localizado na pasta `AppSetupFiles`.
3. Abra o arquivo e adicione a seguinte linha, substituindo `<SUA_API_KEY>` pela chave gerada:

```text
API_KEY = <SUA_API_KEY>
```

---

## Melhorias Futuras

Com mais tempo de desenvolvimento, algumas melhorias poderiam ser implementadas para tornar o iMovie ainda mais robusto e profissional:

1. **Tela de Detalhes dos Filmes usando Coordinator**  
   - Atualmente, o app mostra apenas a lista de filmes.  
   - Com um **Coordinator**, seria possível criar uma navegação modular e desacoplada para a tela de detalhes, onde o usuário poderia ver sinopse, avaliações, trailers e outras informações do filme.

2. **Cancelamento de Tasks de download de imagens**  
   - Para otimizar recursos e evitar downloads desnecessários, as `Task`s de download de imagens poderiam ser canceladas no `prepareForReuse` das células.  
   - Isso reduziria consumo de CPU/memória e evitaria atualizações de UI desnecessárias em células que já foram reutilizadas.

3. **Loading Footer para paginação**  
   - Atualmente, a paginação acontece automaticamente, mas o usuário não vê um indicador visual de carregamento no final da lista.  
   - Um **footer com spinner** mostraria claramente quando mais filmes estão sendo carregados, melhorando a experiência do usuário.

4. **Outras possíveis melhorias**  
   - Implementar filtros por gênero ou classificação.  
   - Suporte a pesquisa por título de filme.

Essas melhorias ajudariam a tornar o app mais completo, responsivo e escalável, seguindo boas práticas de arquitetura e UX.

---

## Agradecimentos

Este projeto foi desenvolvido como parte de um **processo seletivo para a vaga de Desenvolvedor iOS Especialista na iFood**.  

Agradeço à empresa iFood pela oportunidade de propor soluções técnicas, demonstrar boas práticas de desenvolvimento iOS e trabalhar com arquiteturas modernas, modularização e boas práticas de testes.  

Também agradeço à comunidade iOS e a todas as referências open-source que serviram de inspiração durante o desenvolvimento deste projeto.
