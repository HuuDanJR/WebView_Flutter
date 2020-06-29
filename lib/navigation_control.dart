import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);
  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Padding(
          padding: const EdgeInsets.only(
            bottom:35,
          ),
          child: FloatingActionButton.extended(
                elevation: 10,
                hoverColor: Colors.blue.withOpacity(.5),
                onPressed: !webViewReady
                    ? null
                    : () => navigate(context, controller, goBack: true),
                icon: Icon(Icons.arrow_back),
                backgroundColor: Colors.blue,
                label: Text("Trở lại"),
          ),
        );
      },
    );
  }

  navigate(BuildContext context, WebViewController controller,
      {bool goBack: false}) async {
    bool canNavigate =
        goBack ? await controller.canGoBack() : await controller.canGoForward();
    if (canNavigate) {
      goBack ? controller.goBack() : controller.goForward();
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text("Đang ở trang chính")),
      );
    }
  }
}