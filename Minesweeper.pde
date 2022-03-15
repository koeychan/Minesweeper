import de.bezier.guido.*;
public final static int NUM_ROWS =30;
public final static int NUM_COLS = 30;
public final static int NUM_MINES = 100;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines;
public int buttonsClicked =0;//ArrayList of just the minesweeper buttons that are mined
public int nonMineClicked=0;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS] [NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
     for(int c = 0; c < NUM_COLS; c++)
    
      buttons[r][c] = new MSButton(r,c);
    }
    mines = new ArrayList <MSButton>();
    setMines();
}
public void setMines()
{
   
    while(mines.size()< NUM_MINES){
     int r = (int)(Math.random() * NUM_ROWS);
    int c = (int)(Math.random() * NUM_COLS);
    if(!mines.contains(buttons[r][c])){
    mines.add(buttons[r][c]);
    System.out.println(r + "," + c);
    }//your code
}
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
     for(int r=0;r<NUM_ROWS;r++)
      for(int c=0;c<NUM_COLS;c++){
       if(mines.contains(buttons[r][c])&&buttons[r][c].clicked==true)return false;
       if(nonMineClicked<(NUM_ROWS*NUM_COLS)-NUM_MINES)return false;
      }
    return true;
}
public void displayLosingMessage()
{
    buttons[11][8].setLabel("Y");
    buttons[11][9].setLabel("O");
    buttons[11][10].setLabel("U");
    buttons[11][11].setLabel(" ");
    buttons[11][12].setLabel("L");
    buttons[11][13].setLabel("O");
    buttons[11][14].setLabel("S");
    buttons[11][15].setLabel("E");
    buttons[11][15].setLabel("!");//your code here
}
public void displayWinningMessage()
{
   buttons[11][8].setLabel("Y");
    buttons[11][9].setLabel("O");
    buttons[11][10].setLabel("U");
    buttons[11][11].setLabel(" ");
    buttons[11][12].setLabel("W");
    buttons[11][13].setLabel("I");
    buttons[11][14].setLabel("N");
    buttons[11][15].setLabel(":)");
}//your code here

public boolean isValid(int r, int c)
{
    if(r >= 0 && r < NUM_ROWS && c >=0 && c <NUM_COLS)
    return true;
    else//your code here
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for(int x = row-1; x <=row+1; x++)
    for (int y = col-1; y <= col+1; y++)
    if(isValid(x,y) == true && mines.contains(buttons[x][y])) 
    numMines++;
    if(isValid(row,col) && mines.contains(buttons[row][col]))
       numMines--;//your code here
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
         width = 500/NUM_COLS;
         height = 500/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
         if(!mines.contains(this))nonMineClicked++;
        if(mouseButton == RIGHT){
          flagged = !flagged;
          if(flagged == false)
          clicked = false;
        }else if (mines.contains(this)){
        displayLosingMessage();
        }
        
        else if (countMines(this.myRow,this.myCol) > 0){
        this.setLabel(Integer.toString(countMines(this.myRow,this.myCol)));
       
        }else{
       for(int r = this.myRow -1; r <= this.myRow+1; r++)
       for (int c = this.myCol -1; c <= this.myCol +1; c++)
          if(isValid(r,c) == true && buttons[r][c].clicked == false){
          buttons[r][c].mousePressed();//your code here
         
          }
        
    }
    
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
           fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
