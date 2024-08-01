require 'csv'

class Funcionario
  attr_accessor :nome, :cpf, :endereco, :categoria
  SALARIO_BASE = 1500.0
  GERENTE_SALARIO = 0.50
  ESTAGIARIO_SALARIO = 0.30

  def initialize(nome, cpf, endereco, categoria)
    @nome = nome
    @cpf = cpf
    @endereco = endereco
    @categoria = categoria

    raise 'CPF inválido' unless cpf_valido?
    raise 'CEP inválido' unless cep_valido?
    raise 'Categoria inválida' unless categoria_valida?
  end

  def salario
    case @categoria
    when 'gerente'
      SALARIO_BASE * (1 + GERENTE_SALARIO)
    when 'estagiario'
      SALARIO_BASE * (1 - ESTAGIARIO_SALARIO)
    else
      SALARIO_BASE
    end
  end

  private

  def cpf_valido?
    # Implementar a validação do CPF
    @cpf.length == 11 && @cpf.scan(/\D/).empty?
  end

  def cep_valido?
    # Implementar a validação do CEP
    @endereco[:cep].length == 8 && @endereco[:cep].scan(/\D/).empty?
  end

  def categoria_valida?
    ['gerente', 'estagiario', 'outros'].include?(@categoria)
  end
end

class BancoDeDados
  def initialize
    @funcionarios = []
  end

  def adicionar_funcionario(funcionario)
    @funcionarios << funcionario
  end

  def salvar_csv
    CSV.open('funcionarios.csv', 'w') do |csv|
      csv << ['Nome', 'CPF', 'Endereço', 'Categoria', 'Salário']

      @funcionarios.each do |funcionario|
        csv << [funcionario.nome, funcionario.cpf, funcionario.endereco[:cep], funcionario.categoria, funcionario.salario]
      end
    end
  end

  def verificar_csv
    if File.exist?('funcionarios.csv')
      puts "Conteúdo do arquivo funcionarios.csv:"
      CSV.foreach('funcionarios.csv', headers: true) do |row|
        puts row.to_hash
      end
    else
      puts "Arquivo funcionarios.csv não encontrado."
    end
  end
end

# Função para coletar dados dos funcionários
def coletar_dados_funcionarios(banco)
  loop do
    puts "Digite o nome do funcionário (ou 'sair' para terminar):"
    nome = gets.chomp
    break if nome.downcase == 'sair'

    puts "Digite o CPF do funcionário (11 dígitos numéricos):"
    cpf = gets.chomp

    puts "Digite o CEP do endereço do funcionário (8 dígitos numéricos):"
    cep = gets.chomp

    loop do
      puts "Digite a categoria do funcionário (gerente, estagiario, ou outros):"
      categoria = gets.chomp

      begin
        endereco = { cep: cep }
        funcionario = Funcionario.new(nome, cpf, endereco, categoria)
        banco.adicionar_funcionario(funcionario)
        puts "Funcionário adicionado com sucesso!"
        break # Sai do loop se tudo estiver correto
      rescue => e
        puts "Erro: #{e.message}. Tente novamente."
      end
    end
  end
end

# Exemplo de uso
banco = BancoDeDados.new

# Coleta dados dos funcionários
coletar_dados_funcionarios(banco)

# Função para salvar em arquivo CSV
banco.salvar_csv

puts "Dados salvos em funcionarios.csv"

# Verifica o conteúdo do arquivo CSV
banco.verificar_csv
