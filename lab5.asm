global main
extern printf, scanf

section .data
    choice db "Please choose an option:", 10, "1. Replace all occurrences of a character with another character in a string", 10, "2. Replace a character with another character in a string", 10, "3. Calculate the length of a string", 10, "4. Sort a list of numbers in descending order", 10, "5. Divide two numbers", 10, "6. Quit", 10, 0
    prompt_str db "Enter a string: ", 0
    prompt_char1 db "Enter the character to replace: ", 0
    prompt_char2 db "Enter the new character: ", 0
    prompt_list db "Enter a list of numbers (separated by spaces): ", 0
    prompt_num1 db "Enter the first string: ", 0
    prompt_num2 db "Enter the second string: ", 0
    result_divide db "Result of division: %d", 10, 0
    cannot_divide db "Cannot divide by zero.", 10, 0
    str_length db "Length of string is: %d", 10, 0
    str_replaced db "String after replacing occurrences: %s", 10, 0
    char_replaced db "String after replacing character: %s", 10, 0
    char_not_found db "Character not found in string.", 10, 0
    nums_sorted db "Concatinated string: ", 0
    num_format db "%d ", 0

section .bss
    choice_input resb 2
    str_input resb 50
    old_char_input resb 1
    new_char_input resb 1
    num1_input resb 12
    num2_input resb 12

