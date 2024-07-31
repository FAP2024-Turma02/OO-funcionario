class Candidate
  attr_reader :name, :color

  # Método construtor para inicializar os atributos da classe Candidate.
  # Parâmetros:
  # - name: o nome do candidato.
  # - color: um objeto cor associado ao candidato.
  # - char: um caractere especial opcional usado para decoração (valor padrão é '★').
  def initialize(name, color, char = '★')
    @name = name   # Atribui o nome do candidato.
    @color = color # Atribui a cor do candidato.
    @char = char   # Atribui o caractere especial para decoração.
  end

  # Método para retornar o nome do candidato com um fundo colorido.
  # Parâmetros:
  # - size: um valor opcional para centralizar a string (valor padrão é 0).
  # Retorna:
  # - Uma string com o nome do candidato colorido e decorado.
  def name_with_background(size = 0)
    # "\e[38;2;..." é uma sequência ANSI para definir a cor de primeiro plano.
    # "\e[48;2;..." é uma sequência ANSI para definir a cor de fundo.
    # "\e[0m" redefine as cores para os valores padrões.
    "\e[38;2;#{@color.foreground_a.join(';')}m\e[48;2;#{@color.to_a.join(';')}m#{(@char + " #{@name} " + @char).center(size)}\e[0m"
  end

  # Método para retornar o nome do candidato apenas com a cor do texto.
  # Parâmetros:
  # - size: um valor opcional para centralizar a string (valor padrão é 0).
  # Retorna:
  # - Uma string com o nome do candidato colorido.
  def name_with_color(size = 0)
    # "\e[38;2;..." é uma sequência ANSI para definir a cor de primeiro plano.
    # "\e[0m" redefine as cores para os valores padrões.
    "\e[38;2;#{@color.to_a.join(';')}m#{@name.center(size)}\e[0m"
  end
end
