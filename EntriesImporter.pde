public class EntriesImporter{
  private final String FILE_FOLDER = "entriesFiles/";
  
  public EntriesImporter(){
    
  }
  
  public ArrayList<Entry> loadEntriesFile() {
    
      ArrayList<Entry> entriesList = new ArrayList<Entry>();
      File dir = new File(dataPath("../"+FILE_FOLDER));
      File[] files = dir.listFiles();
      
      for (int i = 0; i < files.length; i++) {
        //println(files[i]);
        if(files[i].toString().contains(".csv")){
          Table table = loadTable(files[i].toString());
        
          for(int j=1; j<table.getRowCount(); j++){
            //for (TableRow row : table.rows()) {
            //String firstName = row.getString("FirstName");
            TableRow row = table.getRow(j);           
            entriesList.add(new Entry(row));
          }
        }
      }
     return entriesList;
  }

}