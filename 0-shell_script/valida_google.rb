# ====== Precisar converter para UTF-8 ======

def to_utf8(str)
  str = str.force_encoding('UTF-8')
  return str if str.valid_encoding?
  str.encode("UTF-8", 'binary', invalid: :replace, undef: :replace, replace: '')
end

resultado_google = `curl -s www.google.com`
if to_utf8(resultado_google) =~ /google/
  puts "Achei aqui"
else
  puts "Não achei aqui"
end

# ====== Site sem precisar converter para UTF-8 ======
# resultado_google = `curl -s https://www.torneseumprogramador.com.br/`
# if resultado_google =~ /Didox/
#   puts "Achei aqui"
# else
#   puts "Não achei aqui"
# end