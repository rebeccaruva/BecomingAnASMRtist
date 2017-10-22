import processing.video.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

PFont titleFont;
PFont infoFont;
PFont recordFont;
PImage stroke;
PImage play;
PImage play0;
Movie intro1;
Movie intro2;
Movie intro3;
Movie intro4;
Movie outro1;
Movie outro2;
Movie outro3;
Movie outro4;
Movie hand;
Movie tap;
Movie page;
Movie type;
Movie asmr;
Capture user;
int screenSelector;
int randomPlayerNum;
String[] intro = { "Hello everyone, it's me. Crystal Clear ASMR.", "Hi. I'm Soft ASMR. How was your day? I hope it was well.", "Hey there. It's Triple ASMR. Aesthetic. Abstract. ASMR.", "Heyo, it's Radical ASMR and I'm here to help you tingle.", "Dreamy ASMR here. It's time for another video." };
String[] outro = { "Thank you so much for watching. I hope you have a crystal clear day.", "I hope you enjoyed the video. Have a fabulous day.", "Thank you for watching. Triple ASMR out.", "I hope you tingled. Have a wonderful day... or night.", "Dreamy ASMR has to go now, but I hope you have a wonderful time today. Much love." };
String[] visual = { "Hand Movements", "Tapping", "Page Turning", "Typing" };
String[] whisper = { "hello, hello, hello, hello", "ska, ska, ska, ska", "cha, cha, cha, cha", "rad, rad, rad, rad, radical", "shhh, shhh, shhh, shhh" };
float red;
float green;
float blue;
color titleColor;
Minim minim;
AudioInput in;
AudioRecorder finalRecorder;
AudioPlayer sound1;
AudioPlayer sound2;
AudioPlayer sound3;
AudioPlayer sound4;
AudioPlayer sound5;

void setup() {
  //size(1000, 1000);
  fullScreen();
  background(0);
  frameRate(60);
  
  screenSelector = 0; //set screen to 0 at setup
  randomPlayerNum = int(random(5)); //random number for array to find ASMR persona
  
  //load fonts, images, etc..
  titleFont = createFont("LeviReBrushed.ttf", 350);
  infoFont = createFont("GOTHIC.TTF", 150);
  recordFont = createFont("GOTHIC.TTF", 75);
  stroke = loadImage("brushStroke.png");
  play = loadImage("play.png");
  play0 = loadImage("play0.png");
  intro1 = new Movie(this, "intro1.mp4");
  intro1.loop();
  intro1.volume(0);
  intro2 = new Movie(this, "intro2.mp4");
  intro2.loop();
  intro2.volume(0);
  intro3 = new Movie(this, "intro3.mp4");
  intro3.loop();
  intro3.volume(0);
  intro4 = new Movie(this, "intro4.mp4");
  intro4.loop();
  intro4.volume(0);
  outro1 = new Movie(this, "outro1.mp4");
  outro1.loop();
  outro1.volume(0);
  outro2 = new Movie(this, "outro2.mp4");
  outro2.loop();
  outro2.volume(0);
  outro3 = new Movie(this, "outro3.mp4");
  outro3.loop();
  outro3.volume(0);
  outro4 = new Movie(this, "outro4.mp4");
  outro4.loop();
  outro4.volume(0);
  asmr = new Movie(this, "asmr.mp4");
  //asmr.loop();
  //asmr.volume(0);
  hand  = new Movie(this, "hands.mp4");
  hand.loop();
  hand.volume(0);
  tap  = new Movie(this, "tapping.mp4");
  tap.loop();
  tap.volume(0);
  page  = new Movie(this, "pageTurn.mp4");
  page.loop();
  page.volume(0);
  type  = new Movie(this, "typing.mp4");
  type.loop();
  type.volume(0);
  
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an element from the array returned by list():
      user = new Capture(this, cameras[0]);
    user.start();     
  }
  
  minim = new Minim(this);
  in = minim.getLineIn();
  finalRecorder = minim.createRecorder(in, "introrecording.wav"); //record the intro
  sound1 = minim.loadFile("sound1.wav");
  sound2 = minim.loadFile("sound2.wav");
  sound3 = minim.loadFile("sound3.wav");
  sound4 = minim.loadFile("sound4.wav");
  sound5 = minim.loadFile("sound5.wav");
}

