package com.newSoftMex.Utilities;

import javax.servlet.http.Part;

/**
 * Created by alan.flores on 2/16/17.
 */
public final class FileUtil {

    public static String getExtention(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                String[] s = fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1).replace('.','-').split("-");
                return s[s.length - 1]; // MSIE fix.
            }
        }
        return null;
    }
}
