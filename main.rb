# main.rb
require_relative 'gerenciadorFuncionarios'
require_relative 'limpador_tela'
require_relative 'validacao_cpf'
require_relative 'funcionario'

gerenciador = GerenciadorFuncionarios.new

loop do
  LimpadorTela.limpar
  puts "1. Adicionar Funcionário"
  puts "2. Exibir Funcionários"
  puts "3. Salvar em CSV"
  puts "4. Sair"
  print "Escolha uma opção: "
  opcao = gets.chomp.to_i

  case opcao
  when 1
    loop do
      LimpadorTela.limpar
      puts "Adicionando usuário:"
      print "Nome: "
      nome = gets.chomp
      print "CPF: "
      cpf = gets.chomp.to_i
      print "Endereço: "
      endereco = gets.chomp
      print "Categoria (Gerente, Funcionario Comum, Estagiario): "
      categoria = gets.chomp

      begin
        funcionario = Funcionario.new(nome, cpf, endereco, categoria)
        gerenciador.adicionar_funcionarios(funcionario)
        puts "Funcionario adicionado com sucesso!!!!"
        break
      rescue => e
        LimpadorTela.limpar
        puts e.message
        puts "Tente novamente."
        gets.chomp
        break 
      end
    end

  when 2
    LimpadorTela.limpar
    gerenciador.exibir_funcionarios
    puts "clique em enter para continuar"
    gets.chomp 
  when 3
    LimpadorTela.limpar
    print "Nome do arquivo CSV: "
    nome_arquivo = gets.chomp
    gerenciador.salvar_csv(nome_arquivo)
    puts "Arquivo salvo com sucesso!"
    sleep(2) 

  when 4
    puts "Saindo..."
    sleep(2)
    LimpadorTela.limpar
    break

  else
    LimpadorTela.limpar
    puts "Opção inválida, tente novamente."
    sleep(2) 
  end
end