import Toybox.Lang;
import Toybox.Activity;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Weather as Weather;

class UltimateCyclingFieldView extends Ui.DataField {
  protected var hrZones;
  protected var imgHeart = WatchUi.loadResource(Rez.Drawables.HeartIcon);
  protected var imgHeartZ1 = WatchUi.loadResource(Rez.Drawables.HeartIconZ1);
  protected var imgHeartZ2 = WatchUi.loadResource(Rez.Drawables.HeartIconZ2);
  protected var imgHeartZ3 = WatchUi.loadResource(Rez.Drawables.HeartIconZ3);
  protected var imgHeartZ4 = WatchUi.loadResource(Rez.Drawables.HeartIconZ4);
  protected var imgHeartZ5 = WatchUi.loadResource(Rez.Drawables.HeartIconZ5);
  protected var imgCadence = WatchUi.loadResource(Rez.Drawables.CadenceIcon);
  protected var imgAscent = WatchUi.loadResource(Rez.Drawables.AscentIcon);
  protected var imgDescent = WatchUi.loadResource(Rez.Drawables.DescentIcon);
  protected var imgCal = WatchUi.loadResource(Rez.Drawables.CaloriesIcon);
  protected var imgEnergy = WatchUi.loadResource(Rez.Drawables.EnergyIcon);

  var elapsedDistance;
  var currentSpeed;
  var averageSpeed;
  var maxSpeed;
  var currentCadence;
  var averageCadence;
  var currentHeartRate;
  var averageHeartRate;
  var timerTime;
  var clockTime;
  var batteryPercentage;
  var batteryTimer;
  var currentLocationAccuracy;
  var temperature;
  var altitude;
  var totalAscent;
  var totalDescent;
  var trainingEffect;
  var calories;
  var energyExpenditure;
  var valuesType;
  var prevBatteryFetchedMin;
  var prevBatteryVal;
  var batteryConsumption;

  function initialize() {
    DataField.initialize();
    batteryPercentage = Sys.getSystemStats().battery;
    batteryConsumption = 0;
    prevBatteryVal = batteryPercentage;
    timerTime = 0;
    currentLocationAccuracy = 0;
    prevBatteryFetchedMin = 0;
    hrZones = UserProfile.getHeartRateZones(UserProfile.getCurrentSport());
    valuesType = "primary";
  }

  function compute(info) {
    elapsedDistance =
      (info.elapsedDistance != null ? info.elapsedDistance : 0) / 1000;

    timerTime = info.timerTime != null ? info.timerTime : 0;

    currentSpeed = (info.currentSpeed != null ? info.currentSpeed : 0) * 3.6;
    averageSpeed = (info.averageSpeed != null ? info.averageSpeed : 0) * 3.6;
    maxSpeed = (info.maxSpeed != null ? info.maxSpeed : 0) * 3.6;

    currentCadence = info.currentCadence != null ? info.currentCadence : 0.0;
    averageCadence = info.averageCadence != null ? info.averageCadence : 0.0;

    if (info has :currentHeartRate) {
      currentHeartRate =
        info.currentHeartRate != null ? info.currentHeartRate : 0.0;
    }

    altitude = info.altitude != null ? info.altitude : 0;
    currentLocationAccuracy =
      info.currentLocationAccuracy != null ? info.currentLocationAccuracy : 0;

    totalAscent = (info.totalAscent != null ? info.totalAscent : 0) * 3.28084;
    totalDescent =
      (info.totalDescent != null ? info.totalDescent : 0) * 3.28084;

    energyExpenditure =
      info.energyExpenditure != null ? info.energyExpenditure : 0;
    calories = info.calories != null ? info.calories : 0;
  }

