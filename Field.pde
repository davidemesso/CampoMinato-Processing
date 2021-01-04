class Field
{
  int x;
  int y;
  int w;
  int value;
  boolean exposed = false;
  boolean bomb;
  boolean flag;
  int near;
  int nearFlags;

  Field(int x, int y, int w)
  {
    this.x = x;
    this.y = y;
    this.w = w;
  }

  void show()
  {
    strokeWeight(1);
    fill(180);
    rect(x, y, w, w);
    ellipseMode(CENTER);
    if (flag)
    {
      fill(220, 0, 0);
      triangle(x, y+w, x, y, x+w, y+w/2);
    }
    if (DEBUG || exposed)
    {
      if (near == 0)
      {
        fill(210);
        rect(x, y, w, w);
      }
      if (bomb) 
      {
        fill(0);
        ellipse(x+w/2, y+w/2, w/3*2, w/3*2);
      }
      textAlign(CENTER, CENTER);
      fill(0, 0, 0);
      if (near != 0 && !bomb)
        text(near, x+w/2, y+w/2-2);
    }
  }

  boolean clicked()
  {
    if (mouseX < x+w && mouseX > x && mouseY < y+w && mouseY > y)
    {
      if (mouseButton == LEFT)
      {
        if (!flag)
        {
          exposed = true;
          if (bomb) 
          {
            fill(0);
            ellipse(x+w/2, y+w/2, w/3*2, w/3*2);
          }
        }
      } 
      else
      {
        flag = !flag;
        if (near == 0)
          exposed = false;
      }
      return true;
    }
    return false;
  }
}
