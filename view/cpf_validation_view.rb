require './view/component/banner'
require './entity/CPF'

class CPFValidationView
  # Método construtor para inicializar os atributos da classe CPFValidationView.
  # Parâmetros:
  # - validation_service: uma instância do serviço de validação de CPF.
  # - banner: uma instância da classe Banner, com valor padrão de Banner.new.
  def initialize(validation_service, banner: Banner.new)
    @validation_service = validation_service # Atribui a instância do serviço de validação de CPF.
    @banner = banner # Atribui a instância do banner.
    @actions = {
      invalid: method(:show_invalid_cpf_error), # Mapeia o símbolo :invalid ao método show_invalid_cpf_error.
      already_voted: method(:show_already_voted_error) # Mapeia o símbolo :already_voted ao método show_already_voted_error.
    }
  end

  # Método para iniciar a visualização e validação do CPF.
  def start
    loop do
      system 'clear' # Limpa o console.
      @banner.display # Exibe o banner.
      print "Digite seu \e[1;35mCPF\e[0m para votar: "
      raw_cpf = gets.chomp # Lê a entrada do usuário.

      validation_result = @validation_service.validate(raw_cpf) # Valida o CPF.
      return CPF.new(raw_cpf) if validation_result == :valid # Retorna uma instância de CPF se for válido.

      @actions[validation_result].call(raw_cpf) # Chama o método apropriado de acordo com o resultado da validação.
    end
  end

  private

  # Método para exibir a mensagem de erro de CPF inválido.
  # Parâmetro:
  # - cpf: o CPF inválido digitado pelo usuário.
  def show_invalid_cpf_error(cpf)
    puts "\nO CPF #{cpf} é \e[1;31minválido\e[0m!\nVerifique os \e[1;33mnúmeros digitados\e[0m e \e[1;32mtente novamente\e[0m."
    sleep 5 # Espera por 5 segundos antes de continuar.
  end

  # Método para exibir a mensagem de erro de CPF já votado.
  # Parâmetro:
  # - cpf: o CPF que já votou.
  def show_already_voted_error(cpf)
    puts "\nO CPF #{cpf} já \e[1;31mvotou\e[0m."
    sleep 5 # Espera por 5 segundos antes de continuar.
  end
end
