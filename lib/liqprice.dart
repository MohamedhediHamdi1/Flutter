double liquidation_price(bool longorshort,bool typeoftrade,double entryprice,int max,double leverage,double wallet,double quantity){
  if(typeoftrade==true){
    double m = 0 ;
    double x=0;
    if(max==125){m=0.4;}
    else if (max==100){m=0.5;}
    else if (max==50){m=1;}
    else if (max==25){m=3;}
    x=(max/leverage)*(m+m/max*(max-leverage));
    double l = 0;
    if(longorshort==true){
      l=entryprice-entryprice*x/100;
    }
    else if(longorshort==false){
      l=entryprice+entryprice*x/100;
    }
    return l;
  }
  else{
    double m = 0 ;
    double x=0;
    if(max==125){m=0.4;}
    else if (max==100){m=0.5;}
    else if (max==50){m=1;}
    else if (max==25){m=3;}
    x=(max/leverage)*(m+m/max*(max-leverage));
    double l = 0;
    double h = wallet/(quantity*0.995);
    if(longorshort==true){
      l=entryprice-entryprice*(x/100+100/leverage/100*h);
    }
    else if(longorshort==false){
      l=entryprice+entryprice*(x/100+100/leverage/100*h);
    }
    return l;
  }
}