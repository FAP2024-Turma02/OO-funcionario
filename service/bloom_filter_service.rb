require 'murmurhash3'
require 'cityhash'
require 'ruby-xxhash'

class BloomFilterService
  # Define um array de funções de hash padrão.
  @@DEFAULT_K = [
    MurmurHash3::V32.method(:str_hash), # Função de hash MurmurHash3
    CityHash.method(:hash32),           # Função de hash CityHash
    ->(data) { XXhash.xxh32(data, 40_028_922) } # Função de hash XXHash com seed 40028922
  ]

  # Método construtor para inicializar os atributos da classe BloomFilterService.
  # Parâmetros:
  # - data: um array opcional de valores para inicializar o filtro Bloom.
  # - k: um array de funções de hash, padrão é @@DEFAULT_K.
  def initialize(data = [], k = @@DEFAULT_K)
    @k = k # Atribui as funções de hash.
    # Inicializa os filtros Bloom com valores do array data ou 0 se não fornecido.
    @bloom_filters = Array.new(@k.length) { |i| data[i].nil? ? 0 : data[i] }
  end

  # Método para adicionar dados ao filtro Bloom.
  # Parâmetros:
  # - data: os dados a serem adicionados.
  def push(data)
    # Aplica todas as funções de hash aos dados.
    encode = apply_all_hashfunction(data)
    # Atualiza os filtros Bloom com o resultado das funções de hash.
    (0...@k.length).each { |i| @bloom_filters[i] |= encode[i] }
  end

  # Método para verificar se os dados estão presentes no filtro Bloom.
  # Parâmetros:
  # - data: os dados a serem verificados.
  # Retorna:
  # - true se os dados possivelmente estão presentes, false caso contrário.
  def include?(data)
    # Aplica todas as funções de hash aos dados.
    encode = apply_all_hashfunction(data)
    # Verifica se os bits correspondentes estão definidos em todos os filtros Bloom.
    (0...encode.length).each do |i|
      return false if (@bloom_filters[i] & encode[i]) == 0
    end
    true
  end

  private

  # Método privado para aplicar todas as funções de hash aos dados.
  # Parâmetros:
  # - data: os dados a serem hashados.
  # Retorna:
  # - Um array de inteiros representando os resultados das funções de hash aplicadas aos dados.
  def apply_all_hashfunction(data)
    @k.map { |func| 0x01 << (func.call(data) % 1024) }
  end
end
