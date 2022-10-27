class Pessoa {
  int? id;
  String? nome;
  String? email;
  String? aniversario;
  String? categoria;

  Pessoa();

  Pessoa.fromMap(Map map) {
    id = map['id'];
    nome = map['nome'];
    email = map['email'];
    aniversario = map['aniversario'];
    categoria = map['categoria'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nome': nome,
      'email': email,
      'aniversario': aniversario,
      'categoria': categoria,
    };
    // O id pode ser nulo caso o registro esteja sendo criado já que é o banco de dados que
    // atribui o ID ao registro no ato de salvar. Por isso devemos testar antes de atribuir
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return ("Id: $id, Nome: $nome, Email: $email, Aniversario: $aniversario, Categoria: $categoria");
  }
}
