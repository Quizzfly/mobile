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
      ))..add(QrCodeInitialEvent()),
      child: const QrCodeTabPage(),
    );
  }
}

class QrCodeTabPageState extends State<QrCodeTabPage> {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanning = true;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 48.h,
        vertical: 162.h,
      ),
      child: Column(
        children: [
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
                  // QR Scanner
                  MobileScanner(
                    controller: cameraController,
                    onDetect: (capture) {
                      final List<Barcode> barcodes = capture.barcodes;
                      for (final barcode in barcodes) {
                        if (mounted && isScanning) {
                          setState(() {
                            isScanning = false;
                          });
                          // Handle the scanned QR code result
                          _handleQRCode(barcode.rawValue ?? '');
                        }
                      }
                    },
                  ),
                  // Scanning overlay
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
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: ValueListenableBuilder(
                  valueListenable: cameraController.torchState,
                  builder: (context, state, child) {
                    return Icon(
                      state == TorchState.off 
                          ? Icons.flash_off
                          : Icons.flash_on,
                      color: appTheme.whiteA700,
                    );
                  },
                ),
                onPressed: () => cameraController.toggleTorch(),
              ),
              SizedBox(width: 20.h),
              IconButton(
                icon: ValueListenableBuilder(
                  valueListenable: cameraController.cameraFacingState,
                  builder: (context, state, child) {
                    return Icon(
                      state == CameraFacing.front 
                          ? Icons.camera_front
                          : Icons.camera_rear,
                      color: appTheme.whiteA700,
                    );
                  },
                ),
                onPressed: () => cameraController.switchCamera(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleQRCode(String qrCode) {
    // Show result in dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QR Code Scanned'),
          content: Text(qrCode),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                // Reset scanning state
                setState(() {
                  isScanning = true;
                });
              },
            ),
          ],
        );
      },
    );
  }
}