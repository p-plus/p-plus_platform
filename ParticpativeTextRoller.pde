public class ParticpativeTextRoller extends TextRoller {
  
  private ArrayList<Entry> entriesList = new ArrayList<Entry>();
  int counter = 0;
  
  public ParticpativeTextRoller(ArrayList<Entry> entriesList){
    // Create text roller
    super();
    super.setText("HIHIHIHI");
    this.entriesList = entriesList;
  }
  
  public void nextText() {
    if ((entriesList != null) && !entriesList.isEmpty()) {
      super.setText(entriesList.get(0).message);
    }
  }
  
  
}