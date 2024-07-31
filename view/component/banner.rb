class Banner
  # Método para exibir o banner.
  def display
    # Exibe a linha superior do banner.
    puts '╔'.ljust(50, '═') + '╗'

    # Exibe o conteúdo do banner com texto em arte ASCII.
    puts '║   ___  ___  ________  ________   ________     ' + '  ║'
    puts '║  |\\  \\|\\  \\|\\   __  \\|\\   ___  \\|\\   __  \\    ' + '  ║'
    puts '║  \\ \\  \\\\\\  \\ \\  \\|\\  \\ \\  \\\\ \\  \\ \\  \\|\\  \\   ' + '  ║'
    puts '║   \\ \\  \\\\\\  \\ \\   _  _\\ \\  \\\\ \\  \\ \\   __  \\  ' + '  ║'
    puts '║    \\ \\  \\\\\\  \\ \\  \\\\  \\\\ \\  \\\\ \\  \\ \\  \\ \\  \\ ' + '  ║'
    puts '║     \\ \\_______\\ \\__\\\\ _\\\\ \\__\\\\ \\__\\ \\__\\ \\__\\' + '  ║'
    puts '║      \\|_______|\\|__|\\|__|\\|__| \\|__|\\|__|\\|__|' + '  ║'
    puts '║                                               ' + '  ║'

    # Exibe a linha inferior do banner.
    puts '╚'.ljust(50, '═') + "╝\n\n"
  end
end
