import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
FFT fft;

PImage fade;

float rWidth;
float rHeight;

float freq;
float freqVol;

void setup() {
  size(900, 600, P3D);
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.logAverages(60, 7);
  
  background(0);
  fade = get(0, 0, width, height);
  
  rWidth = width * 0.99;
  rHeight = height * 0.99;
}

void draw() {
  fft.forward(in.mix);
  
  tint(255,255,255,254);
  image(fade, (width - rWidth)/2, (height - rHeight)/2, rWidth, rHeight);
  noTint();
  
  for(int i = 0; i <fft.avgSize(); i++) {
    freqVol = fft.getBand(i);
    freq = (fft.getAvg(i) * 0.5 * (in.sampleRate()/fft.avgSize()));
    
    if(freq>=9397) {
      freq = freq%400;
    }
    if(freq>73) {
      freq += random(1000);
    } 
    if(freq>=73 && freq<=77.99 || freq>=147 && freq<=155.99 || freq>=294 && freq<=310.99 || freq>=587 && freq<=621.99 || freq>=1175 && freq<=1244.99 || freq>=2349 && freq<=2488.99 || freq>=4699 && freq<=4977.99) { 
      fill(6,26,131); //D dark BLue
    } 
    if(freq>=78 && freq<=81.99 || freq>=156 && freq<=164.99 || freq>=311 && freq<=329.99 || freq>=622 && freq<=658.99 || freq>=1245 && freq<=1318.99 || freq>=2489 && freq<=2636.99 || freq>=4978 && freq<=5273.99) {
      fill(120,2,141); //D# Purple
    } 
    if(freq>=82 && freq<=86.99 || freq>=165 && freq<=174.99 || freq>=330 && freq<=348.99 || freq>=659 && freq<=697.99 || freq>=1319 && freq<=1396.99 || freq>=2637 && freq<=2793.99 || freq>=5274 && freq<=5587.99) {
      fill(166,0,94); //E Magenta
    } 
    if(freq>=87 && freq<=92.99 || freq>=175 && freq<=184.99 || freq>=349 && freq<=369.99 || freq>=698 && freq<=739.99 || freq>=1397 && freq<=1479.99 || freq>=2794 && freq<=2959.99 || freq>=5588 && freq<=5919.99) {
      fill(244,4,140); //F dark Pink
    } 
    if(freq>=93 && freq<=97.99 || freq>=185 && freq<=195.99 || freq>=370 && freq<=391.99 || freq>=740 && freq<=783.99 || freq>=1480 && freq<=1567.99 || freq>=2960 && freq<=3135.99 || freq>=5920 && freq<=6271.99) {
      fill(221,254,85); //F# Lime
    } 
    if(freq>=98 && freq<=103.99 || freq>=196 && freq<=207.99 || freq>=392 && freq<=414.99 || freq>=784 && freq<=830.99 || freq>=1568 && freq<=1660.99 || freq>=3136 && freq<=3321.99 || freq>=6272 && freq<=6644.99) {
      fill(255,0,13); //G Red
    }
    if(freq>=104 && freq<=109.99 || freq>=208 && freq<=219.99 || freq>=415 && freq<=439.99 || freq>=831 && freq<=879.99 || freq>=1661 && freq<=1759.99 || freq>=3322 && freq<=3519.99 || freq>=6645 && freq<=7039.99) {
      fill(255,100,0); //G# Orange
    }
    if(freq>=110 && freq<=116.99 || freq>=220 && freq<=232.99 || freq>=440 && freq<=465.99 || freq>=880 && freq<=931.99 || freq>=1760 && freq<=1863.99 || freq>=3520 && freq<=3728.99 || freq>=7040 && freq<=7458.99) {
      fill(203,120,0); //A Gold
    }
    if(freq>=117 && freq<=122.99 || freq>=233 && freq<=246.99 || freq>=466 && freq<=492.99 || freq>=932 && freq<=987.99 || freq>=1864 && freq<=1975.99 || freq>=3729 && freq<=3950.99 || freq>=7459 && freq<=7901.99) {
      fill(255,245,0); //A# Yellow
    }
    if(freq>=123 && freq<=130.99 || freq>=247 && freq<=261.99 || freq>=493 && freq<=522.99 || freq>=988 && freq<=1046.99 || freq>=1976 && freq<=2092.99 || freq>=3951 && freq<=4185.99 || freq>=7902 && freq<=8371.99) {
      fill(35,255,0); //B Green
    }
    if(freq>=131 && freq<=138.99 || freq>=262 && freq<=276.99 || freq>=523 && freq<=553.99 || freq>=1047 && freq<=1108.99 || freq>=2093 && freq<=2216.99 || freq>=4186 && freq<=4434.99 || freq>=8372 && freq<=8869.99) {
      fill(124,201,255); //C light Blue
    }
    if(freq>=139 && freq<=146.99 || freq>=277 && freq<=293.99 || freq>=554 && freq<=586.99 || freq>=1109 && freq<=1174.99 || freq>=2217 && freq<=2348.99 || freq>=4435 && freq<=4698.99 || freq>=8870 && freq<=9396.99) {
      fill(12,46,227); //C# Blue
    }
    if(freqVol < 5){
      freqVol = freqVol*10; // mod for visibility
    }
    
    if(mouseX > 1 && mouseX < 899 && mouseY > 1 && mouseY < 599){
      ellipse(mouseX, mouseY, freqVol, freqVol); 
    }
    fade = get(0, 0, width, height);
  }
  
  if(keyPressed) {
    if(key == 's' || key == 'S') { //save
      save("../Desktop/AudialArt.jpg");
    }
    if(key == 'r' || key == 'R') { //reset
      fill(0);
      rect(0,0,width,height);
    }
  }
}

void stop() {
  in.close();
  minim.stop();
  super.stop();
}
