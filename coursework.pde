Table table;
season[] seasonarray;
PFont font;

void setup(){
  size(1200,700); 
  textSize(12);
  table=loadTable("Simpsons.csv","header");//imports the simpsons dataset csv file
  seasonarray = new season[table.getRowCount()]; //creates an object array of type season(class name)
  for (int i=0;i<table.getRowCount();i++){//creates a new object in the array for every row in the dataset
    seasonarray[i] = new season(i,table.getString(i,0), table.getInt(i,1), table.getFloat(i,2), table.getFloat(i,3), table.getString(i,4));
  }
  font = loadFont("segoe.vlw"); //sets Segoe-UI-Light as the program's main font
  textFont(font);
}

void draw(){
  set_display();
  for(int i=0; i<table.getRowCount();i++){
    seasonarray[i].display(); //calls the display method in the season class for each object in the season array 
  }
}

void set_display(){
  background(90);
  PImage img; //imports and displays the image of homer
  img=loadImage("HOMER.png");
  img.resize(270,0);
  image(img,890,320);
  
  fill(255); //creates the thought bubble ellipses from homers head
  ellipse(1000, 315,20,20);
  ellipse(980,275,35,35);
  ellipse(960,220,50,50);
  
  pushMatrix();
  fill(0);
  translate(15,400);
  rotate(radians(-90));
  text("viewers in millions(m)", 0,0);
  popMatrix();
  text("season year",450,695);
  
  textSize(20);
  text("Treehouse of horror: ",660,60);
  
  fill(#FADF44);
  PFont simpsons_font;
  simpsons_font = createFont("akbar.ttf", 80); //imports the simpsons font(akbar) that was downloaded to write the title(simpsons) in
  textFont(simpsons_font);
  text("The Simpsons", 170, 80);
  textFont(font); //sets the font back to usual
  
  
  fill(#C12336); //displays the key for the data
  ellipse(900,50,25,25);
  fill(#9021AA);
  ellipse(900,100,25,25);
  fill(0);
  text("= average viewers(m)",930,55);
  text("= most watched episode viewers(m)",930,105);
  text("Tip: click on a circle to see more information",870,140);
}

void mousePressed(){
  for(int i = 0; i<table.getRowCount();i++){
    seasonarray[i].clicked(); //the clicked and button functions in the class are called
    seasonarray[i].button();
  }
}

void mouseReleased(){
  strokeWeight(0.4); //resets defaults when the user stops clicking their mouse
  loop();//turns the loop back on within the draw function so that what is drawn during the mousepress disappears
  stroke(0,255);
  textSize(14);
}
