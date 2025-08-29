package vn.codegym.cs_module3.util;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.Hex;

public class SignUtil {
    private static final String SECRET = System.getenv().getOrDefault("QR_SECRET", "change-me");

    public static String hmacSha256(String data) {
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(new SecretKeySpec(SECRET.getBytes("UTF-8"), "HmacSHA256"));
            return Hex.encodeHexString(mac.doFinal(data.getBytes("UTF-8")));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /** QR payload: ticketId:eventId:signature */
    public static String sign(long ticketId, long eventId) {
        String raw = ticketId + ":" + eventId;
        return raw + ":" + hmacSha256(raw);
    }

    public static boolean verify(String ticketId, String eventId, String sig) {
        String expect = hmacSha256(ticketId + ":" + eventId);
        return expect.equalsIgnoreCase(sig);
    }
}
