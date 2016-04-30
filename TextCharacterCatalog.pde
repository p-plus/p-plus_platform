public class TextCharacterCatalog {
  private HashMap charactersMap;
  
  public TextCharacterCatalog() {
    init();
  }
  
  private void init() {
    charactersMap = new HashMap<String, TextCharacter>();
    
    charactersMap.put("A", new A_Character());
    charactersMap.put("B", new B_Character());
    charactersMap.put("C", new C_Character());
    charactersMap.put("D", new D_Character());
    charactersMap.put("E", new E_Character());
    charactersMap.put("F", new F_Character());
    charactersMap.put("G", new G_Character());
    charactersMap.put("H", new H_Character());
    charactersMap.put("I", new I_Character());
    charactersMap.put("J", new J_Character());
    charactersMap.put("K", new K_Character());
    charactersMap.put("L", new L_Character());
    charactersMap.put("M", new M_Character());
    charactersMap.put("N", new N_Character());
    charactersMap.put("O", new O_Character());
    charactersMap.put("P", new P_Character());
    charactersMap.put("Q", new Q_Character());
    charactersMap.put("R", new R_Character());
    charactersMap.put("S", new S_Character());
    charactersMap.put("T", new T_Character());
    charactersMap.put("U", new U_Character());
    charactersMap.put("V", new V_Character());
    charactersMap.put("W", new W_Character());
    charactersMap.put("X", new X_Character());
    charactersMap.put("Y", new Y_Character());
    charactersMap.put("Z", new Z_Character());
    charactersMap.put(" ", new SPACE_Character());
    charactersMap.put("!", new Exclamation_Character());
    charactersMap.put(",", new Comma_Character());
    charactersMap.put(".", new Period_Character());
    charactersMap.put("@", new At_Character());
    charactersMap.put("?", new QuestionMark_Character());
    charactersMap.put("$", new Dollar_Character());
    charactersMap.put("%", new Percent_Character());
    charactersMap.put("&", new Ampersand_Character());
    charactersMap.put(";", new Semicolon_Character());
    charactersMap.put(":", new Colon_Character());
    charactersMap.put("[", new OpeningBracket_Character());
    charactersMap.put("{", new OpeningBracket_Character());
    charactersMap.put("<", new OpeningBracket_Character());
    charactersMap.put("]", new ClosingBracket_Character());
    charactersMap.put("}", new ClosingBracket_Character());
    charactersMap.put(">", new ClosingBracket_Character());
    charactersMap.put("-", new Dash_Character());
    charactersMap.put("=", new Equals_Character());
    charactersMap.put("\"", new DoubleQuotes_Character());
    charactersMap.put("\'", new SingleQuotes_Character());
    charactersMap.put("1", new One_Character());
    charactersMap.put("2", new Two_Character());
    charactersMap.put("3", new Three_Character());
    charactersMap.put("4", new Four_Character());
    charactersMap.put("5", new Five_Character());
    charactersMap.put("6", new Six_Character());
    charactersMap.put("7", new Seven_Character());
    charactersMap.put("8", new Eight_Character());
    charactersMap.put("9", new Nine_Character());
    charactersMap.put("0", new Zero_Character());
  }
  
  public TextCharacter get(String c) {
    if(charactersMap.containsKey(c)){
    return (TextCharacter)charactersMap.get(c);
    } else return (TextCharacter)charactersMap.get(" ");
  }
}


/////////////////////////////////////////////////////
//                         A
/////////////////////////////////////////////////////
public class A_Character extends TextCharacter {
  
  public A_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         B
/////////////////////////////////////////////////////
public class B_Character extends TextCharacter {
  
  public B_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    column_0.getPixelSets()[0].getPixels()[3] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    column_0.getPixelSets()[2].getPixels()[3] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         C
/////////////////////////////////////////////////////
public class C_Character extends TextCharacter {
  
  public C_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         D
/////////////////////////////////////////////////////
public class D_Character extends TextCharacter {
  
  public D_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    column_0.getPixelSets()[0].getPixels()[3] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    column_0.getPixelSets()[2].getPixels()[3] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         E
/////////////////////////////////////////////////////
public class E_Character extends TextCharacter {
  
  public E_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         F
/////////////////////////////////////////////////////
public class F_Character extends TextCharacter {
  
  public F_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         G
/////////////////////////////////////////////////////
public class G_Character extends TextCharacter {
  
  public G_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         H
/////////////////////////////////////////////////////
public class H_Character extends TextCharacter {
  
  public H_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         I
/////////////////////////////////////////////////////
public class I_Character extends TextCharacter {
  
  public I_Character() {
    initColumns(1);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         J
/////////////////////////////////////////////////////
public class J_Character extends TextCharacter {
  
  public J_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         K
/////////////////////////////////////////////////////
public class K_Character extends TextCharacter {
  
  public K_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
  }
  
}


/////////////////////////////////////////////////////
//                         L
/////////////////////////////////////////////////////
public class L_Character extends TextCharacter {
  
  public L_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
  }
  
}


/////////////////////////////////////////////////////
//                         M
/////////////////////////////////////////////////////
public class M_Character extends TextCharacter {
  
