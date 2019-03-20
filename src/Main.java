import java.io.File;

public class Main {
    public static void main(String[] args){
        String path = "C:/Users/erck_/IdeaProjects/Lexico/src/Lexer.flex";
        generarLexer(path);
    }
    public static void generarLexer(String path) {
        File file = new File(path);
        jflex.Main.generate(file);

    }
}
