org 0x7e00
jmp 0x0000:start

data:

;MENU

resposta times 8 db 0
	
nomejogo    db 'GENIUS GAME', 0
jogar       db 'START (PRESS 1)', 0
creditos    db 'CREDITS (PRESS 2)', 0
instrucao   db 'INSTRUCTIONS (PRESS 3)', 0
saida       db 'EXIT (PRESS 4)', 0

str_derrotado db 'Voce perdeu!', 0

descNivel1 db '#Nivel 1(Facil):', 0
descNivel2 db '#Nivel 2(Medio):', 0
descNivel3 db '#Nivel 3(Dificil):', 0
descNivel4 db '#Nivel 4(Muito dificil):', 0

tentativa db 'Agora tente digitar os caracteres:', 0

nivel1 db 'AgT', 0, 0, 0, 0, 0
nivel2 db 'WULPF', 0, 0, 0
nivel3 db 'rYKnly', 0, 0
nivel4 db 'OuHBnJU', 0

respostaN1 db 'AgT', 0

bemVindo db 'Bem vindo ao GENIUS GAME', 0
;CREDITOS

grupo     db 'created by:', 0
name1 db 'Alexandre Henrique Soares da Silva Filho', 0
name2 db 'Julia Albuquerque Machado', 0
name3 db 'Nicolas Gustavo Barbosa da Silva', 0
esc   db 'Press Esc to return', 0	

;PONTUAÇAO 

score	db 'Your score:', 0
rounds	db 'Rounds:', 0

strcmp:              ; mov si, string1, mov di, string2, compara as strings apontadas por si e di
  .loop1:
    lodsb
    cmp al, byte[di]
    jne .notequal
    cmp al, 0
    je .equal
    inc di
    jmp .loop1
  .notequal:
    clc
    ret
  .equal:
    stc
    ret

getchar:    ;Pega o caractere lido no teclado e salva em al
  mov ah, 0x00
  int 16h
  ret

putchar: ;Printar caractere na tela 
    mov ah, 0x0e
    int 10h

ret 

delchar: ;Deleta Caractere 
    mov al,0x08
    call putchar

    mov al, ''
    call putchar

    mov al, 0x08
    call putchar

ret 

endl:
    mov al, 0x0d
    call putchar
    mov al, 0x0a
    call putchar

ret

getString:
    xor cx,cx

    .loop1:
        call getchar
        cmp al, 0x08
        je .backspace 
        cmp al, 0x0d
        je .done
        cmp cl,50 
        je .loop1
        stosb
        inc cl
        call putchar 
        jmp .loop1

        .backspace: 
            cmp cl, 0
            je .loop1
            dec di
            dec cl
            mov byte[di], 0
            call delchar
            jmp .loop1

    .done: 
        mov al, 0
        stosb 
        call endl
    ret
            
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

tela_da_derrota:
    mov ah, 0 ;limpar a tela
    mov al,12h
    int 10h

    mov dh, 5   
    mov dl, 25 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, str_derrotado
    call printString

    ret

renderNivel1:

    mov dh, 5   
    mov dl, 25 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, descNivel1
    call printString

    mov dh, 9   
    mov dl, 25 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, nivel1
    call printString

    mov cx, 55
    call DelayProcedure
    
    mov dh, 9   
    mov dl, 25 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, tentativa
    call printString

    mov di, resposta
    call getString

    mov di, resposta
    mov si, nivel1
    call strcmp

    jnc tela_da_derrota


    ; se acertar vai pro proximo nivel

    ; se errar vai pra tela de derrota
    
    ret

renderNivel2:

    mov dh, 5   
    mov dl, 25 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, descNivel2
    call printString

    mov dh, 9   
    mov dl, 25 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, nivel2
    call printString

    mov cx, 55
    call DelayProcedure
    
    mov dh, 9   
    mov dl, 25 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, tentativa
    call printString
    
    ret

renderNivel3:
    mov dh, 5   
    mov dl, 25 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, descNivel3
    call printString

    mov dh, 9   
    mov dl, 25 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, nivel3
    call printString

    mov cx, 55
    call DelayProcedure
    
    mov dh, 9   
    mov dl, 25 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, tentativa
    call printString
    
    ret

renderNivel4:

    mov dh, 5   
    mov dl, 25 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, descNivel4
    call printString

    mov dh, 9   
    mov dl, 25 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, nivel4
    call printString

    mov cx, 55
    call DelayProcedure
    
    mov dh, 9   
    mov dl, 25 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, tentativa
    call printString
    
    ret

Menu:
    mov ah, 0  ; Numero da chamada para escolher o modo de video
    mov al, 12h ; modo de tela
    int 10h ; interrupção

    mov ah, 0bh ;Mudar a cor do background
    mov bh, 0
    mov bl, 0
    int 10h 
    

    ;nome do jogo
    mov dh, 3    ;Linha
    mov dl, 34   ;Coluna
    mov ah, 02h  ;Cursor
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
        
   call getchar
        
    ;se '1'
    cmp al, 49
    je telajogo
        
    ;se '2'
    cmp al, 50
    je telacredito

    ;se '3'
    cmp al,51
   ; je telainstrucao

    ;se '4'
    cmp al, 52
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

telainstrucao:

    mov ah, 0 ;limpar a tela
    mov al,12h
    int 10h

    mov ah, 0bh
    mov bh, 0
    mov bl, 0
    int 10h
   

telajogo: 
    mov ah, 0 ;limpar a tela
    mov al,12h
    int 10h

    
    mov ah, 0bh ;Mudar a cor do background
    mov bh, 0
    mov bl, 0
    int 10h 

    mov dh, 3   
    mov dl, 25 
    mov ah, 02h  
    mov bh, 0      
    int 10h
    mov si, bemVindo
    call printString

    jmp renderNivel1
    
    jmp done

done:
    jmp $

DelayProcedure:
  push  ax
  push  ds
  mov   ax,40h
  mov   ds,ax

  ; make sure that the delay will take "at least n*55ms"
  ; by waiting for first incomplete (<= 55ms) tick
  mov   ax,[6Ch]
.waitFirstForOneTickHappen:
  nop
  cmp   [6Ch],ax
  je    .waitFirstForOneTickHappen

  ; remove the loop above to get "at most n*55ms" behaviour
  ; (which may be more practical for some situations, like animation syncing)

  ; wait "at most n*55ms" ticks
.waitNticks:
  mov   ax,[6Ch]
.waitForTick:
  nop
  cmp   [6Ch],ax
  je    .waitForTick
  loop  .waitNticks

  ; restore ds, ax and return
  pop   ds
  pop   ax
  ret