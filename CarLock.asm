
_lock:

;CarLock.c,26 :: 		void lock()
;CarLock.c,28 :: 		x = 0;
	CLRF       CarLock_x+0
	CLRF       CarLock_x+1
;CarLock.c,29 :: 		PORTB.B5 = 1;
	BSF        PORTB+0, 5
;CarLock.c,30 :: 		locked = 1;
	MOVLW      1
	MOVWF      CarLock_locked+0
	MOVLW      0
	MOVWF      CarLock_locked+1
;CarLock.c,32 :: 		PORTB.B6 = 0;
	BCF        PORTB+0, 6
;CarLock.c,33 :: 		unlocked = 0;
	CLRF       CarLock_unlocked+0
	CLRF       CarLock_unlocked+1
;CarLock.c,35 :: 		enabled = 0;
	CLRF       _enabled+0
	CLRF       _enabled+1
;CarLock.c,36 :: 		current = 1;
	MOVLW      1
	MOVWF      _current+0
	MOVLW      0
	MOVWF      _current+1
;CarLock.c,38 :: 		}
L_end_lock:
	RETURN
; end of _lock

_unlock:

;CarLock.c,40 :: 		void unlock()
;CarLock.c,42 :: 		x = 0;
	CLRF       CarLock_x+0
	CLRF       CarLock_x+1
;CarLock.c,43 :: 		PORTB.B6 = 1;
	BSF        PORTB+0, 6
;CarLock.c,44 :: 		unlocked = 1;
	MOVLW      1
	MOVWF      CarLock_unlocked+0
	MOVLW      0
	MOVWF      CarLock_unlocked+1
;CarLock.c,46 :: 		PORTB.B5 = 0;
	BCF        PORTB+0, 5
;CarLock.c,47 :: 		locked = 0;
	CLRF       CarLock_locked+0
	CLRF       CarLock_locked+1
;CarLock.c,49 :: 		enabled = 0;
	CLRF       _enabled+0
	CLRF       _enabled+1
;CarLock.c,50 :: 		current = 2;
	MOVLW      2
	MOVWF      _current+0
	MOVLW      0
	MOVWF      _current+1
;CarLock.c,52 :: 		}
L_end_unlock:
	RETURN
; end of _unlock

_main:

;CarLock.c,54 :: 		void main()
;CarLock.c,56 :: 		TRISB = 0b00000110;
	MOVLW      6
	MOVWF      TRISB+0
;CarLock.c,58 :: 		do
L_main0:
;CarLock.c,60 :: 		if (PORTB.B1 == 1 && PORTB.B2 == 1 && enabled == 1 && current != 1) // Check Lock
	BTFSS      PORTB+0, 1
	GOTO       L_main5
	BTFSS      PORTB+0, 2
	GOTO       L_main5
	MOVLW      0
	XORWF      _enabled+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main29
	MOVLW      1
	XORWF      _enabled+0, 0
L__main29:
	BTFSS      STATUS+0, 2
	GOTO       L_main5
	MOVLW      0
	XORWF      _current+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main30
	MOVLW      1
	XORWF      _current+0, 0
L__main30:
	BTFSC      STATUS+0, 2
	GOTO       L_main5
L__main25:
;CarLock.c,62 :: 		time++;
	INCF       CarLock_time+0, 1
	BTFSC      STATUS+0, 2
	INCF       CarLock_time+1, 1
;CarLock.c,64 :: 		if (time >= inTimeCheck)
	MOVLW      128
	XORWF      CarLock_time+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVLW      32
	SUBWF      CarLock_time+0, 0
L__main31:
	BTFSS      STATUS+0, 0
	GOTO       L_main6
;CarLock.c,66 :: 		time = 0;
	CLRF       CarLock_time+0
	CLRF       CarLock_time+1
;CarLock.c,67 :: 		lock();
	CALL       _lock+0
;CarLock.c,68 :: 		}
L_main6:
;CarLock.c,69 :: 		}
	GOTO       L_main7
