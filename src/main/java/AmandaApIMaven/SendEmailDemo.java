package AmandaApIMaven;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/**
 * @author yanbingHuang
 * @create 2020-07-2020/7/21 4:34 下午
 **/
public class SendEmailDemo {
    public static void main(String[] args) {
        String to = "hyb1989.h@gmail.com";
        String from = "hyb1989.h@gmail.com";
        String host = "localhost";
        Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        Session session = Session.getDefaultInstance(properties);
        try {
            MimeMessage mimeMessage = new MimeMessage(session);
            mimeMessage.setFrom(new InternetAddress(from));
            mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            mimeMessage.setSubject("this is the subject line!");
            mimeMessage.setText("this is actual message");
            Transport.send(mimeMessage);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
