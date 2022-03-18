org 0x7e00
jmp 0x0000:start

data:

;MENU
	
nomejogo    db 'GENIUS GAME', 0
jogar       db 'START (PRESS 1)', 0
creditos    db 'CREDITS (PRESS 2)', 0
saida       db 'EXIT (PRESS 3)', 0

;CREDITOS

grupo     db 'created by:', 0
name1 db 'Alexandre Henrique Soares da Silva Filho', 0
name2 db 'Julia Albuquerque Machado', 0
name3 db 'Nicolas Gustavo Barbosa da Silva', 0
esc   db 'Press Esc to return', 0	

;PONTUAÇAO 

score	db 'Your score:', 0
rounds	db 'Rounds:', 0

printString:
    lodsb
    mov ah, 0xe
    mov bh, 0
    mov bl, 0xf
    int 10h

    cmp al, 0
    jne printString
    ret
    
    
    
start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    
    call Menu
    
    jmp done
    
;TELA1MENU

Menu:

    
    mov ah, 0  ;Carregando o video
    mov al, 12h
    int 10h

    
    mov ah, 0bh ;Mudar a cor do background
    mov bh, 0
    mov bl, 0
    int 10h 
    

    ;nome do jogo
    mov dh, 3    ;Linha
    mov dl, 34   ;Coluna
    mov ah, 02h  ;Setando o cursor
    mov bh, 0    ;Pagina 0
    int 10h
    mov si, nomejogo
    call printString

    ;string start
    mov dh, 15   
    mov dl, 32 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, jogar
    call printString
    
    ;string creditos
    mov dh, 20   
    mov dl, 31 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, creditos
    call printString
    
    ;string exit 
    mov dh, 25   
    mov dl, 32
    mov ah, 02h  
    mov bh, 0       
    int 10h
    mov si, saida
    call printString
    
opcaomenu:
        
    mov ah, 0 ;receber opcao
    int 16h
        
    ;se '1'
    cmp al, 49
    je telajogo
        
    ;se '2'
    cmp al, 50
    je telacredito
        
    ;se '3'
    cmp al, 51
    je done
        
        
    jne opcaomenu ;repete se nao for nenhuma das opcoes

telacredito: 

    mov ah, 0 ;limpar a tela
    mov al,12h
    int 10h

    mov ah, 0bh
    mov bh, 0
    mov bl, 0
    int 10h
    
    
    mov dh, 3    
    mov dl, 29   
	mov ah, 02h  
	mov bh, 0    
	int 10h
    mov si, grupo
    call printString

    
    mov dh, 7    
    mov dl, 10   
    mov ah, 02h  
	mov bh, 0    
	int 10h
    mov si, name1
    call printString

    
    mov dh, 9    
    mov dl, 10   
    mov ah, 02h  
	mov bh, 0    
	int 10h
    mov si, name2
    call printString

    mov dh, 11   
    mov dl, 10   
    mov ah, 02h  
	mov bh, 0    
	int 10h
    mov si, name3
    call printString

	
    mov dh, 20   
    mov dl, 10   
    mov ah, 02h  
	mov bh, 0    
	int 10h
    mov si, esc
    call printString

exitcreditos:
	
    mov ah, 0 ;ler caractere
    int 16h

    
    cmp al, 27
	je Menu
	jne exitcreditos


telajogo: 

    jmp done

done:
    jmp $
