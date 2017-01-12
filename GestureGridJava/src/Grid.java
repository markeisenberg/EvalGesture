import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFrame;
import javax.swing.JPanel;

import com.intel.bluetooth.BlueCoveConfigProperties;

import control.Wiigee;
import device.Wiimote;
import event.GestureEvent;
import event.GestureListener;
import event.InfraredEvent;
import event.WiimoteListener;
import event.WiimoteMotionStartEvent;
import event.WiimoteMotionStopEvent;
import event.StateEvent;
import event.WiimoteAccelerationEvent;
import event.WiimoteButtonPressedEvent;
import event.WiimoteButtonReleasedEvent;

public class Grid extends JPanel implements KeyListener, GestureListener{
    int x = 580;
    int y = 340;

    Color dotCol = Color.YELLOW;

    public static Wiigee wiigee;
    static Grid expo;

    void Grid(){
        wiigee.addGestureListener(this);

        //BlueCoveConfigProperties.PROPERTY_JSR_82_PSM_MINIMUM_OFF
    }


    public static void main(String[] args) throws InterruptedException {
        try {
            wiigee = Wiigee.getInstance();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        wiigee.setTrainButton(Wiimote.BUTTON_A);
        wiigee.setCloseGestureButton(Wiimote.BUTTON_HOME);
        wiigee.setRecognitionButton(Wiimote.BUTTON_B);
        //wiigee.setMotionChangeTime(int milliseconds);


        expo = new Grid();
        JFrame f = new JFrame();

        f.setVisible(true);
        f.setSize(1280,800);
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        f.addKeyListener(expo);

        f.add(expo);
        f.repaint();
    }



    @Override
    public void keyTyped(KeyEvent e) {
        //System.out.println("Key Typed");

    }

    @Override
    public void keyPressed(KeyEvent e) {

        if(e.getKeyCode() == KeyEvent.VK_DOWN){
           // System.out.println("Key Pressed" + e.getKeyCode());
            y = y + 160;

            if (y > 660){
                y = 660;
              }

            repaint();//add this line to update the UI
        }
        if(e.getKeyCode() == KeyEvent.VK_UP){
            //System.out.println("Key Pressed" + e.getKeyCode());
            y = y - 160;

            if (y < 20){
                y = 20;
              }

            repaint();//add this line to update the UI
        }
        if(e.getKeyCode() == KeyEvent.VK_RIGHT){
            //System.out.println("Key Pressed" + e.getKeyCode());
            x = x + 160;

            if (x > 900){
                x = 900;
              }

            repaint();//add this line to update the UI
        }
        if(e.getKeyCode() == KeyEvent.VK_LEFT){
            //System.out.println("Key Pressed" + e.getKeyCode());
            x = x - 160;

            if (x < 260){
                x = 260;
              }

            repaint();//add this line to update the UI
        }
    }

    @Override
    public void keyReleased(KeyEvent e) {
        //System.out.println("Key Released");

         if(e.getKeyCode() == KeyEvent.VK_1){
             wiigee.setRecognitionButton(Wiimote.MOTION);
         }else if(e.getKeyCode() == KeyEvent.VK_2){
             wiigee.setRecognitionButton(Wiimote.BUTTON_B);
         }
    }

    public void paint(Graphics g){
        super.paint(g);//you should always call the super-method first

        //background
        g.setColor(Color.BLACK);
        g.fillRect(0,0,1280,800);


        g.setColor(Color.WHITE);

        //block 1.1
        g.drawRect(240, 0, 160, 160);
        //block 1.2
        g.drawRect(240, 160, 160, 160);
        //block 1.3
        g.drawRect(240, 320, 160, 160);
        //block 1.4
        g.drawRect(240, 480, 160, 160);
        //block 1.5
        g.drawRect(240, 640, 160, 160);

        //block 2.1
        g.drawRect(400, 0, 160, 160);
      //block 2.2
        g.drawRect(400, 160, 160, 160);
      //block 2.3
        g.drawRect(400, 320, 160, 160);
      //block 2.4
        g.drawRect(400, 480, 160, 160);
      //block 2.5
        g.drawRect(400, 640, 160, 160);

      //block 3.1
        g.drawRect(560, 0, 160, 160);
      //block 3.2
        g.drawRect(560, 160, 160, 160);
      //block 3.3
        g.drawRect(560, 320, 160, 160);
      //block 3.4
        g.drawRect(560, 480, 160, 160);
      //block 3.5
        g.drawRect(560, 640, 160, 160);

      //block 4.1
        g.drawRect(720, 0, 160, 160);
      //block 4.2
        g.drawRect(720, 160, 160, 160);
      //block 4.3
        g.drawRect(720, 320, 160, 160);
      //block 4.4
        g.drawRect(720, 480, 160, 160);
      //block 4.5
        g.drawRect(720, 640, 160, 160);

      //block 5.1
        g.drawRect(880, 0, 160, 160);
      //block 5.2
        g.drawRect(880, 160, 160, 160);
      //block 5.3
        g.drawRect(880, 320, 160, 160);
      //block 5.4
        g.drawRect(880, 480, 160, 160);
      //block 5.5
        g.drawRect(880, 640, 160, 160);

        //Red block
        g.setColor(Color.RED);
        g.fillRect(x ,y,120,120);

        //Yellow circle
        g.setColor(dotCol);
        g.fillOval(720 + 30, 160 + 30, 100, 100);
    }



    @Override
    public void gestureReceived(GestureEvent event) {
        // TODO Auto-generated method stub
        System.out.println("Received Something");
    }



    @Override
    public void stateReceived(StateEvent event) {
        // TODO Auto-generated method stub
        System.out.println("Received Something 2");
    }



}

