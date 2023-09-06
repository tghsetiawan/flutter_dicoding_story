import 'package:flutter/material.dart';

class LoadingOverlay {
  OverlayEntry? _overlay;

  // LoadingOverlay();

  void show(BuildContext context) {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        // replace with your own layout
        builder: (context) => ColoredBox(
          color: Color(0x80000000),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ),
      );
      Overlay.of(context).insert(_overlay!);
    }
  }

  void hide() {
    if (_overlay != null) {
      _overlay!.remove();
      _overlay = null;
    }
  }
}

// class StatelessSample extends StatelessWidget {
//   final LoadingOverlay _loadingOverlay = LoadingOverlay();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocListener<MyBloc, MyState>(
//         listener: (context, state) {
//           if (state is MyStateLoadInProgress) {
//             _loadingOverlay.show(context);
//           } else {
//             _loadingOverlay.hide();
//           }
//         },
//         child: Container(),
//       ),
//     );
//   }
// }