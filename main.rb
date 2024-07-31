# Imports das Views
require './view/voting_view'           # Importa a classe VotingView, responsável pela interface de votação.
require './view/voting_storage_view'   # Importa a classe VotingStorageView, responsável por exibir a confirmação de voto registrado.
require './view/cpf_validation_view'   # Importa a classe CPFValidationView, responsável pela validação do CPF do usuário.
require './view/exit_view'             # Importa a classe ExitView, responsável por perguntar ao usuário se deseja votar novamente.
require './view/result_view'           # Importa a classe ResultView, responsável por exibir os resultados finais da votação.

# Imports dos Services
require './service/bloom_filter_service' # Importa a classe BloomFilterService, responsável pela filtragem de votos utilizando Bloom Filter.
require './service/cpf_validation_service' # Importa a classe CPFValidationService, responsável pela validação do CPF.
require './service/voting_storage_service' # Importa a classe VotingStorageService, responsável por armazenar e gerenciar os votos.

class VotingApplication
  # Método construtor para inicializar os serviços e views.
  def initialize
    # Inicializa o serviço de Bloom Filter para verificar se um CPF já votou.
    @bloom_filter_service = BloomFilterService.new

    # Inicializa o serviço de armazenamento de votos, passando o serviço de Bloom Filter como dependência.
    @voting_storage_service = VotingStorageService.new(@bloom_filter_service)

    # Inicializa o serviço de validação de CPF, passando o serviço de Bloom Filter como dependência.
    @cpf_validation_service = CPFValidationService.new(@bloom_filter_service)

    # Inicializa a view de validação de CPF, passando o serviço de validação de CPF.
    @cpf_validation_view = CPFValidationView.new(@cpf_validation_service)

    # Inicializa a view de confirmação de registro de voto, passando o serviço de armazenamento de votos.
    @voting_storage_view = VotingStorageView.new(@voting_storage_service)

    # Inicializa a view de votação.
    @voting_view = VotingView.new

    # Inicializa a view de confirmação para votar novamente.
    @exit_view = ExitView.new

    # Inicializa a view de exibição de resultados finais, passando o serviço de armazenamento de votos.
    @Result_view = ResultView.new(@voting_storage_service)
  end

  # Método para executar a aplicação de votação.
  def run
    loop do
      # Inicia a visualização de validação de CPF e obtém o CPF validado.
      cpf = @cpf_validation_view.start

      # Inicia a visualização de votação e obtém o número do candidato escolhido.
      candidate = @voting_view.start

      # Registra o voto no serviço de armazenamento de votos.
      @voting_storage_service.record_vote(cpf, candidate)

      # Inicia a visualização de confirmação de voto registrado.
      @voting_storage_view.start

      # Pergunta ao usuário se deseja votar novamente e sai do loop se a resposta for não.
      break unless @exit_view.start
    end

    # Exibe o hash com os votos registrados.
    puts @voting_storage_service.votes

    # Inicia a visualização dos resultados finais da votação.
    @Result_view.start
  end
end

# Executa o aplicativo de votação
$voting_app = VotingApplication.new # Cria uma nova instância da aplicação de votação.
$voting_app.run # Inicia a execução da aplicação de votação.
