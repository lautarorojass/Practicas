
import sys
import os

sys.path.insert(0, os.path.abspath(
    os.path.join(os.path.dirname(__file__), "../src")))

from main import obtener_tareas

def test_obtener_tareas():
    tareas = obtener_tareas()

    assert len(tareas) == 3


def test_tareas_son_strings():
    tareas = obtener_tareas()

    for tarea in tareas:
        assert isinstance(tarea, str)
