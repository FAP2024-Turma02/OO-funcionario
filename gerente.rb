class Gerente < Funcionario
  def calc_gerente
    @salario += @salario * 0.50
  end
end