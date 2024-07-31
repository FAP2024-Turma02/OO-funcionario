require './entity/candidate'
require './entity/color'

class VotingService
  # Constante que define os candidatos disponíveis no sistema de votação.
  CANDIDATES = {
    '0' => Candidate.new('Nulo', Color.new(255, 0, 0), ''),
    '1' => Candidate.new('Branco', Color.new(255, 255, 255), ''),
    '15' => Candidate.new('Jim Halpert', Color.new(178, 218, 250), '☺'),
    '72' => Candidate.new('Sheldon Cooper', Color.new(15, 79, 52), '☢'),
    '60' => Candidate.new('Donald Draper', Color.new(0, 0, 0), '✎'),
    '99' => Candidate.new('Donna Paulsen', Color.new(139, 0, 0), '☎'),
    '68' => Candidate.new('Giorgio Rosa', Color.new(255, 0, 127), '☸'),
    '80' => Candidate.new('Enrico Frattasio', Color.new(159, 95, 0), '♬')
  }

  # Método para selecionar um candidato com base na opção fornecida.
  # Parâmetro:
  # - option: uma string que representa a opção do candidato.
  # Retorna:
  # - Uma instância de Candidate correspondente à opção fornecida.
  def select_candidate(option)
    option_selected = validate_candidate_option(option) # Valida a opção do candidato.
    CANDIDATES[option_selected] # Retorna o candidato correspondente à opção validada.
  end

  private

  # Método privado para validar a opção do candidato.
  # Parâmetro:
  # - option: uma string que representa a opção do candidato.
  # Retorna:
  # - A opção validada, retornando "0" se a opção não for válida.
  def validate_candidate_option(option)
    return option if CANDIDATES.key?(option) # Retorna a opção se for válida.

    '0' # Retorna "0" (nulo) se a opção não for válida.
  end
end