void draw() {
  //title
  textFont(titleFont);
  //generatePastelColor();
  textAlign(CENTER);
  text("Becoming an", width/2, height/2-400);
  text("ASMRtist", width/2, height/2+75);
  
  //begin button
  if((mouseX > width/2-300) && (mouseY > height-450) && (mouseX < width/2+300) && (mouseY < height-150) && (screenSelector == 0)) {
    tint(100, 209, 239);
    image(stroke, width/2-300, height-450, 600, 300);
    textFont(infoFont);
    textAlign(CENTER);
    fill(255);
    text("Begin", width/2, height-250);
    
    //if mouse is pressed, go to next page
    mouseReleased();
  } else {
    noTint();
    image(stroke, width/2-300, height-450, 600, 300);
    textFont(infoFont);
    textAlign(CENTER);
    fill(255);
    text("Begin", width/2, height-250);
  }
  
  if (screenSelector == 1) {
    instructionScreen();
  } else if (screenSelector == 2) {
    introScreen();
  } else if (screenSelector == 3) {
    visualScreen();
  } else if (screenSelector == 4) {
    contentScreen();
  } else if (screenSelector == 8) {
    outroScreen();
  } else if (screenSelector == 9) {
    videoScreen();
  } else if (screenSelector == 10) {
    scoreScreen();
  }
}

void instructionScreen() {
  background(255);
  
  textFont(titleFont);
  generateDarkPastelColor();
  textAlign(LEFT);
  text("ASMR", 45, 300);
  
  textFont(infoFont);
  fill(0);
  textAlign(LEFT);
  text("                       stands for Autonomous Sensory Meridian Response. It's that little tingle you get on your skin when someone scratches your head or whispers in your ear.", 45, 180, width-90, height-500);
  text("Today you are going to become an ASMRtist. Make a video and get graded on your ASMRtistry.", 45, 1160, width-90, height-500);
  
  if((mouseX > width-1100) && (mouseY > height-350) && (mouseX < width-100) && (mouseY < height-50) && (screenSelector == 1)) {
    tint(100, 209, 239);
    image(stroke, width-1100, height-350, 1000, 300);
    textFont(infoFont);
    textAlign(RIGHT);
    fill(0);
    text("Let's ASMR", width-245, height-150);
    
    //if mouse is pressed, go to next page
    mouseReleased();
  } else {
    noTint();
    image(stroke, width-1100, height-350, 1000, 300);
    textFont(infoFont);
    textAlign(RIGHT);
    fill(0);
    text("Let's ASMR", width-245, height-150);
  }
}

