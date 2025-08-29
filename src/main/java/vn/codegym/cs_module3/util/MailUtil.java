package vn.codegym.cs_module3.util;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;
import java.io.File;

public class MailUtil {
    private static Session createSession() {
        final String user = System.getenv("MAIL_USER");
        final String pass = System.getenv("MAIL_PASS");

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        return Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, pass);
            }
        });
    }

    public static void sendWithQr(String toEmail, String subject, String htmlBody, File qrImage) throws Exception {
        String from = System.getenv("MAIL_USER");
        String fromName = System.getenv().getOrDefault("MAIL_FROM_NAME", "Event Ticketing");

        Session session = createSession();
        MimeMessage msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(from, fromName, "UTF-8"));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
        msg.setSubject(subject, "UTF-8");

        MimeBodyPart html = new MimeBodyPart();
        html.setContent(htmlBody, "text/html; charset=UTF-8");

        MimeBodyPart attach = new MimeBodyPart();
        attach.attachFile(qrImage);
        attach.setFileName("ticket-qr.png");

        Multipart mixed = new MimeMultipart();
        mixed.addBodyPart(html);
        mixed.addBodyPart(attach);
        msg.setContent(mixed);

        Transport.send(msg);
    }
}
