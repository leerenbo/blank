package it.pkg.util.base;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

/**
 * 功能描述：des加密解密
 * 时间：2014年9月1日 上午9:23:41
 * @author songxia
 */
public final class DESUtil {
	
	/**
	 * 3DES加密算法
	 */	
	private static final String Algorithm = "DES";
	private static final String Transformation = Algorithm + "/ECB/NoPadding";

	/**
	 * 加密
	 * @param keybyte  加密密钥，长度为24字节
	 * @param src  被加密的数据缓冲区（源）
	 * @return
	 */
	public static String encryptMode(String szsrc) {
		try {
			final byte[] keybyte = {0x6D, 0x75, 0x5E, 0x69, 0x4C, 0x6F, 0x7F, 0x7B};			
			String tmpstr = szsrc;				
			if ((tmpstr.length() % 8) != 0)
			{
				String specstr = "        ";
				specstr = specstr.substring(0,8-tmpstr.length() % 8);
				tmpstr = tmpstr + specstr;
			}
			
			byte[] src = tmpstr.getBytes();
			// 生成密钥
			SecretKey deskey = new SecretKeySpec(keybyte, Algorithm);
			// 加密
			Cipher c1 = Cipher.getInstance(Transformation);
			c1.init(Cipher.ENCRYPT_MODE, deskey);
			return byte2hex(c1.doFinal(src));
		} catch (java.security.NoSuchAlgorithmException e1) {
			e1.printStackTrace();
		} catch (javax.crypto.NoSuchPaddingException e2) {
			e2.printStackTrace();
		} catch (java.lang.Exception e3) {
			e3.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 解密
	 * @param keybyte  加密密钥，长度为24字节
	 * @param src  加密后的缓冲区
	 * @return
	 */
    public static String decryptMode(String szsrc) {
    	try {
    		final byte[] keybyte = {0x6D, 0x75, 0x5E, 0x69, 0x4C, 0x6F, 0x7F, 0x7B};				
    		byte[] src = hex2byte(szsrc);
    		// 生成密钥
    		SecretKey deskey = new SecretKeySpec(keybyte, Algorithm);            
    		// 解密
    		Cipher c1 = Cipher.getInstance(Transformation);            
    		c1.init(Cipher.DECRYPT_MODE, deskey);            
    		return new String(c1.doFinal(src)).trim();       
    	} catch (java.security.NoSuchAlgorithmException e1) {            
    		e1.printStackTrace();        
    	} catch (javax.crypto.NoSuchPaddingException e2) {            
    		e2.printStackTrace();        
    	} catch (java.lang.Exception e3) {            
    		e3.printStackTrace();        
    	}        
    	return null;    
    }

    /**
     * 转换成十六进制字符串
     * @param b
     * @return
     */
    public static String byte2hex(byte[] b) {     
    	String hs="";        
    	String stmp="";        
    	for (int n=0;n<b.length;n++) {     
    		stmp=(java.lang.Integer.toHexString(b[n] & 0XFF));
    		if (stmp.length()==1) 
    			hs=hs+"0"+stmp;            
    		else 
    			hs=hs+stmp; 
    	}        
    	return hs.toUpperCase();    
    } 
    
    /**
     * 将16进制字符串转换成字节码
     * @param hex
     * @return
     */
    public static byte[] hex2byte(String hex) {
      byte[] bts = new byte[hex.length() / 2];
      for (int i = 0; i < bts.length; i++) {
         bts[i] = (byte) Integer.parseInt(hex.substring(2*i, 2*i+2), 16);
      }
      return bts; 
    }  
    
}
