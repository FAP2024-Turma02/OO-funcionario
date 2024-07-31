class VotingStorageService
  attr_reader :votes

  # Método construtor para inicializar os atributos da classe VotingStorageService.
  # Parâmetro:
  # - bloom_filter: uma instância de BloomFilterService usada para verificar e registrar CPFs únicos.
  def initialize(bloom_filter)
    @bloom_filter = bloom_filter # Atribui a instância do filtro Bloom.
    @votes = {} # Inicializa um hash vazio para armazenar os votos.
  end

  # Método para registrar um voto.
  # Parâmetros:
  # - cpf: uma instância de CPF representando o CPF do votante.
  # - candidate_number: uma string que representa o número do candidato.
  def record_vote(cpf, candidate_number)
    # Inicializa o contador de votos para o candidato se ainda não existir.
    @votes[candidate_number] ||= 0
    # Incrementa o contador de votos para o candidato.
    @votes[candidate_number] += 1
    # Adiciona o CPF ao filtro Bloom para marcar que este CPF já votou.
    @bloom_filter.push(cpf.to_a.join)
  end
end
