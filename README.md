# Car Lock

A project for a central lock system, where a signal is coming in from both B1 and B2 for a defined duration to lock or unlock the car, by sending a signal with a predefined duration to the outputs B5 and B6.

# Truth Table

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
