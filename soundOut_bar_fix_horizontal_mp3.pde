import ddf.minim.*; 
import ddf.minim.analysis.*;  //import the FFT filter library
Minim minim; 
AudioPlayer in;
//AudioInput in; 
FFT fftLin;
int count;

float[][] Scales = {
  {28, 110, 116.54, 123.37, 130.81, 138.59, 146.83, 155.56, 164.81, 174.61, 185, 196, 207.65, 220, 233.08, 246.94, 261.63, 277.18, 293.66, 311.13, 329.63, 349.23, 369.99, 392, 415.3, 440, 466.16, 493.88, 523.25 }
}; 
String[][] Names = {
  {"test", "A", "Bb(A#)", "H", "C", "C#(Db)", "D", "D#(Eb)", "E", "F", "F#(Gb)", "G", "G#(Ab)", "A", "Bb(A#)", "H", "C", "C#(Db)", "D", "D#(Eb)", "E", "F", "F#(Gb)", "G", "G#(Ab)", "A", "Bb(A#)", "H", "C"}
};

void setup()
{
  size(1480, 200, P2D);
  minim = new Minim(this);  
  in = minim.loadFile("04.mp3", 4096);   //the buffer size (4096) must be a power of 2 for the FFT to work. The sample rate is 44100 as default.
}

void draw()
{
  smooth();
    fill(10,10,10, 40);  
  rect(0,0,width,height);  //draws a rectangle with alpha-40 so you get a fade effect
  background(10, 10, 10);                           //clears the screen, pick either this line or the previous line for the desired effect.
  stroke(255);

  float freq = 0; 
  int space = -(width/28); 
  float num_sound = Scales[0][0];


  fill(255, 255, 255);  
  textSize(10);
  for (int n=0; n<num_sound; n++) {       //<-this loop cycles through each sound
    freq = Scales[0][n+1];     //<-pick the frequency from the scale array
    space += width/28;
    //space += width/(num_sound+.2);
    text(Names[0][n+1], space+15, 20); 
    if (freq>200) { 
      fftLin = new FFT( 4096, 44100 );
    }  //for higher frequencies use the high frequency spectrum
    else { 
      fftLin = new FFT( 4096, 22050 );
    }  //for frequencies 200Hz or lower use the low frequency spectrum   
    
    fftLin.forward(in.mix);      //draw the FFT spectrum analysis with bars every 4%
    strokeWeight(4); 
    stroke(150, 150, 150);
    
    line(space, 80, space, 80-fftLin.getFreq(freq*.84)*.5);
    line(space+5, 80, space+5, 80-fftLin.getFreq(freq*.88)*.5);
    line(space+10, 80, space+10, 80-fftLin.getFreq(freq*.92)*.5);
    line(space+15, 80, space+15, 80-fftLin.getFreq(freq*.96)*.5);   
    stroke(255, 0, 0);   //make the center frequency red
    line(space+20, 80, space+20, 80-fftLin.getFreq(freq)*.5);
    //println(fftLin.getFreq(130.81));
    //println(fftLin.getFreq(130.81*1.04));
    println(fftLin.getFreq(freq)*.5, freq);
    stroke(150, 150, 150);
    line(space+25, 80, space+25, 80-fftLin.getFreq(freq*1.04)*.5);
    line(space+30, 80, space+30, 80-fftLin.getFreq(freq*1.08)*.5);  
    line(space+35, 80, space+35, 80-fftLin.getFreq(freq*1.12)*.5); 
    line(space+40, 80, space+40, 80-fftLin.getFreq(freq*1.16)*.5);
    strokeWeight(1);
    
  if(freq == 110){
    count = count+1;
    //println("OK", count);
  } 
  }
}

void keyPressed()
{
  if ( key == 'l' ) in.loop();
}