import os, sys

THIS_DIR = os.path.dirname(os.path.abspath(__file__)) #  root dir
ROOT_DIR = os.path.dirname(THIS_DIR) #  points to root dir
if ROOT_DIR not in sys.path:
    sys.path.insert(0, ROOT_DIR)
