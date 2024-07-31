require_relative 'validacao_cpf'

class Funcionario
  attr_accessor :nome, :cpf, :endereco, :categoria, :salario

  def initialize(nome, cpf, endereco, categoria)
    @nome = nome
    self.cpf = cpf
    @endereco = endereco
    self.categoria = categoria
  end

  def cpf=(cpf)
    if ValidadorCPF.validar(cpf)
      @cpf = CPF.new(cpf).formatted
    else
      raise "cpf invalido."
    end
  end

  def categoria=(categoria)
    @categoria = categoria
    case categoria.downcase
    when 'gerente'
      @salario = '50%+'
    when 'funcionario comum'
      @salario = 1500
    when 'estagiario'
      @salario = '30%-'
    else
      raise "Categoria invalida. As categorias validas são: gerente, funcionario comum, estagiario."
    end
  end

  def to_s
    "Nome: #{@nome}, CPF: #{@cpf}, Endereço: #{@endereco}, Categoria: #{@categoria}, Salario: #{@salario}"
  end
end
