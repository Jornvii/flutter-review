String determineCondition(int sys, int dia) {
  if (sys > 160 || dia > 100) {
    return 'ความดันโลหิตสูงมาก';
  } else if ((sys >= 140 && sys <= 159) || (dia >= 90 && dia <= 99)) {
    return 'ความดันโลหิตสูง';
  } else if (sys < 120 || dia < 80) {
    return 'ความดันโลหิตปกติ';
  } else {
    return 'ไม่ตรงกับความดันโลหิต';
  }
}