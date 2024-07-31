require './view/component/banner'

class ResultView
  # Método construtor para inicializar os atributos da classe ResultView.
  # Parâmetros:
  # - voting_storage_service: uma instância do serviço de armazenamento de votos.
  # - size: o comprimento da barra de votos (padrão é 30).
  # - banner: uma instância da classe Banner, com valor padrão de Banner.new.
  def initialize(voting_storage_service, size = 30, banner: Banner.new)
    @voting_storage = voting_storage_service # Atribui a instância do serviço de armazenamento de votos.
    @size = size # Atribui o comprimento da barra de votos.
    @banner = banner # Atribui a instância do banner.
  end

  # Método para iniciar a visualização dos resultados.
  def start
    # Calcula o total de votos.
    total = @voting_storage.votes.reduce(0) { |acc, (_key, value)| acc + value }

    # Garante que o total de votos não seja zero.
    total = 1 if total == 0

    # Obtém o máximo de votos recebidos por um candidato.
    max_vote = @voting_storage.votes.values.max

    # Obtém a lista de candidatos que receberam o máximo de votos.
    most_voted = @voting_storage.votes.select { |_key, value| value == max_vote }.keys

    @banner.display # Exibe o banner.

    # Exibe o cabeçalho do gráfico de resultados.
    puts ''.rjust(17) + '▲'.ljust(@size) + '◔'

    # Itera sobre todos os candidatos e exibe suas barras de votos.
    VotingService::CANDIDATES.each do |key, candidate|
      # Exibe o nome do candidato e uma barra de votos colorida.
      puts "#{candidate.name.rjust(16)} ┤\e[38;2;#{candidate.color.to_a.join(';')}m#{''.ljust(bar_size(key, total),
                                                                                              '▇')}\e[0m"
      # Adiciona uma linha vertical se o candidato for o número 1.
      puts "#{''.rjust(16)} │" if key == '1'
    end

    # Exibe o rodapé do gráfico de resultados.
    puts ''.rjust(17) + '└'.ljust(@size, '─') + '►'
  end

  private

  # Método para calcular o tamanho da barra de votos para um candidato específico.
  # Parâmetros:
  # - key: a chave do candidato (número do candidato).
  # - total: o total de votos.
  # Retorna o tamanho da barra de votos.
  def bar_size(key, total)
    votes = @voting_storage.votes[key].nil? ? 0 : @voting_storage.votes[key] # Obtém o número de votos para o candidato.
    (votes * (@size - 2) / total).to_i + 1 # Calcula o tamanho da barra com base no total de votos.
  end
end
