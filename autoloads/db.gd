extends Node

var db: SQLite

const DB_DESTÍ := "user://puntuacions.db"

func _ready():
	_crear_i_connectar()

func _crear_i_connectar():
	db = SQLite.new()
	db.path = DB_DESTÍ
	db.verbosity_level = SQLite.QUIET

	if db.open_db():
		print("Base de dades connectada correctament!")
	else:
		push_error("No s'ha pogut obrir la base de dades!")
		return

	_crear_taules()

func _crear_taules():
	db.query("
        CREATE TABLE IF NOT EXISTS puntuacions (
			id        INTEGER PRIMARY KEY AUTOINCREMENT,
			personatge   TEXT    NOT NULL,
			puntuacio INTEGER NOT NULL,
			estatPartida BOOLEAN NOT NULL,
            data      TEXT    DEFAULT (date('now'))
        );
	")

func _inserir_dades_prova():
	db.query("SELECT COUNT(*) as total FROM puntuacions;")
	if db.query_result[0]["total"] == 0:
		db.query("INSERT INTO puntuacions (personatge, puntuacio, estatPartida) VALUES ('Pep', 9500, 1);")
		db.query("INSERT INTO puntuacions (personatge, puntuacio, estatPartida) VALUES ('Luciano', 7200, 0);")
		db.query("INSERT INTO puntuacions (personatge, puntuacio, estatPartida) VALUES ('Anderson', 8800, 1);")
		print("Dades de prova inserides!")

func _exit_tree():
	if db:
		db.close_db()

# ── Mètodes públics ──────────────────────────────

func obtenir_puntuacions(limit: int = 10) -> Array:
	db.query("SELECT personatge, puntuacio, estatPartida, data FROM puntuacions ORDER BY puntuacio DESC LIMIT %d;" % limit)
	return db.query_result

func afegir_puntuacio(personatge: String, puntuacio: int, estatPartida: bool) -> void:
	db.query_with_bindings(
		"INSERT INTO puntuacions (personatge, puntuacio, estatPartida) VALUES (?, ?, ?);",
		[personatge, puntuacio, estatPartida]
	)
