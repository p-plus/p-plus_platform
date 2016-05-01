import java.util.*;
import java.io.*;

public class Entry implements Comparable<Entry>{
  
  public String firstName;
  public String twitterName;
  public String weiboName;
  public String email;
  public String message;
  public FACET screenChoice;
  public color bgColor;
  public color textColor;
  public int timeStamp;
            
  public Entry(TableRow row){
    
    firstName = row.getString(0);
    twitterName = row.getString(1);
    weiboName = row.getString(2);
    email = row.getString(3);
    message = row.getString(4);    
    if(row.getString(5).charAt(0) == 'N'){
      screenChoice = FACET.NORTH;    
    }else if(row.getString(5).charAt(0) == 'E'){
      screenChoice = FACET.EAST;    
    }else if(row.getString(5).charAt(0) == 'S'){
      screenChoice = FACET.SOUTH;    
    }else if(row.getString(5).charAt(0) == 'W'){
      screenChoice = FACET.WEST;    
    }else{
      screenChoice = FACET.NORTH;
    }
    
    bgColor = color(unhex("ff"+row.getString(6).replace("#", "")));
    textColor = color(unhex("ff"+row.getString(7).replace("#", "")));
    timeStamp = Integer.parseInt(row.getString(8));
    
    //bgcolor = color(unhex("ffff0000"));
    //bgcolor = color(255,0,0);
    //println(firstName+" "+twitterName+" "+weiboName+" "+email+" "+message+" "+screenChoice+" "+bgcolor+" "+textColor);
    
  }
  
  @Override
  public int compareTo(Entry entry) {
    //write code here for compare name
    int compareTimestamp = ((Entry) entry).timeStamp; 
    
    //ascending order
    return this.timeStamp - compareTimestamp;
  }
    
}