  function onUpdate(dc) {
    var darkGreen = Gfx.COLOR_DK_GREEN;
    var halfWidth = dc.getWidth() / 2;
    var halfHeight = dc.getHeight() / 2;
    var CENTER_PADDING_TB = dc.getHeight() * 0.25;
    var CENTER_PADDING_LR = dc.getWidth() * 0.25;
    var CAD_HR_VALUE_HORI_OFFSET = 28;
    var DIS_TIME_VER_OFFSET = 28;

    var RIGHT_POS_X = dc.getWidth() - CAD_HR_VALUE_HORI_OFFSET - 6;
    var LEFT_POS_X = 6 + CAD_HR_VALUE_HORI_OFFSET;

    var backgroundColour = Gfx.COLOR_WHITE;

    clockTime = Sys.getClockTime();

    var speedColor;
    if (currentSpeed >= 20 && currentSpeed <= 30) {
      speedColor = darkGreen;
    } else if (currentSpeed > 30) {
      speedColor = Gfx.COLOR_DK_RED;
    } else {
      speedColor = Gfx.COLOR_BLACK;
    }

    // Alternate between primary and secondary fields for every 10 seconds
    if (getSeconds(clockTime) <= 10) {
      valuesType = "primary";
    } else if (getSeconds(clockTime) > 10 && getSeconds(clockTime) <= 20) {
      valuesType = "secondary";
    } else if (getSeconds(clockTime) > 20 && getSeconds(clockTime) <= 30) {
      valuesType = "primary";
    } else if (getSeconds(clockTime) > 30 && getSeconds(clockTime) <= 40) {
      valuesType = "secondary";
    } else if (getSeconds(clockTime) > 40 && getSeconds(clockTime) <= 50) {
      valuesType = "primary";
    } else if (getSeconds(clockTime) > 50 && getSeconds(clockTime) <= 59) {
      valuesType = "secondary";
    } else {
      valuesType = "primary";
    }

    if (
      getMinutes(clockTime) % 5 == 0 &&
      getMinutes(clockTime) != prevBatteryFetchedMin
    ) {
      batteryPercentage = Sys.getSystemStats().battery;
      batteryConsumption = prevBatteryVal - batteryPercentage;
      prevBatteryVal = batteryPercentage;
      prevBatteryFetchedMin = getMinutes(clockTime);
    }

    var batteryColor;
    if (batteryPercentage <= 30) {
      batteryColor = Gfx.COLOR_DK_RED;
    } else {
      batteryColor = Gfx.COLOR_BLACK;
    }

    dc.setColor(backgroundColour, backgroundColour);
    dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

    // Draw  Lines
    dc.setColor(darkGreen, Gfx.COLOR_TRANSPARENT);
    dc.drawLine(0, CENTER_PADDING_TB, dc.getWidth(), CENTER_PADDING_TB);
    dc.drawLine(
      0,
      dc.getHeight() - CENTER_PADDING_TB,
      dc.getWidth(),
      dc.getHeight() - CENTER_PADDING_TB
    );

    dc.drawLine(
      CENTER_PADDING_LR,
      CENTER_PADDING_TB,
      CENTER_PADDING_LR,
      dc.getHeight() - CENTER_PADDING_TB
    );
    dc.drawLine(
      dc.getWidth() - CENTER_PADDING_LR,
      CENTER_PADDING_TB,
      dc.getWidth() - CENTER_PADDING_LR,
      dc.getHeight() - CENTER_PADDING_TB
    );

    dc.drawLine(halfWidth, 0, halfWidth, CENTER_PADDING_TB);

    dc.drawLine(
      halfWidth,
      dc.getHeight(),
      halfWidth,
      dc.getHeight() - CENTER_PADDING_TB
    );

    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);

    // TOP: Elapsed Time and Distance section
    dc.drawText(
      halfWidth - 12,
      DIS_TIME_VER_OFFSET,
      Gfx.FONT_XTINY,
      formatClockTime(clockTime),
      Gfx.TEXT_JUSTIFY_RIGHT
    );

    dc.drawText(
      halfWidth + 12,
      DIS_TIME_VER_OFFSET,
      Gfx.FONT_XTINY,
      formatDistance(elapsedDistance) + " km",
      Gfx.TEXT_JUSTIFY_LEFT
    );

    //LEFT: Elevation Section
    drawFieldWIthVal(
      dc,
      LEFT_POS_X,
      CENTER_PADDING_TB + 12,
      "cad",
      currentCadence.format("%d")
    );

    drawFieldWIthVal(
      dc,
      LEFT_POS_X,
      CENTER_PADDING_TB + 12 + 54,
      "hr",
      currentHeartRate.format("%d")
    );

