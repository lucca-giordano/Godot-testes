extends Node

# Como essa é a entrega principal, vou documentar linha a linha para facilitar o entendimento

const SAVE_PATH = "res://savegame.bin" # diretório/nome do arquivo do save

func SaveGame(): #função que gera/atualiza o arquivo
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE) #variavel que guarda o arquivo ja aberto, com permissão para escrever
	var data: Dictionary = { 	# variavel dos dados a serem salvos
		"playerHP": Game.playerHP, # dado1, vida do jogador
		"playerGold": Game.moedas  # dado2, moedas do jogador
	}
	var jstr = JSON.stringify(data) # transforma os dados em um JSON
	file.store_line(jstr) # escreve o JSON no arquivo guardado em "file"
	
func LoadGame():	# função que le o arquivo e carrega os dados
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ) # variavel que guarda o arquivo, com permissão apenas para ler
	if FileAccess.file_exists(SAVE_PATH): # checagem para saber se o arquivo realmente foi criado/existe
		if not file.eof_reached(): # como o arquivo é lido linha a linha, esta checagem ve se o "leitor" checou a ultima linha; caso não: prossiga
			var current_line = JSON.parse_string(file.get_line()) # guarda a linha atual
			if current_line: # verifica se a linha atual não é vazia
				Game.playerHP = current_line["playerHP"] # carrega os dados do arquivo para as variaveis do jogo
				Game.moedas = current_line["playerGold"] # carrega os dados do arquivo para as variaveis do jogo
			
