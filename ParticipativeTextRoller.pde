public class ParticipativeTextRoller extends TextRoller {
  
  private ArrayList<Entry> entriesList = new ArrayList<Entry>();
  private int counter = 0;
  color bgColor,textColor;
  
  public ParticipativeTextRoller(ArrayList<Entry> entriesList){
    // Create text roller
    super();
    super.setText("HIHIHIHI");
    this.entriesList = entriesList;
    randomEntry();
  }
  
  public void nextEntry() {
    if(counter<entriesList.size()-1){
      counter++;
    }else {
      counter=0;
    }

    if ((entriesList != null) && !entriesList.isEmpty()) {
      super.setText(entriesList.get(counter).message);
      bgColor = entriesList.get(counter).bgcolor;
      textColor = entriesList.get(counter).textcolor;
    }
  }
  
  public void randomEntry() {
    int counter = (int)random(0, entriesList.size()-1);

    if ((entriesList != null) && !entriesList.isEmpty()) {
      super.setText(entriesList.get(counter).message);
      bgColor = entriesList.get(counter).bgcolor;
      textColor = entriesList.get(counter).textcolor;
    }
  }
  
  public void rollText(){
    super.rollText();
    
    if(super.getLoopCounter()>=TEXT_ROLLER_LOOPS){
      randomEntry();
    }
    
  }
  
  
}