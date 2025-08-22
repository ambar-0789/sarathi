# Sarathi – The Smart Wheelchair

**Sarathi** is a smart wheelchair system designed to empower patients with independent navigation and seamless caregiver connectivity.
It combines **ESP32-based motor control** with a **Mobile Application** for patients and guardians, enabling both **manual control** and **automated room-to-room navigation**, along with **real-time alerts, reminders and texts**.

## Features

### Wheelchair Prototype

* **Bluetooth-controlled navigation** (via Flutter app).
* **Manual driving** using directional commands (`F`, `B`, `L`, `R`, `S`, `U`).
* **Automated single-hop room-to-room navigation** using predefined 2-letter codes (e.g., `LS` = Living → Study).
* **Safe turns with reduced speed** (no PWM required).
* **Delay-based timed navigation** (customizable for different paths).

### Mobile Application

* **Patient Dashboard:**

  * Manual joystick-style control.
  * SOS button for emergencies.
  * Chat with guardian.
  * Profile page with editable details.
  * Medicine reminders with local notifications.

* **Guardian Dashboard:**

  * Receives patient SOS alerts.
  * Reads patient profile & medicines from Firebase.
  * Chat with patient in real-time.

### Backend

* **Firebase Firestore** for storing patient & guardian profiles, medicine reminders, and chat messages.
* **flutter\_bluetooth\_serial** for Classic Bluetooth communication with ESP32.
* **flutter\_local\_notifications + timezone** for reminders.

---
## Installation

### Hardware Setup

1. Flash ESP32 with the provided Arduino code (`esp32_wheelchair.ino`).
2. Connect motor driver to ESP32 GPIO pins.
3. Map valid room-to-room routes inside the code.
4. Power the system and pair ESP32 with your phone.

### Flutter App Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/<your-username>/Sarathi-smart-wheelchair.git
   cd Sarathi-smart-wheelchair
   ```
2. Install dependencies:

   ```bash
   flutter pub get
   ```
3. Setup Firebase:

   * Create Firebase project.
   * Add Android apps.
   * Replace `google-services.json` / `GoogleService-Info.plist`.
4. Run the app:

   ```bash
   flutter run
   ```

---

## Usage

* **Manual Mode:** Use arrow buttons on the patient app to drive (`F`, `B`, `L`, `R`, `S`, `U`).
* **Room Navigation:** Select predefined route (e.g., `LB` for Living → Bedroom).
* **SOS Alert:** Tap SOS button to notify guardian.
* **Medicine Reminder:** Add medicines in Patient Profile → Guardian can view them.
* **Chat:** Patients and guardians can communicate in real-time.

---

## Repository Structure

```
Sarathi-smart-wheelchair/
│── hardware/
│   └── esp32_wheelchair.ino        # ESP32 motor control code
│── app/
│   └── lib/                        # Flutter app source
│── docs/
│   └── report/                     # Design & research documentation
│── README.md
```

