public class ParticpativeTextRoller extends TextRoller {
  
  private ArrayList<Entry> entriesList = new ArrayList<Entry>();
  private int counter = 0;
  color bgColor,textColor;
  
  public ParticpativeTextRoller(ArrayList<Entry> entriesList){
    // Create text roller
    super();
    super.setText("HIHIHIHI");
    this.entriesList = entriesList;
  }
  
  public void nextEntry() {
    if(counter<entriesList.size()-1){
      counter++;
    }else {
      counter=0;
    }
    
    println(counter+" "+entriesList.size());

    if ((entriesList != null) && !entriesList.isEmpty()) {
      super.setText(entriesList.get(counter).message);
      bgColor = entriesList.get(counter).bgcolor;
      textColor = entriesList.get(counter).textcolor;
    }
  }
  
  
}