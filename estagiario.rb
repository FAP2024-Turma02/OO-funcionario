require_relative 'funcionarios'

class Estagiario < Funcionarios
  protected
  def calculate_salary
    @salario -= @salario * 0.3
  end
end
