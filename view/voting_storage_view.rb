require './service/voting_storage_service'

class VotingStorageView
  # Método construtor para inicializar os atributos da classe VotingStorageView.
  # Parâmetros:
  # - voting_storage: uma instância do serviço de armazenamento de votos.
  # - banner: uma instância da classe Banner, com valor padrão de Banner.new.
  def initialize(voting_storage, banner: Banner.new)
    @voting_storage = voting_storage # Atribui a instância do serviço de armazenamento de votos.
    @banner = banner # Atribui a instância do banner.
  end

  # Método para iniciar a visualização de armazenamento de votos.
  def start
    system 'clear' # Limpa o console.
    @banner.display # Exibe o banner.
    puts "Voto Registrado com \e[1;32msucesso\e[0m!" # Exibe uma mensagem de sucesso, com parte da mensagem colorida em verde.
    sleep 3 # Espera por 3 segundos antes de continuar.
  end
end
