import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArquivosAlunoPage extends StatefulWidget {
  const ArquivosAlunoPage({super.key});

  @override
  State<ArquivosAlunoPage> createState() => _ArquivosAlunoPageState();
}

class _ArquivosAlunoPageState extends State<ArquivosAlunoPage> {
  // Lista de materiais fornecidos pelo professor
  final List<MaterialEstudo> _materiais = [

  ];
  
  String _filtroSelecionado = 'Todos';
  String _termoPesquisa = '';
  final TextEditingController _pesquisaController = TextEditingController();

  List<MaterialEstudo> get _materiaisFiltrados {
    List<MaterialEstudo> materiais = _materiais;

    if (_filtroSelecionado != 'Todos') {
      TipoMaterial? tipoFiltro;
      switch (_filtroSelecionado) {
        case 'Vídeoaulas':
          tipoFiltro = TipoMaterial.video;
        case 'Documentos':
          tipoFiltro = TipoMaterial.documento;
      }
      if (tipoFiltro != null) {
        materiais = materiais.where((m) => m.tipo == tipoFiltro).toList();
      }
    }

    if (_termoPesquisa.isNotEmpty) {
      materiais = materiais.where((m) =>
          m.titulo.toLowerCase().contains(_termoPesquisa.toLowerCase())).toList();
    }

    return materiais;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          if (_materiais.isNotEmpty) _buildBarraPesquisa(),
          Expanded(
            child: _materiais.isEmpty 
              ? _buildEstadoVazio()
              : _buildListaMateriais(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade600, Colors.green.shade400],
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.folder_open, size: 40, color: Colors.white),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Materiais de Estudo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _materiais.isEmpty 
                    ? 'Nenhum material disponível'
                    : '${_materiaisFiltrados.length} materiais',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarraPesquisa() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          TextField(
            controller: _pesquisaController,
            onChanged: (value) => setState(() => _termoPesquisa = value),
            decoration: InputDecoration(
              hintText: 'Pesquisar materiais...',
              prefixIcon: Icon(Icons.search),
              suffixIcon: _termoPesquisa.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _pesquisaController.clear();
                        setState(() => _termoPesquisa = '');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: ['Todos', 'Vídeoaulas', 'Documentos']
                .map((filtro) => Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(filtro),
                        selected: _filtroSelecionado == filtro,
                        onSelected: (_) => setState(() => _filtroSelecionado = filtro),
                        selectedColor: Colors.green.shade100,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildListaMateriais() {
    if (_materiaisFiltrados.isEmpty) {
      return Center(
        child: Text(
          'Nenhum material encontrado',
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _materiaisFiltrados.length,
      itemBuilder: (context, index) {
        final material = _materiaisFiltrados[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getCorTipo(material.tipo).withOpacity(0.1),
              child: Icon(
                _getIconeTipo(material.tipo),
                color: _getCorTipo(material.tipo),
              ),
            ),
            title: Text(material.titulo, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(material.descricao, maxLines: 2, overflow: TextOverflow.ellipsis),
                SizedBox(height: 4),
                Text(
                  material.tipo == TipoMaterial.video ? 'Vídeoaula' : 'Documento',
                  style: TextStyle(
                    fontSize: 12,
                    color: _getCorTipo(material.tipo),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                material.tipo == TipoMaterial.video ? Icons.play_arrow : Icons.open_in_new,
                color: Colors.green,
              ),
              onPressed: () => _abrirLink(material.url),
            ),
            onTap: () => _abrirLink(material.url),
          ),
        );
      },
    );
  }

  Widget _buildEstadoVazio() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open_outlined, size: 80, color: Colors.grey.shade400),
            SizedBox(height: 24),
            Text(
              'Nenhum material disponível',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
            ),
            SizedBox(height: 12),
            Text(
              'Configure suas notificações caso ainda não tenha criado nenhuma.',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            Text(
              'Aguarde! Seus professores irão adicionar materiais de estudo em breve.',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _abrirLink(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Não foi possível abrir o link'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Link inválido'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  IconData _getIconeTipo(TipoMaterial tipo) {
    return tipo == TipoMaterial.video ? Icons.play_circle_filled : Icons.description;
  }

  Color _getCorTipo(TipoMaterial tipo) {
    return tipo == TipoMaterial.video ? Colors.red : Colors.blue;
  }
}

class MaterialEstudo {
  final String titulo;
  final String descricao;
  final TipoMaterial tipo;
  final String url;

  MaterialEstudo({
    required this.titulo,
    required this.descricao,
    required this.tipo,
    required this.url,
  });
}

enum TipoMaterial { video, documento }