#line 1 "C:/Users/pc/Desktop/Merc-main/MercLock.c"
static int time = 0;
static int x = 0;

static int locked = 0;
static int unlocked = 0;

const int interval = 20;

const float inTimeSec = 0.65;
const int inTime = inTimeSec * 1000;
const float onTimeSec = 4;
const int onTime = onTimeSec * 1000;

const int inTimeCheck = inTime / interval;
const int onTimeCheck = onTime / interval;

void lock()
{
 x = 0;
 PORTB.B5 = 1;
 locked = 1;

 PORTB.B6 = 0;
 unlocked = 0;
}

void unlock()
{
 x = 0;
 PORTB.B6 = 1;
 unlocked = 1;

 PORTB.B5 = 0;
 locked = 0;
}

void main()
{
 TRISB = 0b00000110;

 do
 {
 if (PORTB.B1 == 1)
 {
 time++;

 if (time >= inTimeCheck)
 {
 time = 0;
 lock();
 }
 }
 else if (PORTB.B2 == 1)
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

 if (x >= onTimeCheck)
 {
 locked = 0;
 unlocked = 0;
 x = 0;
 }
 }
 else
 {
 PORTB = 0x00;
 time = 0;
 }

 Delay_ms(interval);
 } while (1);
}
