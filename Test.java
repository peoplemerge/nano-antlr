import org.antlr.runtime.*;
public class Test {
public static void main(String[] args) throws Exception {
// Create an input character stream from standard in
ANTLRInputStream input = new ANTLRInputStream(System.in);
// Create an ExprLexer that feeds from that stream
NanoLexer lexer = new NanoLexer(input);
// Create a stream of tokens fed by the lexer
CommonTokenStream tokens = new CommonTokenStream(lexer);
// Create a parser that feeds off the token stream
NanoParser parser = new NanoParser(tokens);
// Begin parsing at rule prog
parser.prog();
}
}
