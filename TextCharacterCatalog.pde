public class TextCharacterCatalog {
  private HashMap charactersMap;
  
  public TextCharacterCatalog() {
    init();
  }
  
  private void init() {
    charactersMap = new HashMap<String, TextCharacter>();
    
    // TODO
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
  }
  
  public TextCharacter get(String c) {
    return (TextCharacter)charactersMap.get(c);
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
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    column_0.getPixelSets()[1].getPixels()[2] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
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
    
    column_0.getPixelSets()[1].getPixels()[0] = true;
    column_0.getPixelSets()[1].getPixels()[1] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[2] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
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
    column_0.getPixelSets()[1].getPixels()[1] = true;
        
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[1] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
    
    // COLUMN 2
    PixelSetColumn column_2 = getColumns()[2];
    column_2.getPixelSets()[0].getPixels()[2] = true;
    
    column_2.getPixelSets()[1].getPixels()[0] = true;
    column_2.getPixelSets()[1].getPixels()[3] = true;
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
    column_0.getPixelSets()[1].getPixels()[1] = true;
        
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[3] = true;
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
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    
    column_1.getPixelSets()[1].getPixels()[3] = true;
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
    column_0.getPixelSets()[1].getPixels()[3] = true;
    
    column_0.getPixelSets()[2].getPixels()[0] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[3] = true;
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
    column_0.getPixelSets()[1].getPixels()[3] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    column_1.getPixelSets()[1].getPixels()[1] = true;
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
    column_0.getPixelSets()[1].getPixels()[3] = true;
    
    // COLUMN 1
    PixelSetColumn column_1 = getColumns()[1];
    column_1.getPixelSets()[0].getPixels()[1] = true;
    column_1.getPixelSets()[0].getPixels()[2] = true;
    column_1.getPixelSets()[0].getPixels()[3] = true;
    
    column_1.getPixelSets()[1].getPixels()[0] = true;
    
    // COLUMN 2
    PixelSetColumn column_2 = getColumns()[1];
    column_2.getPixelSets()[0].getPixels()[2] = true;
    column_2.getPixelSets()[0].getPixels()[3] = true;
    
    column_2.getPixelSets()[1].getPixels()[0] = true;
    column_2.getPixelSets()[1].getPixels()[1] = true;
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