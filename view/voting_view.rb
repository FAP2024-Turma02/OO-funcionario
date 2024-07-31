require './view/component/banner'
require './view/component/confirmation_dialog'
require './service/voting_service'

class VotingView
  # Método construtor para inicializar os atributos da classe VotingView.
  # Parâmetros:
  # - dialog: uma instância da classe ConfirmationDialog, com valor padrão de ConfirmationDialog.new.
  # - banner: uma instância da classe Banner, com valor padrão de Banner.new.
  # - service: uma instância da classe VotingService, com valor padrão de VotingService.new.
  def initialize(dialog: ConfirmationDialog.new, banner: Banner.new, service: VotingService.new)
    @dialog = dialog # Atribui a instância do diálogo de confirmação.
    @banner = banner # Atribui a instância do banner.
    @service = service # Atribui a instância do serviço de votação.
  end

  # Método para iniciar a visualização de votação.
  def start
    loop do
      display_candidate_list # Exibe a lista de candidatos.

      option_selected = gets.chomp # Obtém a opção selecionada pelo usuário.

      candidate = @service.select_candidate(option_selected) # Seleciona o candidato com base na opção escolhida.

      # Confirma o voto e retorna a opção selecionada se o voto for confirmado.
      return option_selected if confirm_vote(candidate)
    end
  end

  private

  # Método para exibir a lista de candidatos.
  def display_candidate_list
    system 'clear' # Limpa o console.
    @banner.display # Exibe o banner.
    VotingService::CANDIDATES.each_with_index do |(number, candidate), index|
      display_candidate(number, candidate) # Exibe informações sobre cada candidato.
      puts '' if index == 1 # Adiciona uma linha em branco após o segundo candidato.
    end

    print "\nPor favor, escolha uma \e[1;34mopção\e[0m: " # Solicita ao usuário que escolha uma opção.
  end

  # Método para exibir as informações de um candidato.
  # Parâmetros:
  # - number: o número do candidato.
  # - candidate: a instância do candidato.
  def display_candidate(number, candidate)
    puts "\e[1;34m#{''.ljust(11) + number.to_s.ljust(2)}\e[0m ➤ #{candidate.name_with_background(24)}" # Exibe o número do candidato e o nome com fundo colorido.
  end

  # Método para confirmar o voto do usuário.
  # Parâmetros:
  # - candidate: a instância do candidato selecionado.
  # Retorna true se o voto for confirmado, false caso contrário.
  def confirm_vote(candidate)
    # Cria a mensagem de confirmação, destacando o nome do candidato.
    confirmation_message = "\nConfirma o voto#{unless candidate.name == 'Nulo'
                                                 ' em'
                                               end} \e[36;1m#{candidate.name}\e[0m? [\e[32;1m(S)im\e[0m, \e[31;1m(N)ão\e[0m]"
    @dialog.set_prompt_message(confirmation_message) # Define a mensagem de confirmação no diálogo.

    @dialog.execute # Executa o diálogo de confirmação e retorna a resposta do usuário.
  end
end
