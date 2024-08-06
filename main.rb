require_relative 'funcionarios'
require_relative 'gerente'
require_relative 'estagiario'
require_relative 'comum'

funcionario = []
loop do
  puts 'Digite as informações do funcionário'
  print 'Nome: '
  nome = gets.chomp

  print 'CPF: '
  cpf = gets.chomp

  print 'Endereço: '
  endereco = gets.chomp.to_s

  print 'Tipo de funcionario [0 - Estagiario, 1 - Comum, 2 - Gerente]: '
  tipo = gets.chomp.to_i

  cargo = [Estagiario.method(:new), Comum.method(:new), Gerente.method(:new)]

  funcionario << cargo[tipo].call(nome, cpf, endereco)

  print "Deseja adicionar outro(a) funcionario(a)? [S/N]: "
    resp = gets.chomp
  
  if resp.upcase == 'N'
    funcionario.each { |f| puts f.to_s}
    exit
  end
end