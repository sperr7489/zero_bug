calAlarmTime(int zeroBase, int min) {
  /**
   * zeroBase가 10일 때
   * 1시 21분이면 1시 30분에 알람이 울려야 한다. 
   * zeroBase가 30일 때 
   * 1시 21분이면 1시 30분에 알람이 울려야 한다.
   * zeroBase가 60일 때 
   * 1시 21분이면 2시에 알람이 울려야 한다.  
   */
  int quotient = min ~/ zeroBase;
//  ( quotient + 1 ) * zeroBase 는 zeroBase가 60분일땐 무조건 1이된다.
  int addMin = (quotient + 1) * zeroBase - min;
  DateTime alarmTime = DateTime.now().add(Duration(minutes: addMin));

  return alarmTime;
}
