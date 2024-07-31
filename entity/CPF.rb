class CPF
  # Método construtor para inicializar o atributo da classe CPF.
  # Parâmetro:
  # - cpf: uma string ou número que representa o CPF.
  def initialize(cpf)
    @cpf = cpf # Atribui o valor do CPF.
  end

  # Método para retornar o CPF formatado como uma string.
  # Retorna:
  # - Uma string com o CPF formatado (###.###.###-##) se tiver 11 dígitos.
  #   Caso contrário, retorna o CPF original.
  def to_s
    numbers = @cpf.to_s.gsub(/[^0-9]/, "").chars # Remove caracteres não numéricos e converte em array de caracteres.
    (numbers.length != 11) ? @cpf : "#{numbers[0..2].join}.#{numbers[3..5].join}.#{numbers[6..8].join}-#{numbers[9..10].join}"
  end

  # Método para retornar o CPF como um array de caracteres numéricos.
  # Retorna:
  # - Um array de caracteres numéricos representando o CPF, exceto o último caractere.
  def to_a
    @cpf.to_s.gsub(/[^0-9]/, "").chars[0..-2]
  end

  # Método para verificar se o CPF é válido.
  # Retorna:
  # - true se o CPF for válido, false caso contrário.
  def valid?
    cpf = @cpf.to_s.gsub(/[^0-9]/, "") # Remove caracteres não numéricos.

    # Verifica se o CPF tem exatamente 11 dígitos.
    return false unless cpf.match?(/^\d{11}$/)

    # Verifica se todos os dígitos são iguais.
    return false if cpf.chars.uniq.length == 1

    # Calcula o primeiro dígito verificador.
    sum = 0
    for i in 0..8
      sum += cpf[i].to_i * (10 - i)
    end
    first_digit = sum % 11
    first_digit = 0 if first_digit < 2
    first_digit = 11 - first_digit if first_digit >= 2

    # Verifica se o primeiro dígito verificador está correto.
    return false if first_digit != cpf[9].to_i

    # Calcula o segundo dígito verificador.
    sum = 0
    for i in 0..9
      sum += cpf[i].to_i * (11 - i)
    end
    second_digit = sum % 11
    second_digit = 0 if second_digit < 2
    second_digit = 11 - second_digit if second_digit >= 2

    # Verifica se o segundo dígito verificador está correto.
    second_digit == cpf[10].to_i
  end
end
