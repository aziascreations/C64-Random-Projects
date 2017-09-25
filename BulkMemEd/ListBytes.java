import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

public class ListBytes {
	//public static final String filePath = "./example.prg", logFileName = "./example-hex.txt";
	public static File prgFile;

	public static ArrayList<String> filePaths = new ArrayList<String>();

	public static boolean cm = true; // Compact mode

	public static void main(String[] args) {
		for(String arg:args) {
			switch(arg) {
				case "nc":
					cm = false;
					break;
				default:
					filePaths.add(arg);
					break;
			}
		}

		for(String fileName:filePaths) {
			byte[] tmp = null;
			try {
				tmp = getFileContent(fileName);
				if(tmp!=null) {
					printFileHexCode(fileName+".hex", tmp);
				} else {
					System.err.println("Error: There is nothing to work with...");
				}
			} catch(IOException e) {
				System.err.println(e);
			}
		}
	}

	public static void printFileHexCode(String logFileName, byte[] data) throws IOException {
		FileWriter fv = new FileWriter(logFileName);
		fv.write("> "+prgFile.getName()+"\n");
		fv.write("> "+data.length+" byte(s)\n\n");
		fv.write("J"+Integer.toHexString(twoBytesToShort(data[1],data[0])).toUpperCase()+"\n");
		boolean isDone = false;
		int j = 0;
		while(!isDone) {
			if(j%76 == 0) {
				fv.write("\n"+(cm?"":(j!=0?"\n":"")+"? "));
			}

			if(j >= data.length-2) {
				isDone = true;
				fv.write(cm?"\n":"\n\n? \n");
			} else {
				fv.write(Integer.toHexString(data[j+2]).toUpperCase()+(cm?"":" "));
				j++;
			}

			if(j%76==38) {
				fv.write(cm?"":"\n");
			}
		}
		fv.close();
		System.out.println("Done");
	}

	public static short twoBytesToShort(byte b1, byte b2) {
		return (short) ((b1 << 8) | (b2 & 0xFF));
	}

	public static int unsignedToBytes(byte b) {
		return b & 0xFF;
	}

	public static byte[] getFileContent(String filePath) throws IOException {
		prgFile = new File(filePath);
		
		if(!prgFile.exists() || !prgFile.isFile()) {
			System.err.println("Error: "+filePath+" doesn't exists or is a directory !");
			return null;
		}
		
		Path path = Paths.get(filePath);
		byte[] data = Files.readAllBytes(path);

		System.out.println("> "+prgFile.getName());
		if(data.length<=1) {
			System.err.println(filePath+" is too short.");
			return null;
		}

		return data;
	}
}

/*public void run() {
	ListBytes.main(new String[]{});
}/**/
