import java.util.*;

int dim;
int offset;

int mines;
int maxMines; 

boolean playing = false;
boolean gameover = false;

Field[][] game;
MenuElement[] menu = new MenuElement[4];
Random r = new Random();

boolean DEBUG = false;

void setup()
{
  size(600, 700);
  background(255);
  menuInit();
}

void draw()
{ 
  background(255);
  if (!playing)
  {
    for (int i = 0; i < 4; i++)
    {
      menu[i].show();
      if (menu[i].clicked())
      {
        dim     = menu[i].value+1;        
        offset  = width/dim/2;
        mines   = menu[i].mines;
        maxMines = mines;
        gameInit();
      }
    }
  }
  if (playing)
  {
    HUD();
    for (int i = 0; i < dim-1; i++)
      for (int j = 0; j < dim-1; j++)
        game[i][j].show();
    if (gameover)
      reset();
  }
}

void menuInit()
{
  menu[0] = new MenuElement(width/8, 200, 200, 50, "10x10 15 mines" , 10, 15);
  menu[1] = new MenuElement(width/2, 200, 200, 50, "20x20 50 mines" , 20, 50);
  menu[2] = new MenuElement(width/8, 400, 200, 50, "25x25 100 mines", 25, 100);
  menu[3] = new MenuElement(width/2, 400, 200, 50, "30x30 300 mines", 30, 50);
}

void gameInit()
{
  game = new Field[dim][dim];
  for (int i = 0; i < dim-1; i++)
    for (int j = 0; j < dim-1; j++)
      game[i][j] = new Field(offset+i*width/dim, 100 + offset+j*(height-100)/dim, width/dim);
  while (mines > 0)
  {
    int i = r.nextInt(dim-1);
    int j = r.nextInt(dim-1);
    if (!game[i][j].bomb)
    {
      game[i][j].bomb = true;
      mines --;
    }
  }
  checkNears();
  playing = true;
  HUD();
}

void mousePressed()
{
  if (playing)
    for (int i = 0; i < dim-1; i++)
      for (int j = 0; j < dim-1; j++)
        if (game[i][j].clicked() && mouseButton == LEFT && !game[i][j].flag)
        {
          exposeNear(i, j);
          if (game[i][j].bomb && mouseButton == LEFT)
          {
            game[i][j].exposed = true;
            gameover = true;
          }
        }
}

void checkNears()
{
  for (int i = 0; i < dim-1; i++)
    for (int j = 0; j < dim-1; j++)
    {
      if (j != dim-2 && game[i][j+1].bomb == true)
        game[i][j].near++;
      if (j != 0 && game[i][j-1].bomb == true)
        game[i][j].near++;
      if (i != dim-2 && game[i+1][j].bomb == true)
        game[i][j].near++;
      if (i != 0 && game[i-1][j].bomb == true)
        game[i][j].near++;
      if (j != dim-2 && i != dim-2 && game[i+1][j+1].bomb == true)
        game[i][j].near++;
      if (j != 0 && i != 0 && game[i-1][j-1].bomb == true)
        game[i][j].near++;
      if (j != dim-2 && i != 0 && game[i-1][j+1].bomb == true)
        game[i][j].near++;
      if (j != 0 && i != dim -2 && game[i+1][j-1].bomb == true)
        game[i][j].near++;
    }
}

void exposeNear(int i, int j)
{
  if (game[i][j].near == 0 && !game[i][j].bomb)
  {
    if (j != dim-2 && !game[i][j+1].bomb)
    {
      if (game[i][j+1].near == 0 && !game[i][j+1].exposed)
      {
        game[i][j+1].exposed = true;
        exposeNear(i, j+1);
      }
      game[i][j+1].exposed = true;
    }  
    if (j != 0 && !game[i][j-1].bomb)
    {
      if (game[i][j-1].near == 0 && !game[i][j-1].exposed)
      {
        game[i][j-1].exposed = true;
        exposeNear(i, j-1);
      }
      game[i][j-1].exposed = true;
    }
    if (i != dim-2 && !game[i+1][j].bomb)
    {
      if (game[i+1][j].near == 0 && !game[i+1][j].exposed)
      {
        game[i+1][j].exposed = true;
        exposeNear(i+1, j);
      }
      game[i+1][j].exposed = true;
    }
    if (i != 0 && !game[i-1][j].bomb)
    {
      if (game[i-1][j].near == 0 && !game[i-1][j].exposed)
      {
        game[i-1][j].exposed = true;
        exposeNear(i-1, j);
      }
      game[i-1][j].exposed = true;
    }
    if (j != dim-2 && i != dim-2 && !game[i+1][j+1].bomb)
    {
      if (game[i+1][j+1].near == 0 && !game[i+1][j+1].exposed)
      {
        game[i+1][j+1].exposed = true;
        exposeNear(i+1, j+1);
      }
      game[i+1][j+1].exposed = true;
    }
    if (j != 0 && i != 0 && !game[i-1][j-1].bomb)
    {
      if (game[i-1][j-1].near == 0 && !game[i-1][j-1].exposed)
      {
        game[i-1][j-1].exposed = true;
        exposeNear(i-1, j-1);
      }
      game[i-1][j-1].exposed = true;
    }
    if (j != dim-2 && i != 0 && !game[i-1][j+1].bomb)
    {
      if (game[i-1][j+1].near == 0 && !game[i-1][j+1].exposed)
      {
        game[i-1][j+1].exposed = true;
        exposeNear(i-1, j+1);
      }
      game[i-1][j+1].exposed = true;
    }
    if (j != 0 && i != dim -2 && !game[i+1][j-1].bomb)
    {
      if (game[i+1][j-1].near == 0 && !game[i+1][j-1].exposed)
      {
        game[i+1][j-1].exposed = true;
        exposeNear(i+1, j-1);
      }
      game[i+1][j-1].exposed = true;
    }
  }
}

void reset()
{
  delay(1000);
  playing = false;
  gameover = false;
  setup();
}

void HUD()
{
  countMines();
  fill(0);
  textAlign(LEFT, CENTER);
  text("BOMBS: " + mines + "/" + maxMines, 0, 50);
}

void countMines()
{
  mines = 0;
  for (int i = 0; i < dim-1; i++)
    for (int j = 0; j < dim-1; j++)
      if (game[i][j].flag)
        mines++;
}
