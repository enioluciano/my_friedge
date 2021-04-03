import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class FormatDataCustom {
  static formatData(String data) {
    initializeDateFormatting("pt_BR");
    // var formatador = DateFormat("d/ MMMM /yyyy ");
    var formatador = DateFormat.yMMMMd("pt_BR");

    DateTime dataConvert = DateTime.parse(data);
    String dataFormatador = formatador.format(dataConvert);

    return dataFormatador;
  }

  static formatHour(String data) {
    initializeDateFormatting("pt_BR");
    // var formatador = DateFormat("d/ MMMM /yyyy ");
    // var formatador = DateFormat.yMMMMd("pt_BR");
    DateFormat timeFormat = DateFormat.Hms('pt_BR');

    DateTime dataConvert = DateTime.parse(data);

    String hourFormater = timeFormat.format(dataConvert);

    return hourFormater;
  }
}
