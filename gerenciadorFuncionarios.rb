require 'csv'
require_relative 'funcionario'
require_relative 'limpador_tela'

class GerenciadorFuncionarios
  def initialize
    @funcionarios = []
  end

  def adicionar_funcionarios(funcionario)
    @funcionarios << funcionario
  end

  def exibir_funcionarios
    LimpadorTela.limpar
    puts "Lista de Funcionarios: "
    @funcionarios.each do |func|
      puts "nome: #{func.nome}"
      puts "cpf: #{func.cpf}"
      puts "endereço: #{func.endereco}"
      puts "categoria: #{func.categoria}"
      puts "salario: #{func.salario}"
      puts "---------------------------"
    end
  end

  def salvar_csv(nome_arquivo)
    CSV.open(nome_arquivo, 'wb') do |csv|
      csv <<  ["Nome", "cpf", "Endereço", "Categoria", "Salario"]
      @funcionarios.each do |func|
        csv << [func.nome, func.cpf, func.endereco, func.categoria, func.salario]
      end
    end
    puts "Dados salvos em #{nome_arquivo}"
  end
end