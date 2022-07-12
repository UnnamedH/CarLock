
_lock:

;MercLock.c,17 :: 		void lock()
;MercLock.c,19 :: 		x = 0;
	CLRF       MercLock_x+0
	CLRF       MercLock_x+1
;MercLock.c,20 :: 		PORTB.B5 = 1;
	BSF        PORTB+0, 5
;MercLock.c,21 :: 		locked = 1;
	MOVLW      1
	MOVWF      MercLock_locked+0
	MOVLW      0
	MOVWF      MercLock_locked+1
;MercLock.c,23 :: 		PORTB.B6 = 0;
	BCF        PORTB+0, 6
;MercLock.c,24 :: 		unlocked = 0;
	CLRF       MercLock_unlocked+0
	CLRF       MercLock_unlocked+1
;MercLock.c,25 :: 		}
L_end_lock:
	RETURN
; end of _lock

_unlock:

;MercLock.c,27 :: 		void unlock()
;MercLock.c,29 :: 		x = 0;
	CLRF       MercLock_x+0
	CLRF       MercLock_x+1
;MercLock.c,30 :: 		PORTB.B6 = 1;
	BSF        PORTB+0, 6
;MercLock.c,31 :: 		unlocked = 1;
	MOVLW      1
	MOVWF      MercLock_unlocked+0
	MOVLW      0
	MOVWF      MercLock_unlocked+1
;MercLock.c,33 :: 		PORTB.B5 = 0;
	BCF        PORTB+0, 5
;MercLock.c,34 :: 		locked = 0;
	CLRF       MercLock_locked+0
	CLRF       MercLock_locked+1
;MercLock.c,35 :: 		}
L_end_unlock:
	RETURN
; end of _unlock

_main:

;MercLock.c,37 :: 		void main()
;MercLock.c,39 :: 		TRISB = 0b00000110;
	MOVLW      6
	MOVWF      TRISB+0
;MercLock.c,41 :: 		do
L_main0:
;MercLock.c,43 :: 		if (PORTB.B1 == 1)
	BTFSS      PORTB+0, 1
	GOTO       L_main3
;MercLock.c,45 :: 		time++;
	INCF       MercLock_time+0, 1
	BTFSC      STATUS+0, 2
	INCF       MercLock_time+1, 1
;MercLock.c,47 :: 		if (time >= inTimeCheck)
	MOVLW      128
	XORWF      MercLock_time+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main19
	MOVLW      32
	SUBWF      MercLock_time+0, 0
L__main19:
	BTFSS      STATUS+0, 0
	GOTO       L_main4
;MercLock.c,49 :: 		time = 0;
	CLRF       MercLock_time+0
	CLRF       MercLock_time+1
;MercLock.c,50 :: 		lock();
	CALL       _lock+0
;MercLock.c,51 :: 		}
L_main4:
;MercLock.c,52 :: 		}
	GOTO       L_main5
L_main3:
;MercLock.c,53 :: 		else if (PORTB.B2 == 1)
	BTFSS      PORTB+0, 2
	GOTO       L_main6
;MercLock.c,55 :: 		time++;
	INCF       MercLock_time+0, 1
	BTFSC      STATUS+0, 2
	INCF       MercLock_time+1, 1
;MercLock.c,57 :: 		if (time >= inTimeCheck)
	MOVLW      128
	XORWF      MercLock_time+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main20
	MOVLW      32
	SUBWF      MercLock_time+0, 0
L__main20:
	BTFSS      STATUS+0, 0
	GOTO       L_main7
;MercLock.c,59 :: 		time = 0;
	CLRF       MercLock_time+0
	CLRF       MercLock_time+1
;MercLock.c,60 :: 		unlock();
	CALL       _unlock+0
;MercLock.c,61 :: 		}
L_main7:
;MercLock.c,62 :: 		}
	GOTO       L_main8
L_main6:
;MercLock.c,63 :: 		else if (locked == 1 || unlocked == 1)
	MOVLW      0
	XORWF      MercLock_locked+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main21
	MOVLW      1
	XORWF      MercLock_locked+0, 0
L__main21:
	BTFSC      STATUS+0, 2
	GOTO       L__main15
	MOVLW      0
	XORWF      MercLock_unlocked+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main22
	MOVLW      1
	XORWF      MercLock_unlocked+0, 0
L__main22:
	BTFSC      STATUS+0, 2
	GOTO       L__main15
	GOTO       L_main11
L__main15:
;MercLock.c,65 :: 		x++;
	INCF       MercLock_x+0, 1
	BTFSC      STATUS+0, 2
	INCF       MercLock_x+1, 1
;MercLock.c,67 :: 		if (x >= onTimeCheck)
	MOVLW      128
	XORWF      MercLock_x+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main23
	MOVLW      200
	SUBWF      MercLock_x+0, 0
L__main23:
	BTFSS      STATUS+0, 0
	GOTO       L_main12
;MercLock.c,69 :: 		locked = 0;
	CLRF       MercLock_locked+0
	CLRF       MercLock_locked+1
;MercLock.c,70 :: 		unlocked = 0;
	CLRF       MercLock_unlocked+0
	CLRF       MercLock_unlocked+1
;MercLock.c,71 :: 		x = 0;
	CLRF       MercLock_x+0
	CLRF       MercLock_x+1
;MercLock.c,72 :: 		}
L_main12:
;MercLock.c,73 :: 		}
	GOTO       L_main13
L_main11:
;MercLock.c,76 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MercLock.c,77 :: 		time = 0;
	CLRF       MercLock_time+0
	CLRF       MercLock_time+1
;MercLock.c,78 :: 		}
L_main13:
L_main8:
L_main5:
;MercLock.c,80 :: 		Delay_ms(interval);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	NOP
;MercLock.c,81 :: 		} while (1);
	GOTO       L_main0
;MercLock.c,82 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
