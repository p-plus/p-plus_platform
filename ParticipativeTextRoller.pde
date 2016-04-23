public class ParticipativeTextRoller extends TextRoller {
  
  private ArrayList<Entry> entriesList = new ArrayList<Entry>();
  private int currentEntryNumber = 0;
  private int previousEntryNumber = 0;
  //color bgColor,textColor;
  
  public ParticipativeTextRoller(ArrayList<Entry> entriesList){
    // Create text roller
    super();
    this.entriesList = entriesList;
    randomEntry();
  }
  
  public void nextEntry() {
    previousEntryNumber = currentEntryNumber;
    if(currentEntryNumber<entriesList.size()-1){
      currentEntryNumber++;
    }else {
      currentEntryNumber=0;
    }

    if ((entriesList != null) && !entriesList.isEmpty()) {
      super.setText(entriesList.get(currentEntryNumber).message);
      //bgColor = entriesList.get(currentEntryNumber).bgcolor;
      //textColor = entriesList.get(currentEntryNumber).textcolor;
    }
  }
  
  public void randomEntry() {
    previousEntryNumber = currentEntryNumber;
    do{
      currentEntryNumber = (int)random(0, entriesList.size()-1);
    }while(currentEntryNumber==previousEntryNumber);

    if ((entriesList != null) && !entriesList.isEmpty()) {
      super.setText(entriesList.get(currentEntryNumber).message);
      //bgColor = entriesList.get(currentEntryNumber).bgcolor;
      //textColor = entriesList.get(currentEntryNumber).textcolor;
    }
  }
  
  public void rollText(){
    super.rollText();
    
    //if(super.getLoopCounter()>=TEXT_ROLLER_LOOPS){
    //  randomEntry();
    //}
  }
  
  public boolean isPixelOn(int i, int j, PIXEL pixel) {
    return super.isPixelOn(i, j, pixel);

  }
  
  public Entry getCurrentEntry(){
    return entriesList.get(currentEntryNumber);
  }
  
  public Entry getPreviousEntry(){
    return entriesList.get(previousEntryNumber);
  }
  
}