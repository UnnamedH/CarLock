#line 1 "C:/Users/pc/Desktop/CarLock/CarLock.c"



static int time = 0;
static int x = 0;

static int locked = 0;
static int unlocked = 0;

const int interval = 20;

const float inTimeSec = 0.65;
const int inTime = inTimeSec * 1000;
const float outTimeSec = 3.7;
const int outTime = outTimeSec * 1000;

const int inTimeCheck = inTime / interval;
const int outTimeCheck = outTime / interval;

int current = 0;

int enabled = 0;

int pressed = 0;

void lock()
{
 x = 0;
 PORTB.B5 = 1;
 locked = 1;

 PORTB.B6 = 0;
 unlocked = 0;

 enabled = 0;
 current = 1;

}

void unlock()
{
 x = 0;
 PORTB.B6 = 1;
 unlocked = 1;

 PORTB.B5 = 0;
 locked = 0;

 enabled = 0;
 current = 2;

}

void main()
{
 TRISB = 0b00000110;

 do
 {
 if (PORTB.B1 == 1 && PORTB.B2 == 1 && enabled == 1 && current != 1)
 {
 time++;

 if (time >= inTimeCheck)
 {
 time = 0;
 lock();
 }
 }
 else if (PORTB.B1 == 0 && PORTB.B2 == 0 && enabled == 1 && current != 2)
 {
 time++;

 if (time >= inTimeCheck)
 {
 time = 0;
 unlock();
 }
 }
 else if (locked == 1 || unlocked == 1)
 {
 x++;

 if (x >= outTimeCheck)
 {
 locked = 0;
 unlocked = 0;
 PORTB = 0x00;
 x = 0;
 }
 }
 else if (PORTB.B1 == 0 && PORTB.B2 == 1)
 {
 pressed = 0;
 current = 0;
 time = 0;
 PORTB = 0x00;
 }






 Delay_ms(interval);
 enabled = 1;
 } while (1);
}
