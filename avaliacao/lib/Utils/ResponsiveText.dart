class ResponsiveText{

  //Responsividade de texto
  getValue({double valor,double max,double min}){
    if(valor < max && valor > min){
      return valor;
    }else if(valor < min){
      return min;
    }else{
      return max;
    }
  }
}