  public M_Character() {
    initColumns(3);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
        
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];

    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[1] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
    
    // COLUMN 2
    PixelSetColumn column_2 = getColumns()[2];
    
    column_2.getPixelSets()[0].getPixels()[2] = true;
    
    column_2.getPixelSets()[1].getPixels()[0] = true;
    column_2.getPixelSets()[1].getPixels()[2] = true;
    
    column_2.getPixelSets()[2].getPixels()[0] = true;
    column_2.getPixelSets()[2].getPixels()[3] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         N
/////////////////////////////////////////////////////
public class N_Character extends TextCharacter {
  
  public N_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
        
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         O
/////////////////////////////////////////////////////
public class O_Character extends TextCharacter {
  
  public O_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         P
/////////////////////////////////////////////////////
public class P_Character extends TextCharacter {
  
  public P_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         Q
/////////////////////////////////////////////////////
public class Q_Character extends TextCharacter {
  
  public Q_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    
    column_1.getPixelSets()[0].getPixels()[1] = true;
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         R
/////////////////////////////////////////////////////
public class R_Character extends TextCharacter {
  
  public R_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    column_0.getPixelSets()[2].getPixels()[3] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];    
    column_1.getPixelSets()[0].getPixels()[1] = true;
    column_1.getPixelSets()[0].getPixels()[2] = true;
        
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
        
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         S
/////////////////////////////////////////////////////
public class S_Character extends TextCharacter {
  
  public S_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         T
/////////////////////////////////////////////////////
public class T_Character extends TextCharacter {
  
  public T_Character() {
    initColumns(3);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[1] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
    
    // COLUMN 1
    PixelSetColumn column_2 = getColumns()[2];
    
    column_2.getPixelSets()[2].getPixels()[3] = true;

  }
  
}


/////////////////////////////////////////////////////
//                         U
/////////////////////////////////////////////////////
public class U_Character extends TextCharacter {
  
  public U_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         V
/////////////////////////////////////////////////////
public class V_Character extends TextCharacter {
  
  public V_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[3] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[1] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         W
/////////////////////////////////////////////////////
public class W_Character extends TextCharacter {
  
