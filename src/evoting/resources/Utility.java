package evoting.resources;

import evoting.uliamar.Blake2s;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.xml.transform.Result;
import java.security.SecureRandom;
import java.sql.*;
import java.util.*;
import java.util.Date;

/**
 * Created by arpit on 31/1/17.
 */
public class Utility {
    public static int[] generateGridCard() {

        int a[]=new int[8];
        Random r = new Random();
        int low = 1;
        int high =8;

        for (int i = 0; i < 8; i++) {
            a[i]=r.nextInt(high-low)+low;
        }

        return a;
    }

    public static String gridToString(int a[]){

        StringBuilder sbr=new StringBuilder();
        for (int i = 0; i < 8; i++) {
            sbr.append(a[i]);
        }
        return sbr.toString();
    }

    public static String generateOtp() {
        String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        SecureRandom rnd = new SecureRandom();
        int len=16;
        StringBuilder sb = new StringBuilder( len );

        for( int i = 0; i < len; i++ )
            sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );

        return sb.toString();
    }

    public static boolean equalsGrid(String dbGrid, String userGrid) {

        for (int i = 0; i < userGrid.length(); i++) {

            if (userGrid.charAt(i)!='0' && userGrid.charAt(i)!=dbGrid.charAt(i))
                return false;

        }
        return true;
    }

    //This function checks whether the user's grid is valid or not.
    //This code has to be removed later.
    public static boolean equalsGridTemp(String dbGrid, String userGrid) {

        if (dbGrid.equals(userGrid))
            return true;

        return false;
    }

    public static String sendEmail(String to,String sub, String message){
        //Get properties object
        String from="proj.evoting@gmail.com";
        String password="nmims12345";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        //get Session
        Session session = Session.getDefaultInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(from, password);
                    }
                });
        //compose message
        try {
            MimeMessage mimeMessage = new MimeMessage(session);
            mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            mimeMessage.setSubject(sub);
            mimeMessage.setText(message);
            //send message
            Transport.send(mimeMessage);
            System.out.println("message sent successfully");
            return "success";
        }
        catch (MessagingException e) {
            e.printStackTrace();
            return "error";
        }

    }

    public static String countVotes(Connection con) {

        HashMap<String,Integer>voteCount=new HashMap<>();
        int hackedVotes=0;
        try {

            PreparedStatement statement=con.prepareStatement("select encryptedVote,hashedVote FROM USER WHERE encryptedVote IS NOT NULL and hashedVote IS NOT NULL ");

            ResultSet rs=statement.executeQuery();
            String decryptedVote,calculatedHash;
            while (rs.next()){

                decryptedVote=AES.decrypt(rs.getString(1));
                calculatedHash=calculateHash(decryptedVote);

                if (calculatedHash.equalsIgnoreCase(rs.getString(2)))
                {
                    System.out.println("line top");
                    if ("john".equalsIgnoreCase(decryptedVote)){

                        if (voteCount.containsKey("john")){
                            int temp=voteCount.get("john");
                            temp++;
                            voteCount.put("john", temp);
                        }
                        else voteCount.put("john",1);
                    }

                    else if ("lina".equalsIgnoreCase(decryptedVote)){

                        if (voteCount.containsKey("lina")){
                            int temp=voteCount.get("lina");
                            temp++;
                            voteCount.put("lina", temp);
                        }
                        else voteCount.put("lina",1);

                    }

                    else if ("micheal".equalsIgnoreCase(decryptedVote)){

                        System.out.println("line 2");

                        if (voteCount.containsKey("micheal")){
                            int temp=voteCount.get("micheal");
                            temp++;
                            voteCount.put("micheal", temp);
                        }
                        else voteCount.put("micheal",1);
                    }

                    else {
                        hackedVotes++;
                    }
                }
                else {
                    hackedVotes++;
                }

            }
            if (hackedVotes>0){
                updateHackedVotes(con, hackedVotes);
            }
            return updateVotesInTable(con, voteCount);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public static String bytesToHex(byte[] bytes) {
        final char[] hexArray = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
        char[] hexChars = new char[bytes.length * 2];
        int v;
        for ( int j = 0; j < bytes.length; j++ ) {
            v = bytes[j] & 0xFF;
            hexChars[j * 2] = hexArray[v >>> 4];
            hexChars[j * 2 + 1] = hexArray[v & 0x0F];
        }
        return new String(hexChars);
    }
    private static String calculateHash(String s){
        Blake2s b=new Blake2s(32,null);
        b.update(s.getBytes());
        byte[]temp=b.digest();
        String calculatedHash=new String(bytesToHex(temp));
        return calculatedHash;
    }
    private static String updateVotesInTable(Connection con, HashMap<String, Integer> count) {

        String []s;
        s=count.keySet().toArray(new String[count.size()]);
        try {
            PreparedStatement statement=con.prepareStatement("UPDATE vote SET COUNT=? WHERE party=?");
            for (String s1:s){
                statement.setInt(1,count.get(s1));
                statement.setString(2,s1);
                statement.addBatch();
            }
            statement.executeBatch();
            return "success";
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "error";
    }

    private static void updateHackedVotes(Connection con, int hackedVotes) {
        try {
            PreparedStatement statement=con.prepareStatement("UPDATE hackedVotes set COUNT =?");
            statement.setInt(1,hackedVotes);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }

    private static String decrypt(String encryptedVote) {
        return encryptedVote;
    }
}