    // CENTER: Speed
    if (valuesType.equals("primary")) {
      dc.drawText(
        halfWidth,
        CENTER_PADDING_TB + 8,
        Gfx.FONT_XTINY,
        "avg: " + averageSpeed.format("%.2f") + " kph",
        Gfx.TEXT_JUSTIFY_CENTER
      );
    } else {
      dc.drawText(
        halfWidth,
        CENTER_PADDING_TB + 8,
        Gfx.FONT_XTINY,
        "max: " + maxSpeed.format("%.2f") + " kph",
        Gfx.TEXT_JUSTIFY_CENTER
      );
    }

    dc.setColor(speedColor, Gfx.COLOR_TRANSPARENT);
    dc.drawText(
      halfWidth - 4,
      halfHeight - 44,
      Gfx.FONT_NUMBER_HOT,
      currentSpeed.format("%d"),
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);

    dc.drawText(
      halfWidth,
      halfHeight + 32,
      Gfx.FONT_XTINY,
      "ela: " + formatElapsedTime(timerTime),
      Gfx.TEXT_JUSTIFY_CENTER
    );

    drawKPH(dc, halfWidth + 44, halfHeight);

    // RIGHT: Elevation Section

    if (valuesType.equals("primary")) {
      drawFieldWIthVal(
        dc,
        RIGHT_POS_X,
        CENTER_PADDING_TB + 12,
        "energy",
        energyExpenditure.format("%d")
      );

      drawFieldWIthVal(
        dc,
        RIGHT_POS_X,
        CENTER_PADDING_TB + 12 + 54,
        "cal",
        millify(calories)
      );
    } else {
      drawFieldWIthVal(
        dc,
        RIGHT_POS_X,
        CENTER_PADDING_TB + 12,
        "asc",
        totalAscent.format("%d")
      );

      drawFieldWIthVal(
        dc,
        RIGHT_POS_X,
        CENTER_PADDING_TB + 12 + 54,
        "desc",
        totalDescent.format("%d")
      );
    }

    // BOTTOM: Battery and GPS section

