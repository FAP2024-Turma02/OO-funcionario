require './view/component/confirmation_dialog'

class ExitView
  # Método construtor para inicializar os atributos da classe ExitView.
  # Parâmetros:
  # - dialog: uma instância de ConfirmationDialog, com valor padrão de ConfirmationDialog.new.
  # - banner: uma instância de Banner, com valor padrão de Banner.new.
  def initialize(dialog: ConfirmationDialog.new, banner: Banner.new)
    @dialog = dialog # Atribui a instância do diálogo de confirmação.
    @banner = banner # Atribui a instância do banner.
    # Define a mensagem de prompt para o diálogo de confirmação.
    @dialog.set_prompt_message("Deseja votar novamente? [\e[32;1m(S)im\e[0m, \e[31;1m(N)ão\e[0m]")
  end

  # Método para iniciar a visualização de saída.
  def start
    system 'clear' # Limpa o console.
    @banner.display # Exibe o banner.
    @dialog.execute # Executa o diálogo de confirmação e espera pela resposta do usuário.
  end
end
