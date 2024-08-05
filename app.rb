require 'sqlite3'
module Cores
  RESET = "\e[0m"
  BRANCO = "\e[37m"
  AMARELO = "\e[33m"
  VERDE = "\e[32m"
  VERMELHO = "\e[31m"
  AZUL = "\e[34m"
  FUNDO_AMARELO = "\e[43m"
  FUNDO_VERDE = "\e[42m"
  FUNDO_VERMELHO = "\e[41m"
end

db = SQLite3::Database.new "funcionarios.db"
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS funcionarios (
    id INTEGER PRIMARY KEY,
    nome TEXT,
    cpf TEXT,
    cargo TEXT,
    salario REAL,
    data_admissao TEXT
  );
SQL

def clear_screen
  system("clear") || system("cls")  
end

class Funcionario

  attr_accessor :nome, :cpf, :cargo, :salario, :data_admissao

  SALARIO_BASE = 1500

  def initialize(nome, cpf, cargo)
    @nome = nome
    @cpf = cpf
    @cargo = cargo
    @salario = calcular_salario(cargo)
    @data_admissao = Time.now.strftime("%d/%m/%Y")
  end

  def calcular_salario(cargo)
    case cargo.downcase
    when "gerente"
      SALARIO_BASE * 1.5
    when "funcionario"
      SALARIO_BASE * 0.7
    else
      SALARIO_BASE
    end
  end

  def exibir_informacoes
  "Nome: #{@nome}, 
  CPF: #{@cpf}, 
  Cargo: #{@cargo}, 
  Salário: R$#{'%.2f' % @salario}, 
  Data de Admissão: #{@data_admissao}"
  end

  def salvar_no_banco(db)
    db.execute("INSERT INTO funcionarios (nome, cpf, cargo, salario, data_admissao) VALUES (?, ?, ?, ?, ?)",
               [@nome, @cpf, @cargo, @salario, @data_admissao])
  end
end

def cpf_valido?(cpf)
  cpf.match?(/^\d{11}$/)
end

def obter_entrada(mensagem)
  print mensagem
  gets.chomp
end


def inicio(db)
  clear_screen()
nome = ""
while true
  nome = obter_entrada("#{Cores::FUNDO_VERDE}Digite o nome do funcionário: #{Cores::RESET}").strip
  if nome.empty?
    puts "Nome não pode ser em branco."
  else
    break
  end
end


cpf = ""
while true
  cpf = obter_entrada("#{Cores::FUNDO_VERDE}Digite o CPF do funcionário (11 dígitos, somente números): #{Cores::RESET}").strip
  if cpf_valido?(cpf)
    break
  else
    puts "O CPF precisa ter 11 dígitos e conter apenas números."
  end
end


cargo = ""
while true
  cargo = obter_entrada("#{Cores::FUNDO_VERDE}Digite o cargo do funcionário (gerente/funcionario): #{Cores::RESET}").strip
  if cargo.empty?
    puts "Cargo não pode ser em branco."
  else
    break
  end
end


funcionario = Funcionario.new(nome, cpf, cargo)
funcionario.salvar_no_banco(db)
clear_screen()
puts "#{Cores::FUNDO_VERDE}Dados do Funcionario:#{Cores::RESET}#{nome}"
puts funcionario.exibir_informacoes
end
loop do
  inicio(db)
  
  resposta = obter_entrada("Deseja cadastrar outro funcionário? (s/n): ").strip.downcase
  break unless resposta == 's'
end