  public W_Character() {
    initColumns(3);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[3] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[1] = true;
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    
    // COLUMN 2
    PixelSetColumn column_2 = getColumns()[1];
    column_2.getPixelSets()[0].getPixels()[2] = true;
    column_2.getPixelSets()[0].getPixels()[3] = true;
    
    column_2.getPixelSets()[1].getPixels()[0] = true;
    column_2.getPixelSets()[1].getPixels()[2] = true;
    
    column_2.getPixelSets()[2].getPixels()[0] = true;
    column_2.getPixelSets()[2].getPixels()[1] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         X
/////////////////////////////////////////////////////
public class X_Character extends TextCharacter {
  
  public X_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
    column_0.getPixelSets()[0].getPixels()[3] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[3] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[1] = true;
    column_1.getPixelSets()[0].getPixels()[2] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[1] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         Y
/////////////////////////////////////////////////////
public class Y_Character extends TextCharacter {
  
  public Y_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[3] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[1] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         Z
/////////////////////////////////////////////////////
public class Z_Character extends TextCharacter {
  
  public Z_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[3] = true;
    
    column_0.getPixelSets()[2].getPixels()[1] = true;
    column_0.getPixelSets()[2].getPixels()[3] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[1] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[1] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         SPACE
/////////////////////////////////////////////////////
public class SPACE_Character extends TextCharacter {
  
  public SPACE_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // Do nothing
  }
  
}


/////////////////////////////////////////////////////
//                         !
/////////////////////////////////////////////////////
public class Exclamation_Character extends TextCharacter {
  
  public Exclamation_Character() {
    initColumns(1);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
    
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         ,
/////////////////////////////////////////////////////
public class Comma_Character extends TextCharacter {
  
  public Comma_Character() {
    initColumns(1);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
    column_0.getPixelSets()[0].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         .
/////////////////////////////////////////////////////
public class Period_Character extends TextCharacter {
  
  public Period_Character() {
    initColumns(1);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         @
/////////////////////////////////////////////////////
public class At_Character extends TextCharacter {
  
  public At_Character() {
    initColumns(3);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[1] = true;
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[1] = true;
    column_1.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 2
    PixelSetColumn column_2 = getColumns()[2];
    column_2.getPixelSets()[0].getPixels()[2] = true;
    column_2.getPixelSets()[0].getPixels()[3] = true;
    column_2.getPixelSets()[1].getPixels()[0] = true;
    column_2.getPixelSets()[1].getPixels()[2] = true;
    column_2.getPixelSets()[1].getPixels()[3] = true;
    column_2.getPixelSets()[2].getPixels()[0] = true;
    column_2.getPixelSets()[2].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         ?
/////////////////////////////////////////////////////
public class QuestionMark_Character extends TextCharacter {
  
  public QuestionMark_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         $
/////////////////////////////////////////////////////
public class Dollar_Character extends TextCharacter {
  
  public Dollar_Character() {
    initColumns(3);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[0] = true;
    column_1.getPixelSets()[0].getPixels()[1] = true;
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[1] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[1] = true;
    column_1.getPixelSets()[2].getPixels()[2] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
    
    // COLUMN 2
    PixelSetColumn column_2 = getColumns()[2];
    column_2.getPixelSets()[0].getPixels()[2] = true;
    column_2.getPixelSets()[0].getPixels()[3] = true;
    column_2.getPixelSets()[1].getPixels()[0] = true;
    column_2.getPixelSets()[1].getPixels()[3] = true;
    column_2.getPixelSets()[2].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         %
/////////////////////////////////////////////////////
public class Percent_Character extends TextCharacter {
  
  public Percent_Character() {
    initColumns(3);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[0] = true;
    column_1.getPixelSets()[0].getPixels()[1] = true;
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[1] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[2] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
    
    // COLUMN 2
    PixelSetColumn column_2 = getColumns()[2];
    column_2.getPixelSets()[0].getPixels()[2] = true;
    column_2.getPixelSets()[0].getPixels()[3] = true;
    column_2.getPixelSets()[1].getPixels()[0] = true;
    column_2.getPixelSets()[1].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         &
/////////////////////////////////////////////////////
public class Ampersand_Character extends TextCharacter {
  
  public Ampersand_Character() {
    initColumns(3);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[1] = true;
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[1] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
    // COLUMN 2
    PixelSetColumn column_2 = getColumns()[2];
    column_2.getPixelSets()[0].getPixels()[2] = true;
    column_2.getPixelSets()[0].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         ;
/////////////////////////////////////////////////////
public class Semicolon_Character extends TextCharacter {
  
  public Semicolon_Character() {
    initColumns(1);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
    column_0.getPixelSets()[0].getPixels()[3] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         :
/////////////////////////////////////////////////////
public class Colon_Character extends TextCharacter {
  
  public Colon_Character() {
    initColumns(1);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         [, {, <
/////////////////////////////////////////////////////
public class OpeningBracket_Character extends TextCharacter {
  
  public OpeningBracket_Character() {
    initColumns(1);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         ], }, >
/////////////////////////////////////////////////////
public class ClosingBracket_Character extends TextCharacter {
  
  public ClosingBracket_Character() {
    initColumns(1);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[2] = true;
    column_0.getPixelSets()[0].getPixels()[3] = true;
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         -
/////////////////////////////////////////////////////
public class Dash_Character extends TextCharacter {
  
  public Dash_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[1].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[1].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         =
/////////////////////////////////////////////////////
public class Equals_Character extends TextCharacter {
  
  public Equals_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[3] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         "
/////////////////////////////////////////////////////
public class DoubleQuotes_Character extends TextCharacter {
  
  public DoubleQuotes_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[1].getPixels()[2] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[2].getPixels()[0] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         '
/////////////////////////////////////////////////////
public class SingleQuotes_Character extends TextCharacter {
  
  public SingleQuotes_Character() {
    initColumns(1);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[1].getPixels()[2] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         1
/////////////////////////////////////////////////////
public class One_Character extends TextCharacter {
  
  public One_Character() {
    initColumns(1);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    column_0.getPixelSets()[0].getPixels()[3] = true;
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         2
/////////////////////////////////////////////////////
public class Two_Character extends TextCharacter {
  
  public Two_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[3] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}


/////////////////////////////////////////////////////
//                         3
/////////////////////////////////////////////////////
public class Three_Character extends TextCharacter {
  
  public Three_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         4
/////////////////////////////////////////////////////
public class Four_Character extends TextCharacter {
  
  public Four_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    column_1.getPixelSets()[2].getPixels()[0] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         5
/////////////////////////////////////////////////////
public class Five_Character extends TextCharacter {
  
  public Five_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         6
/////////////////////////////////////////////////////
public class Six_Character extends TextCharacter {
  
  public Six_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         7
/////////////////////////////////////////////////////
public class Seven_Character extends TextCharacter {
  
  public Seven_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         8
/////////////////////////////////////////////////////
public class Eight_Character extends TextCharacter {
  
  public Eight_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         9
/////////////////////////////////////////////////////
public class Nine_Character extends TextCharacter {
  
  public Nine_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}

/////////////////////////////////////////////////////
//                         0
/////////////////////////////////////////////////////
public class Zero_Character extends TextCharacter {
  
  public Zero_Character() {
    initColumns(2);
    initPixels();
  }
 
  protected void initPixels() {
    // COLUMN 0
    PixelSetColumn column_0 = getColumns()[0];
    column_0.getPixelSets()[0].getPixels()[1] = true;
    column_0.getPixelSets()[0].getPixels()[2] = true;
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    column_0.getPixelSets()[2].getPixels()[0] = true;
    column_0.getPixelSets()[2].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[2].getPixels()[0] = true;
    column_1.getPixelSets()[2].getPixels()[3] = true;
  }
  
}