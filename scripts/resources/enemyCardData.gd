extends Resource
class_name EnemyCardData       # Así aparecerá en el diálogo de "Crear Recurso"

@export var idName: String = ""        # Ej: "idEnemDano10"
@export var name: String = ""     # El nombre para mostrar
@export var type: String = ""          # Por ejemplo: "time" o "passive"
@export var cooldown: float = 5.0      # Solo para cartas "time"
@export var description: String = ""   # Texto descriptivo
