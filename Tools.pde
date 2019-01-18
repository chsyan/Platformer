PImage reverse( PImage image ) {
  PImage reverse = createImage(image.width, image.height, ARGB );

  for ( int i=0; i < image.width; i++ )
    for (int j=0; j < image.height; j++) {
      int xPixel = image.width - 1 - i;
      int yPixel = j;
      reverse.pixels[yPixel*image.width+xPixel]=image.pixels[j*image.width+i] ;
    }
  return reverse;
}

ArrayList<PImage> toArrayList(PImage[] image) {
  ArrayList<PImage> toArrList = new ArrayList<PImage>();
  for (int i=0; i<image.length; i++)
    toArrList.add(image[i]);
  return toArrList;
}