section .text
main:
    ; Declare local variables
    mov ebx, str_input
    mov byte [ebx], 0
    mov ebx, old_char_input
    mov byte [ebx], 0
    mov ebx, new_char_input
    mov byte [ebx], 0
    mov ebx, num1_input
    mov byte [ebx], 0
    mov ebx, num2_input
    mov byte [ebx], 0
    xor esi, esi  ; Counter for list of numbers

    while_loop:
        ; Display menu
        mov eax, choice
        call printf
        mov eax, prompt_str
        call printf

        ; Take input for choice
        mov eax, choice_input
        mov edx, 2
        call scanf
        movzx eax, byte [choice_input]
        cmp eax, '0'
        jl invalid_choice
        cmp eax, '6'
        jg invalid_choice

        ; Perform selected operation
        cmp eax, '1'
        je replace_occurrences
        cmp eax, '2'
        je replace_character
        cmp eax, '3'
        je string_length
        cmp eax, '4'
        je sort_numbers
        cmp eax, '5'
        je divide_numbers
        cmp eax, '6'
        je exit_program

        invalid_choice:
            mov eax, "Invalid choice. Please try again."
            call printf
            jmp while_loop

        replace_occurrences:
            ; Take input for string and characters
            mov eax, prompt_char1
            call printf
            mov eax, old_char_input
            mov edx, 1
            call scanf
            mov eax,
                    prompt_char2
        call printf
        mov eax, new_char_input
        mov edx, 1
        call scanf
        mov eax, prompt_str
        call printf
        mov eax, str_input
        mov edx, 50
        call scanf

        ; Replace all occurrences of oldChar with newChar
        mov ebx, str_input
        mov ecx, old_char_input
        mov edx, new_char_input
        call replaceOccurrences

        jmp while_loop

    replace_character:
        ; Take input for string and characters
        mov eax, prompt_char1
        call printf
        mov eax, old_char_input
        mov edx, 1
        call scanf
        mov eax, prompt_char2
        call printf
        mov eax, new_char_input
        mov edx, 1
        call scanf
        mov eax, prompt_str
        call printf
        mov eax, str_input
        mov edx, 50
        call scanf

        ; Replace a character with newChar
        mov ebx, str_input
        mov ecx, old_char_input
        mov edx, new_char_input
        call replaceCharacter

        jmp while_loop

    string_length:
        ; Take input for string
        mov eax, prompt_str
        call printf
        mov eax, str_input
        mov edx, 50
        call scanf

        ; Calculate string length
        mov ebx, str_input
        call stringLength

        jmp while_loop

    concatenate_strings:
	    ; Read input strings
	    mov eax, enter_first_string
	    call printf
	    mov eax, str1
	    mov ebx, 256
	    call read_input
	    mov eax, enter_second_string
	    call printf
	    mov eax, str2
	    mov ebx, 256
	    call read_input

	    ; Concatenate strings
	    mov eax, str1
	    mov ebx, str2
	    call concatenate_strings

	    ; Display result
	    mov eax, concatenated_string
	    mov ebx, str1
	    call printf
	    jmp while_loop


    divide_numbers:
        ; Take input for numbers
        mov eax, prompt_num1
        call printf
        mov eax, num1_input
        mov edx, 12
        call scanf
        mov eax, prompt_num2
        call printf
        mov eax, num2_input
        mov edx, 12
        call scanf

        ; Divide the numbers
        mov eax, num1_input
        cdq
        idiv dword [num2_input]
        cmp dword [num2_input], 0
        je cannot_divide
        mov eax, result_divide
        mov ebx, edx
        call printf

        jmp while_loop

    exit_program:
        xor eax, eax
        ret
 ; Function to replace all occurrences of a character with another character
	replaceOccurrences:
	    push ebp
	    mov ebp, esp
	    push ebx ecx edx
	    mov ebx, [ebp + 8] ; str
	    mov cl, [ebp + 12] ; oldChar
	    mov dl, [ebp + 16] ; newChar
	    mov ecx, [ebx] ; length of string
	    mov edx, ebx
	    add edx, ecx ; end of string
	    loop_start:
		cmp ebx, edx
		jae loop_done
		cmp byte [ebx], cl
		jne loop_continue
		mov byte [ebx], dl
		loop_continue:
		    inc ebx
		    jmp loop_start
		loop_done:
		    mov eax, str_replaced
		    mov ebx, [ebp + 8] ; str
		    call printf
		    pop edx ecx ebx ebp
		    ret

	; Function to replace a character with another character
	replaceCharacter:
	    push ebp
	    mov ebp, esp
	    push ebx ecx edx
	    mov ebx, [ebp + 8] ; str
	    mov cl, [ebp + 12] ; oldChar
	    mov dl, [ebp + 16] ; newChar
	    mov ecx, [ebx] ; length of string
	    mov edx, ebx
	    add edx, ecx ; end of string
	    loop_start:
		cmp ebx, edx
		jae loop_done
		cmp byte [ebx], cl
		jne loop_continue
		mov byte [ebx], dl
		mov eax, char_replaced
		mov ebx, [ebp + 8] ; str
		call printf
		pop edx ecx ebx ebp
		ret
		loop_continue:
		    inc ebx
		    jmp loop_start
		loop_done:
		    mov eax, char_not_found
		    call printf
		    pop edx ecx ebx ebp
		    ret

	; Function to calculate the length of a string
	stringLength:
	    push ebp
	    mov ebp, esp
	    push ebx ecx
	    mov ebx, [ebp + 8] ; str
	    mov ecx, [ebx] ; length of string
	    mov eax, str_length
	    mov ebx, ecx
	    call printf
	    pop ecx ebx ebp
	    ret

	; Function to sort a list of numbers in descending order
	concatenate_strings:
	    push ebp
	    mov ebp, esp
	    mov esi, [ebp+8] ; str1
	    mov edi, [ebp+12] ; str2
	    mov ecx, 0
	    cld
	    repne scasb
	    dec esi
	    mov ebx, edi
	    sub edi, esi
	    mov edx, ecx
	    rep movsb
	    mov ecx, edx
	    mov esi, ebx
	    mov edi, [ebp+8] ; str1
	    rep movsb
	    pop ebp
	    ret

	; Function to divide two numbers
	divideNumbers:
	    push ebp
	    mov ebp, esp
	    push ebx ecx edx
	    mov eax, [ebp + 8] ; num1
	    mov ebx, [ebp + 12] ; num2
	    cmp ebx
            je divide_by_zero
	    cdq ; Convert eax to signed division
	    idiv ebx
	    mov eax, result_divide
	    mov ebx, edx
	    call printf
	    jmp divide_done
	divide_by_zero:
	    mov eax, cannot_divide
	    call printf
	    divide_done:
	    pop edx ecx ebx ebp
	    ret
