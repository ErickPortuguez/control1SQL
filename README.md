# ErickPortuguez
 function myFunction() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  var header = "";
  var detail = [];
  var datosAEnviar = [];

  ss.getRange("A2:D4").getValues().forEach(v => {
    header = v[0]
  })

  ss.getRange("A2:D4").getValues().forEach(v => {
    if (v[0] == header) {
      const data = {
        pariente: v[1],
        nombreM: v[2],
        correo: v[3]
      }
      detail.push(data);
    }
  })

  const data = {
    nombreA: header,
    detalle: detail
  }
