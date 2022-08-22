# Car Lock

This is a project made in MikroC in C, for the PIC16F84A, but it can be used with virtually any MCU with a little bit of tweaking. The circuit schematics I used could be uploaded and published if needed.

This is a project for a central lock system of a car. It takes inputs from both R<sub>B1</sub> and R<sub>B2</sub> for a predefined duration, and outputs with a predefined duration to R<sub>B5</sub> and R<sub>B6</sub> to lock or unlock the car.

## Truth Table

<table>
<tr>
    <td colspan="2">Inputs</td>
    <td colspan="2">Outputs</td>
  </tr>
  <tr class="titles">
    <td><strong>RB1</strong></td>
    <td><strong>RB2</strong></td>
    <td><strong>RB5</strong></td>
    <td><strong>RB6</strong></td>
  </tr>
  <tr>
    <td>0</td>
    <td>1</td>
    <td>0</td>
    <td>0</td>
  </tr>
  <tr>
    <td>1</td>
    <td>1</td>
    <td>1</td>
    <td>0</td>
  </tr>
  <tr>
    <td>0</td>
    <td>1</td>
    <td>0</td>
    <td>0</td>
  </tr>
  <tr>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>1</td>
  </tr>
</table>

In this case, R<sub>B1</sub> is pulled down and R<sub>B2</sub> is pulled up. This was done since the signal is coming from a single wire.  
- When R<sub>B1</sub> is closed the system is locked.  
- When R<sub>B2</sub> is grounded the system is unlocked.

# Feedback / Support

This is primarily a finished project. And is not something I am prioritizing. But I am open to changing/fixing anything with your help.

### **I am still an amateur developer and I really appreciate any feedback :)**