    var batteryText;
    if (valuesType.equals("primary")) {
      batteryText = batteryPercentage.format("%.1f") + " %";
    } else {
      batteryText =
        batteryConsumption > 0
          ? "-" + (batteryConsumption * 12).format("%.1f") + "% hr"
          : "- 0% hr";
    }
    dc.setColor(batteryColor, Gfx.COLOR_TRANSPARENT);
    dc.drawText(
      halfWidth - 32,
      dc.getHeight() - DIS_TIME_VER_OFFSET - 16,
      Gfx.FONT_XTINY,
      batteryText,
      Gfx.TEXT_JUSTIFY_CENTER
    );
    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);

    drawGPSSection(
      dc,
      halfWidth + 24,
      dc.getHeight() - DIS_TIME_VER_OFFSET - 4,
      currentLocationAccuracy
    );
  }

  function formatClockTime(clockTime) {
    var hour = clockTime.hour;
    var ampm = "";
    //handle midnight and noon, which return as 0
    hour = clockTime.hour % 12 == 0 ? 12 : clockTime.hour % 12;
    ampm = clockTime.hour >= 12 && clockTime.hour < 24 ? " pm" : " am";

    var timeString = Lang.format("$1$:$2$$3$", [
      hour.format("%02d"),
      clockTime.min.format("%02d"),
      ampm,
    ]);
    return timeString;
  }

  function getSeconds(clockTime) {
    return clockTime.sec;
  }

  function getMinutes(clockTime) {
    return clockTime.min;
  }

  function getTenKmPace(avgSpeed) {
    var tenkmpace;
    if (avgSpeed > 0) {
      tenkmpace = 10 / (avgSpeed / 60);
    } else {
      tenkmpace = 0;
    }
    return tenkmpace.format("%d");
  }

  function formatElapsedTime(time) {
    var seconds = ((time / 1000).toLong() % 60).format("%02d");
    var minutes = ((time / 60000).toLong() % 60).format("%02d");
    var hours = (time / 3600000).format("%d");
    var timeString = hours + ":" + minutes + ":" + seconds;
    return timeString;
  }

  function formatDistance(distance) {
    if (distance != null && distance > 0) {
      if (distance >= 1000) {
        return distance.format("%d");
      } else if (distance >= 100) {
        return distance.format("%.1f");
      } else {
        return distance.format("%.2f");
      }
    } else {
      return "0.00";
    }
  }

  function millify(value) {
    var formattedVal;
    if (value >= 1000) {
      formattedVal = (value / 1000).format("%d") + "k";
    } else {
      formattedVal = value;
    }
    return formattedVal;
  }

  function formatGPSAccuracy(value) {
    var gps;
    if (value == 1) {
      gps = "bad";
    } else if (value == 2) {
      gps = "poor";
    } else if (value == 3) {
      gps = "usable";
    } else if (value == 4) {
      gps = "good";
    } else {
      gps = "na";
    }
    return gps;
  }

  function drawKPH(dc, x, y) {
    dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
    dc.drawText(x, y - 24, Gfx.FONT_XTINY, "k", Gfx.TEXT_JUSTIFY_CENTER);
    dc.drawText(x, y - 12, Gfx.FONT_XTINY, "p", Gfx.TEXT_JUSTIFY_CENTER);

    dc.drawText(x, y + 4, Gfx.FONT_XTINY, "h", Gfx.TEXT_JUSTIFY_CENTER);
    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
  }

  function drawGPSSection(dc, x, y, accuracy) {
    var width = 7;
    var margin = width + 2;
    var offset = 4;

    dc.setColor(0xc3c3c3, Gfx.COLOR_TRANSPARENT);
    dc.fillRectangle(x + margin * 0, y - offset * 0, width, offset * 1);
    dc.fillRectangle(x + margin * 1, y - offset * 1, width, offset * 2);
    dc.fillRectangle(x + margin * 2, y - offset * 2, width, offset * 3);
    dc.fillRectangle(x + margin * 3, y - offset * 3, width, offset * 4);

    dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
    if (accuracy == 4) {
      dc.fillRectangle(x + margin * 0, y - offset * 0, width, offset * 1);
      dc.fillRectangle(x + margin * 1, y - offset * 1, width, offset * 2);
      dc.fillRectangle(x + margin * 2, y - offset * 2, width, offset * 3);
      dc.fillRectangle(x + margin * 3, y - offset * 3, width, offset * 4);
    } else if (accuracy == 3) {
      dc.fillRectangle(x + margin * 0, y - offset * 0, width, offset * 1);
      dc.fillRectangle(x + margin * 1, y - offset * 1, width, offset * 2);
      dc.fillRectangle(x + margin * 2, y - offset * 2, width, offset * 3);
    } else if (accuracy == 2) {
      dc.fillRectangle(x + margin * 0, y - offset * 0, width, offset * 1);
      dc.fillRectangle(x + margin * 1, y - offset * 1, width, offset * 2);
    } else if (accuracy == 1) {
      dc.fillRectangle(x + margin * 0, y - offset * 0, width, offset * 1);
    }
    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
  }

  function drawFieldWIthVal(dc, x, y, label, val) {
    // label or icon
    if (label.equals("asc")) {
      dc.drawBitmap(x - 8, y + 2, imgAscent);
    } else if (label.equals("desc")) {
      dc.drawBitmap(x - 8, y + 2, imgDescent);
    } else if (label.equals("cal")) {
      dc.drawBitmap(x - 8, y + 2, imgCal);
    } else if (label.equals("energy")) {
      dc.drawBitmap(x - 8, y + 2, imgEnergy);
    } else if (label.equals("cad")) {
      dc.drawBitmap(x - 8, y + 2, imgCadence);
    } else if (label.equals("hr")) {
      dc.drawBitmap(x - 8, y + 2, getHRImage(val.toNumber()));
    } else {
      dc.drawText(x, y - 2, Gfx.FONT_XTINY, label, Gfx.TEXT_JUSTIFY_CENTER);
    }

    //value
    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    dc.drawText(x, y + 16, Gfx.FONT_TINY, val, Gfx.TEXT_JUSTIFY_CENTER);
  }

  function isBetween(min, max, val) {
    return val >= min && val <= max;
  }

  function getHRImage(val) {
    var image;
    if (isBetween(hrZones[0], hrZones[1], val)) {
      image = imgHeartZ1;
    } else if (isBetween(hrZones[1], hrZones[2], val)) {
      image = imgHeartZ2;
    } else if (isBetween(hrZones[2], hrZones[3], val)) {
      image = imgHeartZ3;
    } else if (isBetween(hrZones[3], hrZones[4], val)) {
      image = imgHeartZ4;
    } else if (val > hrZones[4]) {
      image = imgHeartZ5;
    } else {
      image = imgHeart;
    }
    return image;
  }

  function log(text) {
    System.println(text);
  }
}
