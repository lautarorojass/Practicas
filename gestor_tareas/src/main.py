import requests
from rich import print


def obtener_tareas():
    tareas = [
        "Estudiar Python",
        "Hacer el TP",
        "Subir el proyecto a GitHub"
    ]

    return tareas


def mostrar_tareas():
    tareas = obtener_tareas()

    print("[bold green]Lista de tareas:[/bold green]")

    for tarea in tareas:
        print(f"- {tarea}")


if __name__ == "__main__":
    mostrar_tareas()
