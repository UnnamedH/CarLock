
_lock:

;MercLock.c,23 :: 		void lock()
;MercLock.c,25 :: 		x = 0;
	CLRF       MercLock_x+0
	CLRF       MercLock_x+1
;MercLock.c,26 :: 		PORTB.B5 = 1;
	BSF        PORTB+0, 5
;MercLock.c,27 :: 		locked = 1;
	MOVLW      1
	MOVWF      MercLock_locked+0
	MOVLW      0
	MOVWF      MercLock_locked+1
;MercLock.c,29 :: 		PORTB.B6 = 0;
	BCF        PORTB+0, 6
;MercLock.c,30 :: 		unlocked = 0;
	CLRF       MercLock_unlocked+0
	CLRF       MercLock_unlocked+1
;MercLock.c,32 :: 		enabled = 0;
	CLRF       _enabled+0
	CLRF       _enabled+1
;MercLock.c,34 :: 		pressed = 1;
	MOVLW      1
	MOVWF      _pressed+0
	MOVLW      0
	MOVWF      _pressed+1
;MercLock.c,35 :: 		}
L_end_lock:
	RETURN
; end of _lock

_unlock:

;MercLock.c,37 :: 		void unlock()
;MercLock.c,39 :: 		x = 0;
	CLRF       MercLock_x+0
	CLRF       MercLock_x+1
;MercLock.c,40 :: 		PORTB.B6 = 1;
	BSF        PORTB+0, 6
;MercLock.c,41 :: 		unlocked = 1;
	MOVLW      1
	MOVWF      MercLock_unlocked+0
	MOVLW      0
	MOVWF      MercLock_unlocked+1
;MercLock.c,43 :: 		PORTB.B5 = 0;
	BCF        PORTB+0, 5
;MercLock.c,44 :: 		locked = 0;
	CLRF       MercLock_locked+0
	CLRF       MercLock_locked+1
;MercLock.c,46 :: 		enabled = 0;
	CLRF       _enabled+0
	CLRF       _enabled+1
;MercLock.c,48 :: 		pressed = 1;
	MOVLW      1
	MOVWF      _pressed+0
	MOVLW      0
	MOVWF      _pressed+1
;MercLock.c,49 :: 		}
L_end_unlock:
	RETURN
; end of _unlock

_main:

;MercLock.c,51 :: 		void main()
;MercLock.c,53 :: 		TRISB = 0b00000110;
	MOVLW      6
	MOVWF      TRISB+0
;MercLock.c,55 :: 		do
L_main0:
;MercLock.c,57 :: 		if (PORTB.B1 == 1 && PORTB.B2 == 1 && enabled == 1 && pressed == 0) // Check Lock
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
	XORWF      _pressed+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main30
	MOVLW      0
	XORWF      _pressed+0, 0
L__main30:
	BTFSS      STATUS+0, 2
	GOTO       L_main5
L__main25:
;MercLock.c,59 :: 		time++;
	INCF       MercLock_time+0, 1
	BTFSC      STATUS+0, 2
	INCF       MercLock_time+1, 1
;MercLock.c,61 :: 		if (time >= inTimeCheck)
	MOVLW      128
	XORWF      MercLock_time+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVLW      32
	SUBWF      MercLock_time+0, 0
L__main31:
	BTFSS      STATUS+0, 0
	GOTO       L_main6
;MercLock.c,63 :: 		time = 0;
	CLRF       MercLock_time+0
	CLRF       MercLock_time+1
;MercLock.c,64 :: 		lock();
	CALL       _lock+0
;MercLock.c,65 :: 		}
L_main6:
;MercLock.c,66 :: 		}
	GOTO       L_main7
L_main5:
;MercLock.c,67 :: 		else if (PORTB.B1 == 0 && PORTB.B2 == 0 && enabled == 1 && pressed == 0) // Check Unlock
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
	XORWF      _pressed+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVLW      0
	XORWF      _pressed+0, 0
L__main33:
	BTFSS      STATUS+0, 2
	GOTO       L_main10
L__main24:
;MercLock.c,69 :: 		time++;
	INCF       MercLock_time+0, 1
	BTFSC      STATUS+0, 2
	INCF       MercLock_time+1, 1
;MercLock.c,71 :: 		if (time >= inTimeCheck)
	MOVLW      128
	XORWF      MercLock_time+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVLW      32
	SUBWF      MercLock_time+0, 0
L__main34:
	BTFSS      STATUS+0, 0
	GOTO       L_main11
;MercLock.c,73 :: 		time = 0;
	CLRF       MercLock_time+0
	CLRF       MercLock_time+1
;MercLock.c,74 :: 		unlock();
	CALL       _unlock+0
;MercLock.c,75 :: 		}
L_main11:
;MercLock.c,76 :: 		}
	GOTO       L_main12
L_main10:
;MercLock.c,77 :: 		else if (locked == 1 || unlocked == 1)
	MOVLW      0
	XORWF      MercLock_locked+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main35
	MOVLW      1
	XORWF      MercLock_locked+0, 0
L__main35:
	BTFSC      STATUS+0, 2
	GOTO       L__main23
	MOVLW      0
	XORWF      MercLock_unlocked+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main36
	MOVLW      1
	XORWF      MercLock_unlocked+0, 0
L__main36:
	BTFSC      STATUS+0, 2
	GOTO       L__main23
	GOTO       L_main15
L__main23:
;MercLock.c,79 :: 		x++;
	INCF       MercLock_x+0, 1
	BTFSC      STATUS+0, 2
	INCF       MercLock_x+1, 1
;MercLock.c,81 :: 		if (x >= onTimeCheck)
	MOVLW      128
	XORWF      MercLock_x+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main37
	MOVLW      185
	SUBWF      MercLock_x+0, 0
L__main37:
	BTFSS      STATUS+0, 0
	GOTO       L_main16
;MercLock.c,83 :: 		locked = 0;
	CLRF       MercLock_locked+0
	CLRF       MercLock_locked+1
;MercLock.c,84 :: 		unlocked = 0;
	CLRF       MercLock_unlocked+0
	CLRF       MercLock_unlocked+1
;MercLock.c,85 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MercLock.c,86 :: 		x = 0;
	CLRF       MercLock_x+0
	CLRF       MercLock_x+1
;MercLock.c,87 :: 		}
L_main16:
;MercLock.c,88 :: 		}
	GOTO       L_main17
L_main15:
;MercLock.c,89 :: 		else if (PORTB.B1 == 0 && PORTB.B2 == 1)
	BTFSC      PORTB+0, 1
	GOTO       L_main20
	BTFSS      PORTB+0, 2
	GOTO       L_main20
L__main22:
;MercLock.c,91 :: 		pressed = 0;
	CLRF       _pressed+0
	CLRF       _pressed+1
;MercLock.c,92 :: 		time = 0;
	CLRF       MercLock_time+0
	CLRF       MercLock_time+1
;MercLock.c,93 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MercLock.c,94 :: 		}
L_main20:
L_main17:
L_main12:
L_main7:
;MercLock.c,101 :: 		Delay_ms(interval);
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
;MercLock.c,102 :: 		enabled = 1;
	MOVLW      1
	MOVWF      _enabled+0
	MOVLW      0
	MOVWF      _enabled+1
;MercLock.c,103 :: 		} while (1);
	GOTO       L_main0
;MercLock.c,104 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
