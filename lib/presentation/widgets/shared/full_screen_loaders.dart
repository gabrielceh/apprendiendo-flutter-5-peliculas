import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  

  const FullScreenLoader({super.key});


  Stream<String> getLoadingMessages (){
  final List<String> messages = [
    'Espere un momento...',
    'Comprando los tickets 🎫',
    'Voy por palomitas de maiz 🍿',
    'Esperando a mi pareja 😍',
    'Llamando a los panas 🤙',
    'Necesito un poco de descanso 🥱',
    'Esto está tardando un poco ⌛',
  ];
    return Stream.periodic(
      const Duration(seconds: 2), 
      (int step) {
        return messages[step % messages.length];
      } 
    )
      .take(messages.length);
  } 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Cargando...'),
          const SizedBox(height: 10),
          const CircularProgressIndicator( strokeWidth: 2,),
          const SizedBox(height: 10),

          StreamBuilder(
            stream:getLoadingMessages(),
            builder: (context, snapshot){
              if(!snapshot.hasData) return const Text('Vamos...');

              return Text(snapshot.data!, style: Theme.of(context).textTheme.titleLarge);
            }
            
          )


        ],
      )
    );
  }
}