void introScreen() {
  background(255);
 
  generateDarkPastelStroke();
  fill(255, 193, 218);
  rect(0, 100, width, 300); 
  
  textFont(infoFont);
  textAlign(LEFT);
  fill(0);
  text("Start with an introduction.", 45, 160, width-90, height-500);
  text("Check out these intros for inspiration.", 45, 500, width-90, height-500);
  //text("Say \"" + intro[randomPlayerNum] + "\"", 45, 500, width-90, height-500);
  
   //videos
   if (screenSelector == 2) {
  image(intro1, 500, 750, 960, 540);
  image(intro2, width-1460, 750, 960, 540);
  image(intro3, 500, 1490, 960, 540);
  image(intro4, width-1460, 1490, 960, 540);
   } else {
     intro1.volume(0);
     intro2.volume(0);
     intro3.volume(0);
     intro4.volume(0);
  
  if ((mouseX > 500) && (mouseY > 750) && (mouseX < 1460) && (mouseY < 1290) && (screenSelector == 2)) {
    fill(255, 255, 255, 75);
    rect(500, 750, 960, 540);
    textFont(infoFont);
    textAlign(CENTER);
    fill(255);
    text("El ASMR", 500, 800, 975, 540);
    intro1.volume(0.85f);
    
    mouseReleased();
  } else if ((mouseX > width-1460) && (mouseY > 750) && (mouseX < width-500) && (mouseY < 1290) && (screenSelector == 2)) {
    fill(255, 255, 255, 75);
    rect(width-1460, 750, 960, 540);
    textFont(infoFont);
    textAlign(CENTER);
    fill(255);
    text("Heather Feather ASMR", width-1460, 810, 960, 540);
    intro2.volume(0.85f);
    
    mouseReleased();
  } else if ((mouseX > 500) && (mouseY > 1490) && (mouseX < 1460) && (mouseY < 2000) && (screenSelector == 2)) {
    fill(255, 255, 255, 75);
    rect(500, 1490, 960, 540);
    textFont(infoFont);
    textAlign(CENTER);
    fill(255);
    text("ASMR Darling", 500, 1525, 900, 540);
    intro3.volume(0.85f);
    
    mouseReleased();
  } else if ((mouseX > width-1460) && (mouseY > 1490) && (mouseX < width-500) && (mouseY < 2000) && (screenSelector == 2)) {
    fill(255, 255, 255, 75);
    rect(width-1460, 1490, 960, 540);
    textFont(infoFont);
    textAlign(CENTER);
    fill(255);
    text("ASMR Blossom", width-1460, 1550, 900, 540);
    intro4.volume(0.85f);
    
    mouseReleased();
  } else {
    intro1.volume(0);
    intro2.volume(0);
    intro3.volume(0);
    intro4.volume(0);
  }
}

void visualScreen() {
  background(255);
  
  generateDarkPastelStroke();
  fill(255, 193, 218);
  rect(0, 100, width, 300); 
  
  textFont(infoFont);
  textAlign(LEFT);
  fill(0);
  text("Admire the visual ASMR.", 45, 160, width-90, height-500);
  text("What kind of video would you like to make?", 45, 500, width-90, height-500);
  
  //videos
  if (screenSelector == 3) {
  image(hand, 500, 750, 960, 540);
  image(tap, width-1460, 750, 960, 540);
  image(page, 500, 1490, 960, 540);
  image(type, width-1460, 1490, 960, 540);
  } else {
    hand.volume(0);
    tap.volume(0);
    page.volume(0);
    type.volume(0);
  }
  
  if ((mouseX > 500) && (mouseY > 750) && (mouseX < 1460) && (mouseY < 1290) && (screenSelector == 3)) {
    fill(255, 255, 255, 75);
    rect(500, 750, 960, 540);
    textFont(infoFont);
    textAlign(CENTER);
    fill(255);
    text(visual[0], 500, 775, 960, 540);
    hand.volume(0.7f);
    
    mouseReleased();
  } else if ((mouseX > width-1460) && (mouseY > 750) && (mouseX < width-500) && (mouseY < 1290) && (screenSelector == 3)) {
    fill(255, 255, 255, 75);
    rect(width-1460, 750, 960, 540);
    textFont(infoFont);
    textAlign(CENTER);
    fill(255);
    text(visual[1], width-1460, 925, 960, 540);
    tap.volume(0.7f);
    
    mouseReleased();
  } else if ((mouseX > 500) && (mouseY > 1490) && (mouseX < 1460) && (mouseY < 2000) && (screenSelector == 3)) {
    fill(255, 255, 255, 75);
    rect(500, 1490, 960, 540);
    textFont(infoFont);
    textAlign(CENTER);
    fill(255);
    text(visual[2], 500, 1665, 960, 540);
    page.volume(0.7f);
    
    mouseReleased();
  } else if ((mouseX > width-1460) && (mouseY > 1490) && (mouseX < width-500) && (mouseY < 2000) && (screenSelector == 3)) {
    fill(255, 255, 255, 75);
    rect(width-1460, 1490, 960, 540);
    textFont(infoFont);
    textAlign(CENTER);
    fill(255);
    text(visual[3], width-1460, 1665, 960, 540);
    type.volume(0.7f);
    
    mouseReleased();
  } else {
    hand.volume(0);
    tap.volume(0);
    page.volume(0);
    type.volume(0);
  }
}

void contentScreen() {
  background(255);
  
  generateDarkPastelStroke();
  fill(255, 193, 218);
  rect(0, 100, width, 300); 
  
  textFont(infoFont);
  textAlign(LEFT);
  fill(0);
  text("Hear the sounds", 45, 160, width-90, height-500);
  text("Do you get the tingles?", 45, 500, width-90, height-500);
  
  //play buttons
  textFont(recordFont);
  textAlign(LEFT);
  fill(255, 193, 218);
  
  image(play, 500, 850, 200, 200);
  text("Kinetic Sand", 700, 900);
  image(play, width-1300, 850, 200, 200);
  text("Water Cup", width-1100, 900);
  image(play, 500, 1300, 200, 200);
  text("Mermaid Pillow", 750, 1400);
  image(play, width-1300, 1300, 200, 200);
  text("Marshmallow Eating", width-1050, 1400);
  image(play, width/2-350, 1800, 200, 200);
  text("Spray Bottle", width/2-100, 1900);
  
  if ((mouseX > 500) && (mouseY > 850) && (mouseX < 700) && (mouseY < 1050) && (screenSelector == 4) && (mousePressed)) {
    if (sound1.isPlaying()) {
      sound1.pause();
    } else {
      // simply call loop again to resume playing from where it was paused
      image(play, 500, 850, 200, 200);  
      sound1.rewind();
      sound1.play();
    }
  }
  if ((mouseX > width-1300) && (mouseY > 850) && (mouseX < width-1100) && (mouseY < 1050) && (screenSelector == 4) && (mousePressed)) {
    if (sound2.isPlaying()) {
      sound2.pause();
    } else {
      // simply call loop again to resume playing from where it was paused
      image(play, width-1300, 850, 200, 200);
      sound2.rewind();
      sound2.play();
    }
  }
  if ((mouseX > 500) && (mouseY > 1300) && (mouseX < 700) && (mouseY < 1500) && (screenSelector == 4) && (mousePressed)) {
    if (sound3.isPlaying()) {
      sound3.pause();
    } else {
      // simply call loop again to resume playing from where it was paused
      image(play, 500, 1300, 200, 200); 
      sound3.rewind();
      sound3.play();
    }
  }
  if ((mouseX > width-1300) && (mouseY > 1300) && (mouseX < width-1100) && (mouseY < 1500) && (screenSelector == 4) && (mousePressed)) {
    if (sound4.isPlaying()) {
      sound4.pause();
    } else {
      // simply call loop again to resume playing from where it was paused
      image(play, width-1300, 1300, 200, 200);
      sound4.rewind();
      sound4.play();
    }
  }
  if ((mouseX > width/2-350) && (mouseY > 1800) && (mouseX < width/2-150) && (mouseY < 2000) && (screenSelector == 4) && (mousePressed)) {
    if (sound5.isPlaying()) {
      sound5.pause();
    } else {
      // simply call loop again to resume playing from where it was paused
      image(play, width/2-350, 1800, 200, 200);
      sound5.rewind();
      sound5.play();
    }
  }
  if((mouseX > width-1100) && (mouseY > height-350) && (mouseX < width-100) && (mouseY < height-50) && (screenSelector == 4)) {
    tint(100, 209, 239);
    image(stroke, width-1100, height-350, 1000, 300);
    textFont(infoFont);
    textAlign(RIGHT);
    fill(0);
    text("the ending", width-245, height-150);
    
    //if mouse is pressed, go to next page
    mouseReleased();
  } else {
    noTint();
    image(stroke, width-1100, height-350, 1000, 300);
    textFont(infoFont);
    textAlign(RIGHT);
    fill(0);
    text("the ending", width-245, height-150);
  }
  
}

void outroScreen() {
  background(255);
  
  generateDarkPastelStroke();
  fill(255, 193, 218);
  rect(0, 100, width, 300); 
  
  textFont(infoFont);
  textAlign(LEFT);
  fill(0);
  text("End with an outro.", 45, 160, width-90, height-500);
  text("Say goodbye and farewell.", 45, 500, width-90, height-500);
  
   //videos
   if (screenSelector == 8){
     image(outro1, 500, 750, 960, 540);
     image(outro2, width-1460, 750, 960, 540);
     image(outro3, 500, 1490, 960, 540);
     image(outro4, width-1460, 1490, 960, 540);
   } else {
    outro1.volume(0);
    outro2.volume(0);
    outro3.volume(0);
    outro4.volume(0);
   }
  
  if ((mouseX > 500) && (mouseY > 750) && (mouseX < 1460) && (mouseY < 1290) && (screenSelector == 8)) {
    fill(255, 255, 255, 75);
    rect(500, 750, 960, 540);
    textFont(infoFont);
    textAlign(CENTER);
    fill(255);
    text("Stay in the vortex", 500, 800, 975, 540);
    outro1.volume(0.85f);
    
    mouseReleased();
  } else if ((mouseX > width-1460) && (mouseY > 750) && (mouseX < width-500) && (mouseY < 1290) && (screenSelector == 8)) {
    fill(255, 255, 255, 75);
    rect(width-1460, 750, 960, 540);
    textFont(infoFont);
    textAlign(CENTER);
    fill(255);
    text("Kind", width-1460, 1010, 960, 540);
    outro2.volume(0.85f);
    
    mouseReleased();
  } else if ((mouseX > 500) && (mouseY > 1490) && (mouseX < 1460) && (mouseY < 2000) && (screenSelector == 8)) {
    fill(255, 255, 255, 75);
    rect(500, 1490, 960, 540);
    textFont(infoFont);
    textAlign(CENTER);
    fill(255);
    text("love the subs", 500, 1525, 900, 540);
    outro3.volume(0.85f);
    
    mouseReleased();
  } else if ((mouseX > width-1460) && (mouseY > 1490) && (mouseX < width-500) && (mouseY < 2000) && (screenSelector == 8)) {
    fill(255, 255, 255, 75);
    rect(width-1460, 1490, 960, 540);
    textFont(infoFont);
    textAlign(CENTER);
    fill(255);
    text("Roleplay", width-1460, 1600, 900, 540);
    outro4.volume(0.85f);
    
    mouseReleased();
  } else {
    outro1.volume(0);
    outro2.volume(0);
    outro3.volume(0);
    outro4.volume(0);
  }
}

void videoScreen() {
  background(0);
  
  stroke(255, 193, 218);
  strokeWeight(2);
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    //float x1 = map( i, 0, in6.bufferSize(), 0, width );
    //float x2 = map( i+1, 0, in6.bufferSize(), 0, width );
    //line(i, height-600 + in6.left.get(i)*50, i+5, height-600 + in6.left.get(i+1)*50);
    float x1 = map( i, 0, in.bufferSize(), 0, width );
    float x2 = map( i+1, 0, in.bufferSize(), 0, width );
    line(x1, height-300 + in.left.get(i)*50, x2, height-300 + in.left.get(i+1)*50);
  }
  
  fill(255, 255, 255, 75);
  rect(0, height-350, in.left.level()*width, 100 );
    
  textFont(recordFont);
  textAlign(LEFT);
  fill(255);
  text("Press R to record. Once you are done recording, press R to stop. Then press S to save.", 25, height-400);
  
  generatePastelStroke();
  fill(255, 193, 218);
  rect(0, 150, width, 400); 
  
  textFont(titleFont);
  textAlign(CENTER);
  fill(255);
  text("*ASMR*", 45, 175, width, height);
  
  //capture live camera
  if (user.available() == true) {
    user.read();
  }
  image(user, width/2-640, height/2-300, 1280, 720);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
  
  if((mouseX > 0) && (mouseY > 45) && (mouseX < width) && (mouseY < 220) && (screenSelector == 9)) {
      generatePastelStroke();
          tint(100, 209, 239);
    fill(255, 193, 218);
    rect(0, 150, width, 400);
    textFont(titleFont);
    textAlign(CENTER);
    fill(0);
    text("*ASMR*", 45, 175, width, height);
    
    //if mouse is pressed, go to next page
    mouseReleased();
  } else {
      generatePastelStroke();
    fill(255, 193, 218);
    rect(0, 150, width, 400);
   noTint();
    textFont(titleFont);
    textAlign(CENTER);
    fill(255);
    text("*ASMR*", 45, 175, width, height);
  }
}

