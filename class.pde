class season { //CREATES A CLASS NAMED SEASON
  int pos; //attributes
  String year;
  int ep_num;
  float viewers;
  float mwe_viewers;
  String title;
  
  float ellipse_x; //global variables
  float ellipse_y;
  float ellipse_y2;
  int diam=25;
  int diam2=25;
  int button_x = 750;
  int button_y = 120;
  int button_colour = #BC0202;
  int limit = 25;
  int col2;
  String button_status = "OFF";


  season(int p, String y, int e, float v, float mv, String t){ //constructor
    pos = p;
    year = y;
    ep_num = e;
    viewers = v;
    mwe_viewers = mv;
    title = t;
  ellipse_x = 70+pos*25;
  ellipse_y = (630-(mwe_viewers*17));
  ellipse_y2 = (630-(viewers*17));
  }
  //class methods
  void display(){   
    fill(button_colour);  
    ellipse(button_x, button_y, 70,70);  
    fill(0);
    text(button_status,button_x-10,button_y+2);
    
    float[] values = { mwe_viewers,viewers }; // creates a list of all the viewers, average viewers and most watched episode viewers
    line(50,height-70-(max(values)*17), 50,630);//creates a line from Y coordinate 630 to a y-coordinate that's relative to the highest
    //viewer value. The realative scale used to match the y-axis to the highest viewer is the same as the scaled used to get the y position of the data 
    
    pushMatrix(); // saves the current coordinate system to the matrix stack 
    fill(0);
    translate(ellipse_x, 630); //sets the x and y coordinates of the text to be translated
    rotate(radians(90)); //rotates the text 90 radians around
    text(year,0, 0);
    popMatrix();//restores the prior coordinate system
      
      
    boolean flag = check();
    if(flag==true){  //highlights the season on the graph if the user is hovering over the data
      strokeWeight(40);
      stroke(#A4E8E3,180);
      line(ellipse_x, 20, ellipse_x, 610);
      reset();      
    }
    
    create_ellipse(viewers,#C12336); //calls the create ellipse function for viewers
    create_ellipse(mwe_viewers,#9021AA);//calls the create elliupse function for most watched episode viewers
    
  }

  void create_ellipse(float v,int col){ 
    fill(col,180); // makes the ellipses slightly transparent
    strokeWeight(0.4);
    if(button_colour == #BC0202){
      col2=col;
    }
    if(diam2<limit){ //enlarges the data that corresponds to treehouse of horror episodes
      diam2++;
      col2=#0AFA08; //sets the colour of the treehouse of horror data to green when the button is turned on
    }
    if((title.substring(0,10)).equals("\"Treehouse")){ // checks for treehouse of horror episodes and gives them different diameter and colour variables so these can be edited
      fill(col2,180);
      ellipse(ellipse_x,630-(v*17),diam2,diam2);
    }
    else{
      ellipse(ellipse_x,630-(v*17),diam,diam);
    }  
  }
  
  void reset(){ // function to reset the stroke settings back to normal
    stroke(0);
    strokeWeight(0.4);
  }
   
  boolean check(){ //a function that returns a true or false flag depending on whether or not the users cursor is on the ellipses
    float d = dist(mouseX,mouseY,ellipse_x,ellipse_y); // checks for the distance between the current mouse coordinates and the ellipse
    float d2 = dist(mouseX,mouseY,ellipse_x,ellipse_y2);
    if(d < diam/2 || d2<diam/2){ //if the distance is within the radius of the ellipse(radius is diameter/2)
      return true;
    }
    else{
      return false;
    }
  }
   
  void clicked(){ //function called when the users mouse is clicked 
    noLoop(); //stops the loop within the draw function so that the background isn't displayed over what is drawn whilst the mouse is clicked
    boolean flag = check();
    if (flag==true){ //if the user clicked on an ellipse:
      strokeWeight(2);
      fill(0);
      textSize(15);
      if(dist(mouseX,mouseY,ellipse_x,ellipse_y)<(diam)/2){ //draws lines from the ellipse to the y-axis and displays the viewer amount
        line(ellipse_x,ellipse_y,50,ellipse_y );
        text(nf(mwe_viewers,0,1),20,ellipse_y); //nf rounds the float to 1 decimal place
      }
      else{
        line(ellipse_x, ellipse_y2,50,ellipse_y2);
        text(nf(viewers,0,1),20,ellipse_y2);
      }
      reset();
      fill(255);
      rect(850,30, 325, 150);
      fill(0);
      textSize(18); // displays the information of the season clicked on within a text box
      text("season" +(pos+1) + " : " + year,860, 60);
      text("number of episodes: " + ep_num,860, 90);
      text("most watched episode title: \n" + title,860, 120);   
    }
  }
   
   
  void button(){
    if(dist(mouseX,mouseY,button_x,button_y)<35){ //if the treehouse of horror button is clicked
      if(button_colour == #BC0202){ //if the button is red,enlarges the treehouse of horror data to diameter 50 and sets the button colour to green
        button_colour = #0AFA08;
        limit = 50;
        col2 = #0AFA08;
        button_status = "ON";
      }
      else{ //resets the original display if the button is clicked on when green
        limit=25;
        diam2=25;
        button_colour= #BC0202;
        button_status = "OFF";
      }   
    }
  }
  
}//end of class
