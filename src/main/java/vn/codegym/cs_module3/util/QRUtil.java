package vn.codegym.cs_module3.util;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;

import java.io.IOException;
import java.nio.file.*;

public class QRUtil {
    public static String generateQRCodePng(String content, String outputDir, String fileNameNoExt, int size)
            throws IOException, WriterException {
        Files.createDirectories(Paths.get(outputDir));
        BitMatrix matrix = new QRCodeWriter().encode(content, BarcodeFormat.QR_CODE, size, size);
        String filePath = outputDir + "/" + fileNameNoExt + ".png";
        MatrixToImageWriter.writeToPath(matrix, "PNG", Paths.get(filePath));
        return filePath;
    }
}