L_main5:
;CarLock.c,70 :: 		else if (PORTB.B1 == 0 && PORTB.B2 == 0 && enabled == 1 && current != 2) // Check Unlock
	BTFSC      PORTB+0, 1
	GOTO       L_main10
	BTFSC      PORTB+0, 2
	GOTO       L_main10
	MOVLW      0
	XORWF      _enabled+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVLW      1
	XORWF      _enabled+0, 0
L__main32:
	BTFSS      STATUS+0, 2
	GOTO       L_main10
	MOVLW      0
	XORWF      _current+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVLW      2
	XORWF      _current+0, 0
L__main33:
	BTFSC      STATUS+0, 2
	GOTO       L_main10
L__main24:
;CarLock.c,72 :: 		time++;
	INCF       CarLock_time+0, 1
	BTFSC      STATUS+0, 2
	INCF       CarLock_time+1, 1
;CarLock.c,74 :: 		if (time >= inTimeCheck)
	MOVLW      128
	XORWF      CarLock_time+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVLW      32
	SUBWF      CarLock_time+0, 0
L__main34:
	BTFSS      STATUS+0, 0
	GOTO       L_main11
;CarLock.c,76 :: 		time = 0;
	CLRF       CarLock_time+0
	CLRF       CarLock_time+1
;CarLock.c,77 :: 		unlock();
	CALL       _unlock+0
;CarLock.c,78 :: 		}
L_main11:
;CarLock.c,79 :: 		}
	GOTO       L_main12
L_main10:
;CarLock.c,80 :: 		else if (locked == 1 || unlocked == 1)
	MOVLW      0
	XORWF      CarLock_locked+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main35
	MOVLW      1
	XORWF      CarLock_locked+0, 0
L__main35:
	BTFSC      STATUS+0, 2
	GOTO       L__main23
	MOVLW      0
	XORWF      CarLock_unlocked+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main36
	MOVLW      1
	XORWF      CarLock_unlocked+0, 0
L__main36:
	BTFSC      STATUS+0, 2
	GOTO       L__main23
	GOTO       L_main15
L__main23:
;CarLock.c,82 :: 		x++;
	INCF       CarLock_x+0, 1
	BTFSC      STATUS+0, 2
	INCF       CarLock_x+1, 1
;CarLock.c,84 :: 		if (x >= outTimeCheck)
	MOVLW      128
	XORWF      CarLock_x+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main37
	MOVLW      185
	SUBWF      CarLock_x+0, 0
L__main37:
	BTFSS      STATUS+0, 0
	GOTO       L_main16
;CarLock.c,86 :: 		locked = 0;
	CLRF       CarLock_locked+0
	CLRF       CarLock_locked+1
;CarLock.c,87 :: 		unlocked = 0;
	CLRF       CarLock_unlocked+0
	CLRF       CarLock_unlocked+1
;CarLock.c,88 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;CarLock.c,89 :: 		x = 0;
	CLRF       CarLock_x+0
	CLRF       CarLock_x+1
;CarLock.c,90 :: 		}
L_main16:
;CarLock.c,91 :: 		}
	GOTO       L_main17
L_main15:
;CarLock.c,92 :: 		else if (PORTB.B1 == 0 && PORTB.B2 == 1)
	BTFSC      PORTB+0, 1
	GOTO       L_main20
	BTFSS      PORTB+0, 2
	GOTO       L_main20
L__main22:
;CarLock.c,94 :: 		pressed = 0;
	CLRF       _pressed+0
	CLRF       _pressed+1
;CarLock.c,95 :: 		current = 0;
	CLRF       _current+0
	CLRF       _current+1
;CarLock.c,96 :: 		time = 0;
	CLRF       CarLock_time+0
	CLRF       CarLock_time+1
;CarLock.c,97 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;CarLock.c,98 :: 		}
L_main20:
L_main17:
L_main12:
L_main7:
;CarLock.c,105 :: 		Delay_ms(interval);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main21:
	DECFSZ     R13+0, 1
	GOTO       L_main21
	DECFSZ     R12+0, 1
	GOTO       L_main21
	NOP
;CarLock.c,106 :: 		enabled = 1;
	MOVLW      1
	MOVWF      _enabled+0
	MOVLW      0
	MOVWF      _enabled+1
;CarLock.c,107 :: 		} while (1);
	GOTO       L_main0
;CarLock.c,108 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
