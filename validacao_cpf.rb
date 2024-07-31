require 'cpf_cnpj'

class ValidadorCPF
  def self.validar(cpf)
    CPF.valid?(cpf)
  end
end