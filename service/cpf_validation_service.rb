class CPFValidationService
  # Método construtor para inicializar os atributos da classe CPFValidationService.
  # Parâmetro:
  # - bloom_filter: uma instância de BloomFilterService usada para verificar se um CPF já foi registrado.
  def initialize(bloom_filter)
    @bloom_filter = bloom_filter # Atribui a instância do filtro Bloom.
  end

  # Método para validar um CPF.
  # Parâmetro:
  # - cpf_raw: uma string ou número que representa o CPF não formatado.
  # Retorna:
  # - :valid se o CPF for válido e não estiver no filtro Bloom.
  # - :invalid se o CPF for inválido.
  # - :already_voted se o CPF já estiver no filtro Bloom.
  def validate(cpf_raw)
    cpf = CPF.new(cpf_raw) # Cria uma nova instância de CPF com o valor fornecido.

    # Verifica se o CPF é válido.
    if cpf.valid?
      # Verifica se o CPF já está registrado no filtro Bloom.
      return :already_voted if @bloom_filter.include?(cpf.to_a.join)

      :valid
    else
      :invalid
    end
  end
end
