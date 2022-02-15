Future<String> convert(DateTime dateTime) async {
  String fecha = "";
  String mes = "";
  switch (dateTime.month) {
    case 0:
      mes = "Ene";
      break;
    case 1:
      mes = "Feb";
      break;
    case 2:
      mes = "Mar";
      break;
    case 3:
      mes = "Abr";
      break;
    case 4:
      mes = "May";
      break;
    case 5:
      mes = "Jun";
      break;
    case 6:
      mes = "Jul";
      break;
    case 7:
      mes = "Ago";
      break;
    case 8:
      mes = "Sep";
      break;
    case 9:
      mes = "Oct";
      break;
    case 10:
      mes = "Nov";
      break;
    case 11:
      mes = "Dic";
      break;
  }
  fecha = '${dateTime.day}/$mes/${dateTime.year} ';
  return fecha;
}
