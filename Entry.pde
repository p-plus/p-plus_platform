public class Entry{
  
  public String firstName;
  public String twitterName;
  public String weiboName;
  public String email;
  public String message;
  public char screenChoice;
  public color bgcolor;
  public color textColor;
            
  public Entry(TableRow row){
    
    firstName = row.getString(0);
    twitterName = row.getString(1);
    weiboName = row.getString(2);
    email = row.getString(3);
    message = row.getString(4);
    screenChoice = row.getString(5).charAt(0);
    bgcolor = unhex(row.getString(6).replace("#", ""));
    textColor = unhex(row.getString(7).replace("#", ""));
    
    //println(firstName+" "+twitterName+" "+weiboName+" "+email+" "+message+" "+screenChoice+" "+bgcolor+" "+textColor);
    
  }
  
  
  
}