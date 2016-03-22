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
    println(counter+" "+entriesList.size());
    if(counter<=entriesList.size()-1){
      counter++;
    }else {
      counter=0;
    }
    if ((entriesList != null) && !entriesList.isEmpty()) {
      super.setText(entriesList.get(14).message);
      bgColor = entriesList.get(counter).bgcolor;
      textColor = entriesList.get(counter).textcolor;
    }
  }
  
  
}