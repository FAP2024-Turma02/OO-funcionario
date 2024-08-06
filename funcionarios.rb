class Funcionarios
  attr_accessor :nome, :cpf, :endereco, :salario,
 
  def initialize(nome,cpf)
    @nome = nome 
    @cpf = cpf
    @endereco = endereco
    @salario = 1500
  end

  def to_s
    "Dados do Funcionario:
    \rNome: #{nome}
    \rCPF: #{cpf}
    \rEndereço: #{endereco}
    \rSalario: $#{salario}"
  end

  def calcular_salario
   case @tipo
   when 1
     comun
   when 2    
     estagiario
   when 3
     gerente
   else
     puts "Opção Invalida"
   end
  end

  
  def comun
    return @salario
  end

  def estagiario
    @salario -= @salario * 0.30
  end

  def gerente
    @salario += @salario * 0.50
  end
  
  def limpar_tela
    system("cls") || system("clear")
  end
end
