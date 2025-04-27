from flask import Flask, render_template, request
import serial
import serial.tools.list_ports
import time
import atexit 

# Create Flask app 
app = Flask(__name__) 

# Global variable for Arduino connection 
arduino = None

# Find and connect to Arduino 
def connect_arduino():
  global arduino 

  # Close any existing connection to avoid permission errors 
  if arduino is not None: 
    try: 
      arduino.close()
      print("Close existing connection")
    except: 
      pass

  # List all available ports
  print("Looking for Arduino...")
  ports = list(serial.tools.list_ports.comports())
  for p  in ports: 
    print(f"Found port: {p.device}")

  # Try to find Arduino port
  arduino_port = None 
  for p in ports: 
    if "Arduino" in p.description or "CH340" in p.description:
      arduino_port = p.device
      print(f"Arduino found at {arduino_port}")
      break

  # If not found, try COM3 or COM4 (common Arduino ports) 
  if not arduino_port: 
    if any(p.device == "COM4" for p in ports): 
      arduino_port = "COM4"
      print("Using COM4 for Aruduino")
    elif any(p.device == "COM3" for p in ports): 
      arduino_port = "COM3"
      print("Using COM3 for Arduino")
    else: 
      print("Arduino not found automatically.")
      return False

  # Connect to the port
  try: 
    arduino = serial.Serial(arduino_port, 9600, timeout=1)
    time.sleep(2)   # Wait for Arduino to reset
    print("Connected to Arduino!")
    return True 
  except Exception as e: 
    print(f"Error connecting: {e}")
    return False

  # Close Arduino connection when the app exits
  def close_arduino():
    global arduino
    if arduino:
        try:
            arduino.close()
            print("Arduino connection closed")
        except:
            pass

  # Register the function to be called on exit
  atexit.register(close_arduino)

  # Send command to Arduino using a context manager to avoid port conflicts
  def send_to_arduino(command):
    global arduino

    try:
        # If we don't have a connection or it's closed, try to reconnect
        if not arduino or not arduino.is_open:
            if not connect_arduino():
                return "Not connected to Arduino"

        # Send the command
        arduino.write(f"{command}\n".encode())
        print(f"Sent: {command}")

        # Wait for response
        time.sleep(0.1)
        response = ""
        while arduino.in_waiting:
            response += arduino.readline().decode().strip()

        if response:
            print(f"Arduino says: {response}")
            return response

        return f"Command {command} sent"

    except Exception as e:
        print(f"Error: {e}")
        # Try to close and reset connection for next attempt
        try:
            if arduino:
                arduino.close()
        except:
            pass
        arduino = None
        return f"Error sending command: {e}"
