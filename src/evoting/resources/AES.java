package evoting.resources;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.Key;
import java.security.spec.KeySpec;
import java.util.Base64;

/**
 * Created by hardCode on 3/27/2017.
 */
public class AES {

    static byte keyX[]=new byte[]{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
    static String keyValue = "Abcdefghijklmnop";
    static String iv="dc0da04af8fee58593442bf834b30739";

    public static String decrypt(String base64CipherText)throws Exception{

        SecretKeyFactory factory =   SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
        KeySpec spec = new PBEKeySpec(keyValue.toCharArray(), hex(iv), 1000, 128);

        Key key = new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, key, new IvParameterSpec(hex(iv)));
        byte[] decrypted = cipher.doFinal(Base64.getDecoder().decode(base64CipherText.getBytes()));

        //String base64EncodedEncryptedData = new String(Base64.getEncoder().encode(decrypted));
        return new String(decrypted);
    }



    public static String encrypt(String plainText)throws Exception{

        SecretKeyFactory factory =   SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
        KeySpec spec = new PBEKeySpec(keyValue.toCharArray(), hex(iv), 1000, 128);

        Key key = new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        c.init(Cipher.ENCRYPT_MODE, key, new IvParameterSpec(hex(iv)));

        byte[] encVal = c.doFinal(plainText.getBytes());
        String base64EncodedEncryptedData = new String(Base64.getEncoder().encode(encVal));
        return base64EncodedEncryptedData;
    }

    public static byte[] hex(String s) {

        int len = s.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
                    + Character.digit(s.charAt(i+1), 16));
        }
        return data;
    }


}
