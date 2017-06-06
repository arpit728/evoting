package evoting.uliamar;

public class Main {

    //    https://github.com/dchest/blake2s-js/blob/master/blake2s.js
    public static void main(String[] args) throws Exception {
        Blake2s b=new Blake2s(32,null);
        b.update("john".getBytes());
        byte[]temp=b.digest();
        String s=new String(temp);
        String x=new String(bytesToHex(temp));
        System.out.println(x);
        System.out.println("06ED8343267C8251F04D5D528FF3FE9CFFBAFEC0052BFF3F615B3EAEA24DF4D4");
        System.out.println("06ED8343267C8251F04D5D528FF3FE9CFFBAFEC0052BFF3F615B3EAEA24DF4D4".equalsIgnoreCase(x));

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


}
