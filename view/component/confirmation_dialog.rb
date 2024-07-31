class ConfirmationDialog
  # Método construtor para inicializar os atributos da classe ConfirmationDialog.
  # Parâmetros:
  # - prompt_message: mensagem que será exibida ao usuário para confirmação (padrão é uma string vazia).
  # - invalid_option_message: mensagem que será exibida ao usuário se a opção for inválida (padrão é uma mensagem de opção inválida em vermelho).
  def initialize(prompt_message: '', invalid_option_message: "\nOpção \e[31;1mInválida\e[0m.\n")
    @prompt_message = prompt_message # Atribui a mensagem de prompt.
    @invalid_option_message = invalid_option_message # Atribui a mensagem de opção inválida.
  end

  # Método para executar o diálogo de confirmação.
  # Retorna:
  # - true se o usuário confirmar com "s".
  # - false se o usuário rejeitar com "n".
  def execute
    loop do
      print @prompt_message # Exibe a mensagem de prompt.
      case gets.chomp.downcase[0] # Lê a entrada do usuário, remove espaços em branco e converte para minúscula.
      when 's'
        return true # Retorna true se o usuário digitar "s".
      when 'n'
        return false # Retorna false se o usuário digitar "n".
      else
        print @invalid_option_message # Exibe a mensagem de opção inválida se a entrada não for "s" ou "n".
      end
    end
  end

  # Método para definir uma nova mensagem de prompt.
  # Parâmetro:
  # - prompt_message: nova mensagem de prompt.
  def set_prompt_message(prompt_message)
    @prompt_message = prompt_message
  end
end
