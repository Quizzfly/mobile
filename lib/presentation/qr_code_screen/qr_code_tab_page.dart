import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../core/app_export.dart';
import 'bloc/qr_code_bloc.dart';
import 'models/qr_code_tab_model.dart';

class QrCodeTabPage extends StatefulWidget {
  const QrCodeTabPage({super.key});

  @override
  QrCodeTabPageState createState() => QrCodeTabPageState();

  static Widget builder(BuildContext context) {
    return BlocProvider<QrCodeBloc>(
      create: (context) => QrCodeBloc(QrCodeState(
        qrCodeTabModelObj: QrCodeTabModel(),
      ))
        ..add(QrCodeInitialEvent()),
      child: const QrCodeTabPage(),
    );
  }
}

class QrCodeTabPageState extends State<QrCodeTabPage> {
  void _showSnackBar(String message, bool isError) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? appTheme.red900 : Colors.green,
        duration: Duration(seconds: isError ? 3 : 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QrCodeBloc, QrCodeState>(
      listener: (context, state) {
        if (state.connectionStatus == ConnectionStatus.error) {
          _showSnackBar(state.errorMessage ?? 'An error occurred', true);
        } else if (state.connectionStatus == ConnectionStatus.joined) {
          _showSnackBar("Joined room successfully", false);
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 48.h,
            vertical: 162.h,
          ),
          child: Column(
            children: [
              if (state.isScanning)
                Container(
                  height: 294.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyle.roundedBorder20,
                    border: Border.all(
                      color: theme.colorScheme.onErrorContainer.withOpacity(1),
                      width: 1.h,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.h),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        MobileScanner(
                          controller:
                              context.read<QrCodeBloc>().cameraController,
                          onDetect: (capture) {
                            final List<Barcode> barcodes = capture.barcodes;
                            for (final barcode in barcodes) {
                              final roomPin =
                                  getLastSixDigits(barcode.rawValue ?? '');
                              if (roomPin != null &&
                                  state.connectionStatus !=
                                      ConnectionStatus.connecting) {
                                context
                                    .read<QrCodeBloc>()
                                    .add(JoinRoomEvent(roomPin));
                                break;
                              }
                            }
                          },
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: appTheme.whiteA700,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          width: 200.h,
                          height: 200.h,
                        ),
                      ],
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: ValueListenableBuilder(
                      valueListenable: context
                          .read<QrCodeBloc>()
                          .cameraController
                          .torchState,
                      builder: (context, state, child) {
                        return Icon(
                          state == TorchState.off
                              ? Icons.flash_off
                              : Icons.flash_on,
                          color: appTheme.whiteA700,
                        );
                      },
                    ),
                    onPressed: () => context
                        .read<QrCodeBloc>()
                        .cameraController
                        .toggleTorch(),
                  ),
                  SizedBox(width: 20.h),
                  IconButton(
                    icon: ValueListenableBuilder(
                      valueListenable: context
                          .read<QrCodeBloc>()
                          .cameraController
                          .cameraFacingState,
                      builder: (context, state, child) {
                        return Icon(
                          state == CameraFacing.front
                              ? Icons.camera_front
                              : Icons.camera_rear,
                          color: appTheme.whiteA700,
                        );
                      },
                    ),
                    onPressed: () => context
                        .read<QrCodeBloc>()
                        .cameraController
                        .switchCamera(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String? getLastSixDigits(String url) {
    List<String> parts = url.split('/');
    String lastPart = parts.last;
    return lastPart;
  }
}
