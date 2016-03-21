public class ParticpativeTextRoller extends TextRoller {
  
  private ArrayList<Entry> entriesList = new ArrayList<Entry>();
  int counter = 0;
  color bgColor,textColor;
  
  public ParticpativeTextRoller(ArrayList<Entry> entriesList){
    // Create text roller
    super();
    super.setText("HIHIHIHI");
    this.entriesList = entriesList;
  }
  
  public void nextEntry() {
    if ((entriesList != null) && !entriesList.isEmpty()) {
      super.setText(entriesList.get(counter).message);
      bgColor = entriesList.get(counter).bgcolor;
      textColor = entriesList.get(counter).textcolor;
    }
    if(counter<entriesList.size()){
      counter++;
    }else {
      counter=0;
    }
  }
  
  
}