package nano;
import java.io.FileInputStream;
import java.io.InputStream;

import nano.Nano2Parser.prog_return;

import org.antlr.runtime.ANTLRInputStream;
import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.tree.CommonTreeNodeStream;
import org.junit.Test;

public class Nano2Test {
/*
	@Test
	public void testGrade() throws Exception {
		parse("src/test/programs/Grade.nano");
	}

	@Test
	public void testcomment() throws Exception {
		parse("src/test/programs/comment.nano");
	}

	@Test
	public void testconst_decl() throws Exception {
		parse("src/test/programs/const_decl.nano");
	}

	@Test
	public void testfor() throws Exception {
		parse("src/test/programs/for.nano");
	}

	@Test
	public void testproc_decl() throws Exception {
		parse("src/test/programs/proc_decl.nano");
	}

	@Test
	public void testvar_decl() throws Exception {
		parse("src/test/programs/var_decl.nano");
	}
    @Test
    public void testSimple() throws Exception {
            parse("src/test/programs/simple.nano");
    }
	*/
    
    @Test
    public void testExpression()throws Exception {
            parse(
            		"x := 4; " +
    				"y := 2 + 3; " +
    				"3  * (-x + y) * 3");
    }

    @Test
    public void testDefExpression()throws Exception {
            parse(
            		"var x : integer; var y: integer; " +
            		"x := 4; " +
    				"y := 2 + 3; " +
    				"3  * (-x + y) * 3");
    }

    @Test
    public void testMultiDefExpression()throws Exception {
            parse(
            		"var x, y : integer; " +
            		"x := 4; " +
    				"y := 2 + 3; " +
    				"3  * (-x + y) * 3");
    }

	public void parse(InputStream inputStream) throws Exception {
		// Create an input character stream from standard in
		ANTLRInputStream input = new ANTLRInputStream(inputStream);
		// Create an ExprLexer that feeds from that stream
		process(input);
	}
	public void parse(String inputStr) throws Exception {
		// Create an input character stream from standard in
		ANTLRStringStream input = new ANTLRStringStream(inputStr);
		// Create an ExprLexer that feeds from that stream
		process(input);
	}

	private void process(ANTLRStringStream input) throws RecognitionException {
		Nano2Lexer lexer = new Nano2Lexer(input);
		// Create a stream of tokens fed by the lexer
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		
		// Create a parser that feeds off the token stream
		Nano2Parser parser = new Nano2Parser(tokens);
		// Begin parsing at rule prog
		prog_return prog = parser.prog();
		System.out.println(prog.tree.toStringTree());
		CommonTreeNodeStream stream = new CommonTreeNodeStream(prog.tree);
		ProgWalker walker = new ProgWalker(stream);
		int result = walker.evaluator();
		System.out.println("result: " + result);
	}
}
