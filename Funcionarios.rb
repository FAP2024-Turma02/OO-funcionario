class Funcionario

    attr_acessor :nome, :cpf, :endereco

    def initialize(nome,cpf,endereco)
        @nome = nome
        @cpf = cpf
        @endereco = endereco
    end

    def salario()
        raise NotImplementedError, 'Este método deve ser implementado pelas subclasses'
    end

    def func_info()
    "Nome:#{@nome} CPF:#{cpf} Ende"
    end

end
