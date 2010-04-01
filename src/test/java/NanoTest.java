import java.util.List;
import org.junit.Test;
import org.antlr.runtime.*;
import java.io.FileInputStream;

public class NanoTest {

@Test public void testGrade() throws Exception {parse("src/test/programs/Grade.nano");}
@Test public void testcomment() throws Exception {parse("src/test/programs/comment.nano");}
@Test public void testconst_decl() throws Exception {parse("src/test/programs/const_decl.nano");}
@Test public void testfor() throws Exception {parse("src/test/programs/for.nano");}
@Test public void testproc_decl() throws Exception {parse("src/test/programs/proc_decl.nano");}
@Test public void testvar_decl() throws Exception {parse("src/test/programs/var_decl.nano");}

  public void parse(String fileName) throws Exception {
    // Create an input character stream from standard in
    ANTLRInputStream input = new ANTLRInputStream(new FileInputStream(fileName));
    // Create an ExprLexer that feeds from that stream
    NanoLexer lexer = new NanoLexer(input);
    // Create a stream of tokens fed by the lexer
    CommonTokenStream tokens = new CommonTokenStream(lexer);
    List list = tokens.getTokens();
    // Create a parser that feeds off the token stream
    NanoParser parser = new NanoParser(tokens);
    // Begin parsing at rule prog
    parser.prog();

    for(Object object  : list){
        Token token = (Token) object;
	System.out.println(token.getText());
    }
  }
}
