class Color
  attr_reader :r, :g, :b

  # Método construtor para inicializar os atributos da classe Color.
  # Parâmetros:
  # - r: valor do componente vermelho da cor (0-255).
  # - g: valor do componente verde da cor (0-255).
  # - b: valor do componente azul da cor (0-255).
  def initialize(r, g, b)
    @r = r # Atribui o valor do componente vermelho.
    @g = g # Atribui o valor do componente verde.
    @b = b # Atribui o valor do componente azul.

    # Calcula a intensidade da cor usando a fórmula de luminância percebida.
    intensity = r * 0.299 + g * 0.587 + b * 0.114

    # Define a cor de primeiro plano (preto ou branco) com base na intensidade.
    # Se a intensidade for maior que 186, a cor de primeiro plano será preta (0, 0, 0).
    # Caso contrário, a cor de primeiro plano será branca (255, 255, 255).
    @foreground = Array.new(3, intensity > 186 ? 0 : 255)
  end

  # Método para retornar a cor de primeiro plano calculada.
  # Retorna:
  # - Um array com três elementos representando a cor de primeiro plano (RGB).
  def foreground_a
    @foreground
  end

  # Método para retornar a cor original.
  # Retorna:
  # - Um array com três elementos representando a cor original (RGB).
  def to_a
    [@r, @g, @b]
  end
end
