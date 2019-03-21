import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

//clase de los token devueltos
class Yytoken {
    Yytoken (int numToken,String token, String tipo, int linea, int columna){
        //Contador para el número de tokens reconocidos
        this.numToken = numToken;
        //String del token reconocido
        this.token = new String(token);
        //Tipo de componente léxico encontrado
        this.tipo = tipo;
        //Número de linea
        this.linea = linea;
        //Columna donde empieza el primer carácter del token
        this.columna = columna;
    }
    //Métodos de los atributos de la clase
    public int numToken;
    public String token;
    public String tipo;
    public int linea;
    public int columna;
    //Metodo que devuelve los datos necesarios que escribiremos en un archive de salida
    public String toString() {
        return "Token #"+numToken+": "+token+" Tipo: "+tipo+" ["+linea
        + "," +columna + "]";
    }
}

%%

%function nextToken
%public
%class AnalizadoLexico
%unicode
%char
%{
	private int contador;
	private ArrayList<Yytoken> tokens;
	private void writeOutputFile() throws IOException{
	String filename = "C:/Users/erck_/IdeaProjects/Lexico/src/file.out";
	BufferedWriter out = new BufferedWriter(
		new FileWriter(filename));
	System.out.println("\n ***Tokens Guardados en archivo ** \n");
	for(Yytoken t: this.tokens){
	System.out.println(t);
	out.write(t + "\n");
}
	out.close();
}
%}
%init{
	contador = 0;
	tokens = new ArrayList<Yytoken>();

%init}
%eof{
	try{
	this.writeOutputFile();
	System.exit(0);
}catch(IOException ioe){
	ioe.printStackTrace();
}

%eof}


%line
%column

EXP_ALPHA = [A-Za-z]
EXP_DIGITO = [0-9]
EXP_ALPHANUMERIC ={EXP_ALPHA}|{EXP_DIGITO}
NUMERO = ({EXP_DIGITO})+
IDENTIFICADOR = {EXP_ALPHA}({EXP_ALPHANUMERIC})*
ESPACIO = " "
SALTO = \n|\r|\r\n

%%
{NUMERO} {
	contador++;
	Yytoken t = new Yytoken(contador,yytext(),"num",yyline,yycolumn);
	tokens.add(t);
	return t;
}

"int" {
	contador++;
	Yytoken t = new Yytoken(contador,yytext(),"entero",yyline,yycolumn);
	tokens.add(t);
	return t;
}
"float" {
	contador++;
	Yytoken t = new Yytoken(contador,yytext(),"flotante",yyline,yycolumn);
	tokens.add(t);
	return t;
}

{IDENTIFICADOR} {
	contador++;
	Yytoken t = new Yytoken(contador,yytext(),"id",yyline,yycolumn);
	tokens.add(t);
	return t;
}

"+=" {
	contador++;
	Yytoken t = new Yytoken(contador,yytext(),"asigna_suma",yyline,yycolumn);
	tokens.add(t);
	return t;
}

"+" {
	contador++;
	Yytoken t = new Yytoken(contador,yytext(),"suma",yyline,yycolumn);
	tokens.add(t);
	return t;
}

"=" {
	contador++;
	Yytoken t = new Yytoken(contador,yytext(),"asignacion",yyline,yycolumn);
	tokens.add(t);
	return t;
}
"-" {
	contador++;
	Yytoken t = new Yytoken(contador,yytext(),"resta",yyline,yycolumn);
	tokens.add(t);
	return t;
}
"*" {
	contador++;
	Yytoken t = new Yytoken(contador,yytext(),"multiplicacion",yyline,yycolumn);
	tokens.add(t);
	return t;
}
"/" {
	contador++;
	Yytoken t = new Yytoken(contador,yytext(),"division",yyline,yycolumn);
	tokens.add(t);
	return t;
}

{SALTO} {
	contador++;
	Yytoken t = new Yytoken(contador,"","Fin_Linea",yyline,yycolumn);
	tokens.add(t);
	return t;
}
[^]                    { throw new Error("Illegal character <"+yytext()+">"); }