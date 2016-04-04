public class Entry{
  
  public String firstName;
  public String twitterName;
  public String weiboName;
  public String email;
  public String message;
  public char screenChoice;
  public color bgColor;
  public color textColor;
            
  public Entry(TableRow row){
    
    firstName = row.getString(0);
    twitterName = row.getString(1);
    weiboName = row.getString(2);
    email = row.getString(3);
    message = row.getString(4);
    screenChoice = row.getString(5).charAt(0);
    bgColor = color(unhex("ff"+row.getString(6).replace("#", "")));
    textColor = color(unhex("ff"+row.getString(7).replace("#", "")));
    
    //bgcolor = color(unhex("ffff0000"));
    //bgcolor = color(255,0,0);
    //println(firstName+" "+twitterName+" "+weiboName+" "+email+" "+message+" "+screenChoice+" "+bgcolor+" "+textColor);
    
  }
  
  
  
}