import java.awt.FlowLayout;
import java.awt.Window;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.lang.reflect.Method;

import javax.swing.JButton;
import javax.swing.JFrame;

public class TestFull implements ActionListener {

    private Object applicationObject;
    private Method fullScreenMethod;
    private Window window;

    public TestFull() {
        window = new JFrame("Fullscreen Test");
        try {
            Class<?> util = Class.forName("com.apple.eawt.FullScreenUtilities");
            Method method = util.getMethod("setWindowCanFullScreen", Window.class, Boolean.TYPE);
            method.invoke(util, window, true);

            Class<?> application = Class.forName("com.apple.eawt.Application");
            fullScreenMethod = application.getMethod("requestToggleFullScreen", Window.class);
            applicationObject = application.newInstance();
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        }
        window.setSize(1280, 800);
        window.setLayout(new FlowLayout());
        JButton button = new JButton("Toggle Fullscreen");
        button.addActionListener(this);
        window.add(button);
        window.setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent event) {
        try {
            fullScreenMethod.invoke(applicationObject, window);
        } catch (Exception e) {
            e.printStackTrace();
        } 
    }

    public static void main(String[] args) {
        new TestFull();
    }

}