void scoreScreen() {
  background(0);
  
  generatePastelStroke();
  fill(255, 193, 218);
  rect(0, 150, width, 400); 
  
  textFont(titleFont);
  textAlign(CENTER);
  fill(255);
  text("Your video is complete...", 45, 160, width-90, height-500);
  textFont(infoFont);
  textAlign(CENTER);
  fill(255);
  text("Congrats, you are a brand new ASMRtist!", 50, 900, width-90, height-500);
  textFont(recordFont);
  textAlign(RIGHT);
  fill(255, 193, 218);
  text("Press Esc to leave.", width-500, height-50);
}

void generatePastelColor() {
  red = random(200, 255);
  green = random(200, 256);
  blue = random(200, 256);
  
  fill(red, blue, green);
}

void generateDarkPastelColor() {
  red = random(94, 168);
  green = random(94, 168);
  blue = random(94, 168);
    
  fill(red, blue, green);
}

void generatePastelStroke() {
  red = random(200, 255);
  green = random(200, 256);
  blue = random(200, 256);
  
  strokeWeight(10); 
  stroke(red, blue, green);
}

void generateDarkPastelStroke() {
  red = random(100, 175);
  green = random(100, 175);
  blue = random(100, 175);
  
  strokeWeight(10);  
  stroke(red, blue, green);
}

