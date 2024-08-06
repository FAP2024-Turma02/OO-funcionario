require_relative 'funcionarios'

class Comum < Funcionarios
  protected
  def calculate_salary
    return @salario
  end
end