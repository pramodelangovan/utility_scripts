#!/usr/bin/env python3
"""Randomly move the mouse and press harmless keys to keep the screen awake/online."""

import importlib
import os
import random
import subprocess
import sys
import time

os.environ.setdefault("DISPLAY", ":0")


def ensure_pyautogui():
    try:
        return importlib.import_module("pyautogui")
    except ImportError:
        print("pyautogui not found, installing...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", "--user", "pyautogui", "--break-system-packages."])
        return importlib.import_module("pyautogui")


pyautogui = ensure_pyautogui()
pyautogui.FAILSAFE = False

# Keys that are safe to tap without altering focused content
SAFE_KEYS = ["shift", "ctrl", "alt", "f15"]

MIN_INTERVAL_SECONDS = 30
MAX_INTERVAL_SECONDS = 120
MOUSE_MOVE_RANGE = 50


def random_mouse_move():
    screen_w, screen_h = pyautogui.size()
    x, y = pyautogui.position()
    dx = random.randint(-MOUSE_MOVE_RANGE, MOUSE_MOVE_RANGE)
    dy = random.randint(-MOUSE_MOVE_RANGE, MOUSE_MOVE_RANGE)
    new_x = min(max(x + dx, 0), screen_w - 1)
    new_y = min(max(y + dy, 0), screen_h - 1)
    pyautogui.moveTo(new_x, new_y, duration=random.uniform(0.2, 0.8))


def random_key_press():
    key = random.choice(SAFE_KEYS)
    pyautogui.press(key)


def main():
    print("Stay-active script running. Press Ctrl+C to stop.")
    try:
        while True:
            if random.random() < 0.5:
                random_mouse_move()
            else:
                random_key_press()
            time.sleep(random.uniform(MIN_INTERVAL_SECONDS, MAX_INTERVAL_SECONDS))
    except KeyboardInterrupt:
        print("\nStopped.")


if __name__ == "__main__":
    main()
