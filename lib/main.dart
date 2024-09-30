import 'package:flutter/material.dart';

void main() {
  runApp(const ToDo());
}
class ToDo extends StatelessWidget {
  const ToDo({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<Todoo> todos=[];
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        centerTitle: true,
        title: const Text("ToDo App", style: TextStyle(fontWeight: FontWeight.w700),),
        actions: [
          IconButton(onPressed: (){
            todos.clear();
            if(mounted)setState(() {});
          }, icon: const Icon(Icons.delete_forever_outlined))
        ],
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context,index){
        return Column(
          children: [
            ListTile(
              onLongPress: (){
                todos[index].isDone=!todos[index].isDone;
                setState(() {});
              },
              leading: todos[index].isDone?const Icon(Icons.done):const Icon(Icons.circle_outlined),
              trailing: IconButton(onPressed: (){
                todos.removeAt(index);
                setState(() {});
              }, icon: const Icon(Icons.delete)),
              title: Text(
                todos[index].title,
                style: TextStyle(
                  color: todos[index].isDone ? Colors.green : Colors.black,
                  decoration: todos[index].isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              tileColor: Colors.deepPurple.shade50,
            ),
            const SizedBox(height: 5),
          ],
        );
      }),

      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(context: context, builder: (context){
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(onPressed: (){
                  setState(() {});
                 todos.add(Todoo(titleController.text.trim(), false));
                  titleController.clear();
                }, child: const Text("Add"))
              ],
            ),
          );
        });
      }, child: const Icon(Icons.add),),
    )
;  }
}
class Todoo{
  String title;
  bool isDone;
  Todoo(this.title,this.isDone);
}
