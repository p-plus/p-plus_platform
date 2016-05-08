public class ParticipativeTextRoller extends TextRoller implements Cloneable {
  
  private ArrayList<Entry> entriesList = new ArrayList<Entry>();
  public int currentEntryNumber = 0;
  //public int previousEntryNumber = 0;
  public int nextEntryNumber = 0;
  public FACET facet;

  //color bgColor,textColor;
  
  public ParticipativeTextRoller(ArrayList<Entry> entriesList){
    // Create text roller
    super();
    this.entriesList = entriesList;
       
    //randomEntry();
  }
  
  public ParticipativeTextRoller(FACET facet, int startNumber){
    // Create text roller
    super();
    if(facet == FACET.NORTH){
        super.SCREEN_WIDTH = envXMaxUnits;
    }else if(facet == FACET.SOUTH){
        super.SCREEN_WIDTH = envXMaxUnits;
    }else if(facet == FACET.EAST){
        super.SCREEN_WIDTH = envYMaxUnits;
    }else if(facet == FACET.WEST){
        super.SCREEN_WIDTH = envYMaxUnits;
    }
    EntriesImporter imp = new EntriesImporter();
    this.entriesList = imp.loadEntriesFile();
    this.entriesList = (ArrayList<Entry>) entriesList.clone();
    this.facet = facet; 
    
        println("new");

    //println("EntriesList before: "+entriesList.size());
    
    Iterator<Entry> iter = entriesList.iterator();

    while(iter.hasNext()) {
      Entry entry = iter.next();
     
      if(entry.screenChoice != facet){
        iter.remove(); 
      }
      
    }
    
    currentEntryNumber = startNumber;
    nextEntryNumber = startNumber;
    
    if ((entriesList != null) && !entriesList.isEmpty()) {
      super.setText(entriesList.get(currentEntryNumber).message);
    }
    
    
    
    //println("EntriesList after: "+entriesList.size());
    
       
    //randomEntry();
  }
  
  public void prepareNextEntry(){
    if(nextEntryNumber<entriesList.size()+1){
      nextEntryNumber++;
    }else{
      nextEntryNumber=0;
    }

  }
  
  public void nextEntry() {
    
    //previousEntryNumber = currentEntryNumber;
    //if(currentEntryNumber<entriesList.size()+1){
    //  currentEntryNumber++;
    //}else {
    //  currentEntryNumber=0;
    //}
    //nextEntryNumber = currentEntryNumber;
    currentEntryNumber = nextEntryNumber;

    if ((entriesList != null) && !entriesList.isEmpty()) {
      super.setText(entriesList.get(currentEntryNumber).message);
    }
  }
  
  public void prepareRandomEntry(){
    do{
      nextEntryNumber = (int)random(0, entriesList.size()-1);
    }while(nextEntryNumber == currentEntryNumber);
  }
  
  /*public void randomEntry() {
    previousEntryNumber = currentEntryNumber;
    do{
      currentEntryNumber = (int)random(0, entriesList.size()-1);
    }while(currentEntryNumber==previousEntryNumber);

    if ((entriesList != null) && !entriesList.isEmpty()) {
      super.setText(entriesList.get(currentEntryNumber).message);
      //bgColor = entriesList.get(currentEntryNumber).bgcolor;
      //textColor = entriesList.get(currentEntryNumber).textcolor;
    }
  }*/
  
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
  
  public Entry getNextEntry(){
    if(nextEntryNumber<entriesList.size()){
      return entriesList.get(nextEntryNumber);
    }else{
      return entriesList.get(0);
    }
  }
  
  public Entry getLastEntry(){
   return entriesList.get(entriesList.size()-1); 
  }
  
  public Entry getFirstEntry(){
   return entriesList.get(0); 
  }
  
  public String getMessage(){
    return super.t;
  }
  
  @Override
  protected Object clone() throws CloneNotSupportedException {
      return super.clone();
  }
  
}