void movieEvent(Movie m) {
  m.read();
}

void mouseReleased() {
  if ((mouseX > width/2-300) && (mouseY > height-450) && (mouseX < width/2+300) && (mouseY < height-150) && (screenSelector == 0) && (mousePressed)) {
    screenSelector = 1;
    asmr.play();
  } else if ((mouseX > width-1100) && (mouseY > height-350) && (mouseX < width-100) && (mouseY < height-50) && (screenSelector == 1) && (mousePressed)) {
    screenSelector = 2;
  }  else if ((mouseX > 500) && (mouseY > 750) && (mouseX < 1460) && (mouseY < 1290) && (screenSelector == 2) && (mousePressed)) {
    screenSelector = 3;
  } else if ((mouseX > width-1460) && (mouseY > 750) && (mouseX < width-500) && (mouseY < 1290) && (screenSelector == 2) && (mousePressed)) {
    screenSelector = 3;
  } else if ((mouseX > 500) && (mouseY > 1490) && (mouseX < 1460) && (mouseY < 2000) && (screenSelector == 2) && (mousePressed)) {
    screenSelector = 3;
  } else if ((mouseX > width-1460) && (mouseY > 1490) && (mouseX < width-500) && (mouseY < 2000) && (screenSelector == 2) && (mousePressed)) {
    screenSelector = 3;
  } else if ((mouseX > 500) && (mouseY > 750) && (mouseX < 1460) && (mouseY < 1290) && (screenSelector == 3) && (mousePressed)) {
    screenSelector = 4;
  }// else if((mouseX > width-1500) && (mouseY > height-350) && (mouseX < width) && (mouseY < height-50) && (screenSelector == 8) && (mousePressed)) {
  //  screenSelector = 9;
  //} 
  else if((mouseX > 0) && (mouseY > 45) && (mouseX < width) && (mouseY < 220) && (screenSelector == 9) && (mousePressed)) {
    screenSelector = 10;
  } else if((mouseX > width-1100) && (mouseY > height-350) && (mouseX < width-100) && (mouseY < height-50) && (screenSelector == 4) && (mousePressed)) {
    screenSelector = 8;
  } else if ((mouseX > width-1460) && (mouseY > 1490) && (mouseX < width-500) && (mouseY < 2000) && (screenSelector == 8) && (mousePressed)) {
    screenSelector = 9;
  } else if ((mouseX > width-1460) && (mouseY > 750) && (mouseX < width-500) && (mouseY < 1290) && (screenSelector == 8) && (mousePressed)) {
    screenSelector = 9;
  } else if ((mouseX > 500) && (mouseY > 1490) && (mouseX < 1460) && (mouseY < 2000) && (screenSelector == 8) && (mousePressed)) {
    screenSelector = 9;
  } else if ((mouseX > 500) && (mouseY > 750) && (mouseX < 1460) && (mouseY < 1290) && (screenSelector == 8) && (mousePressed)) {
    screenSelector = 9;
  }
  
  if ((key == 'r' || key == 'R') && (screenSelector == 2)) {
    if ((finalRecorder.isRecording()) &&  (in.isMonitoring())) {
      finalRecorder.endRecord();
    } else {
      finalRecorder.beginRecord();
    }
  }
  if ((key == 's' || key == 'S') && (screenSelector == 2)) {
    finalRecorder.save();
    println("Done saving intro.");
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    if (in.isMonitoring()) {
      in.disableMonitoring();
    } else {
      in.enableMonitoring();
    }
  }
}