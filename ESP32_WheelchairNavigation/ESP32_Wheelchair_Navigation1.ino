// Motor driver pins
#define IN1 27
#define IN2 26
#define IN3 25
#define IN4 33
#define ENA 14  // Enable pin for Motor A (Left)
#define ENB 32  // Enable pin for Motor B (Right)

#include <BluetoothSerial.h>
BluetoothSerial SerialBT;

void setup() {
  Serial.begin(115200);
  SerialBT.begin("ESP32-Car");
  Serial.println("Bluetooth Started. Send F,B,E,R,P,D,U or 2-letter room codes");

  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(IN3, OUTPUT);
  pinMode(IN4, OUTPUT);
  pinMode(ENA, OUTPUT);
  pinMode(ENB, OUTPUT);

  digitalWrite(ENA, HIGH);
  digitalWrite(ENB, HIGH);

  stopMotors();
}

void loop() {
  if (SerialBT.available()) {
    String input = SerialBT.readStringUntil('\n');
    input.trim();
    input.toUpperCase();

    Serial.print("Received: ");
    Serial.println(input);

    if (input.length() == 1) {
      handleManualCommand(input.charAt(0));
    } else if (input.length() == 2) {
      handleNavigationCommand(input);
    }
  }
}

// === Manual Commands ===
void handleManualCommand(char command) {
  switch (command) {
    case 'F': moveForward(); break;
    case 'D': moveBackward(); break;
    case 'E': turnLeft(); break;
    case 'R': turnRight(); break;
    case 'U': turnAround(); break;
    case 'P': stopMotors(); break;
    default: stopMotors(); break;
  }
}

// === Navigation Commands ===
void handleNavigationCommand(String code) {
  // Living Room (L) to others
  if      (code == "LT") { moveForward(); delay(1650); turnLeft(); delay(300); moveForward(); delay(300); stopMotors(); }       // 2.75 + turn + 0.5
  else if (code == "LS") { moveForward(); delay(1650); turnRight(); delay(300); moveForward(); delay(300); stopMotors(); }      // 2.75 + turn + 0.5
  else if (code == "LB") { moveForward(); delay(2100); turnRight(); delay(300); moveForward(); delay(300); stopMotors(); }      // 3.5 + turn + 0.5
  else if (code == "LK") { moveForward(); delay(3000); stopMotors(); }                                                          // 5

  // Study (T) to others
  else if (code == "TL") { moveForward(); delay(300); turnRight(); delay(300); moveForward(); delay(1650); stopMotors(); }      // 0.5 + turn + 2.75
  else if (code == "TS") { moveForward(); delay(1200); stopMotors(); }                                                          // 1
  else if (code == "TB") { moveForward(); delay(300); turnLeft(); delay(300); moveForward(); delay(1200); turnRight(); delay(300); moveForward(); delay(900); stopMotors(); } // 0.5+turn+1+turn+0.5
  else if (code == "TK") { moveForward(); delay(300); turnLeft(); delay(300); moveForward(); delay(2500); stopMotors(); }       // 0.5+turn+2.5

  // Bathroom (S) to others
  else if (code == "SL") { moveForward(); delay(600); turnLeft(); delay(300); moveForward(); delay(1200); stopMotors(); }       // 0.5 + turn + 2
  else if (code == "ST") { moveForward(); delay(1200); stopMotors(); }                                                          // 1
  else if (code == "SB") { moveForward(); delay(600); turnRight(); delay(300); moveForward(); delay(1200); turnRight(); delay(300); stopMotors(); } // 0.5+turn+1+turn
  else if (code == "SK") { moveForward(); delay(600); turnRight(); delay(300); moveForward(); delay(1800); stopMotors(); }      // 0.5 + turn + 1.5

  // Bedroom (B) to others
  else if (code == "BL") { moveForward(); delay(600); turnLeft(); delay(300); moveForward(); delay(1800); stopMotors(); }       // 0.5 + turn + 3
  else if (code == "BT") { moveForward(); delay(600); turnLeft(); delay(300); moveForward(); delay(1200); turnRight(); delay(300); moveForward(); delay(600); stopMotors(); } // 0.5+turn+1+turn+0.5
  else if (code == "BS") { moveForward(); delay(600); turnRight(); delay(300); moveForward(); delay(1200); turnRight(); delay(300); stopMotors(); } // 0.5+turn+1+turn
  else if (code == "BK") { moveForward(); delay(600); turnRight(); delay(300); moveForward(); delay(1200); stopMotors(); }      // 0.5 + turn + 1

  // Kitchen (K) to others
  else if (code == "KL") { moveForward(); delay(3000); stopMotors(); }                                                          // 5
  else if (code == "KT") { moveForward(); delay(1200); turnRight(); delay(300); moveForward(); delay(300); stopMotors(); }      // 2 + turn + 0.5
  else if (code == "KS") { moveForward(); delay(1200); turnLeft(); delay(300); moveForward(); delay(300); stopMotors(); }       // 2 + turn + 0.5
  else if (code == "KB") { moveForward(); delay(1200); turnLeft(); delay(300); moveForward(); delay(600); stopMotors(); }       // 1 + turn + 0.5

  else {
    Serial.println("Unknown navigation code");
    stopMotors();
  }
}


// === Motion Functions ===
void moveForward() {
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, LOW);
}

void moveBackward() {
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, HIGH);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, HIGH);
}

void turnLeft() {
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, HIGH);
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, LOW);
  delay(400);
  stopMotors();
  delay(300);
}

void turnRight() {
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, HIGH);
  delay(400);
  stopMotors();
  delay(300);
}

void turnAround() {
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, HIGH);
  delay(800);
  stopMotors();
  delay(300);
}

void stopMotors() {
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, LOW);
}
