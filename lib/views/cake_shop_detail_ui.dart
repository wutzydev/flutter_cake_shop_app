import 'package:flutter/material.dart';
import 'package:flutter_cake_shop_app/Model/cake_shop.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CakeShopDetailUi extends StatefulWidget {
  //สร้างตัวแปรเพื่อรับข้อมูลที่ส่งมาจากอีกหน้าหนึ่ง
  CakeShop? cakeShop;

  //เอาตัวแปรที่สร้างมารับข้อมูลที่ส่งมาจากอีกหน้าหนึ่ง
  CakeShopDetailUi({super.key, this.cakeShop});

  @override
  State<CakeShopDetailUi> createState() => _CakeShopDetailUiState();
}

class _CakeShopDetailUiState extends State<CakeShopDetailUi> {
  // ฟังก์ชันสำหรับเปิดเว็บไซต์และ Facebook
  Future<void> _launchInBrowser(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('ไม่สามารถเปิดลิงก์ได้: $urlString');
    }
  }

  // ฟังก์ชันสำหรับกดโทรออก
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(launchUri)) {
      debugPrint('ไม่สามารถโทรออกได้');
    }
  }

  @override
  Widget build(BuildContext context) {
    // แปลงค่าพิกัดแผนที่ (เพิ่ม ! เพื่อยืนยันว่ามีข้อมูลแน่นอน ป้องกัน Error)
    final double lat = double.parse(widget.cakeShop!.latitude!);
    final double lng = double.parse(widget.cakeShop!.longitude!);

    return Scaffold(
      //ส่วนของ AppBar
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          widget.cakeShop!.name!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      //ส่วนของ body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40,
            bottom: 50,
            left: 35,
            right: 35,
          ),
          child: Center(
            child: Column(
              children: [
                //ส่วนของรูปภาพรูปที่ 1
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    widget.cakeShop!.image1!,
                    width: 200, // ปรับให้กว้างขึ้นตามรูปตัวแบบ
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                //ส่วนของรูปภาพรูปที่ 2 และรูปที่ 3
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        widget.cakeShop!.image2!,
                        width: 120,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        widget.cakeShop!.image3!,
                        width: 120,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                //ส่วนของชื่อร้าน
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ชื่อร้าน 🏪',
                    style: TextStyle(
                      fontSize: 14, // ปรับขนาดฟอนต์ให้เหมือนแบบ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.cakeShop!.name!,
                  ),
                ),
                const SizedBox(height: 20),

                //ส่วนของเวลาเปิดปิดร้าน
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'เวลาเปิดปิด ⏰',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.cakeShop!.openCloseTime!,
                  ),
                ),
                const SizedBox(height: 20),

                //ส่วนของรายละเอียดร้าน
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'รายละเอียดของร้าน 🍵', // เปลี่ยน Emoji ตามรูป
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.cakeShop!.description!,
                  ),
                ),
                const SizedBox(height: 20),

                //ส่วนที่่อยู่ของร้าน
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ที่อยู่ของร้าน 🚩', // เปลี่ยน Emoji ตามรูป
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.cakeShop!.address!,
                  ),
                ),
                const SizedBox(height: 20),

                // ==========================================
                // ส่วนที่เพิ่มเข้ามาใหม่ให้เหมือนหน้าจอเป๊ะๆ
                // ==========================================

                // 1. ปุ่มโทรศัพท์สีเขียว
                ElevatedButton.icon(
                  onPressed: () {
                    _makePhoneCall(widget.cakeShop!.phone!);
                  },
                  icon: const Icon(Icons.phone, color: Colors.black87),
                  label: Text(
                    widget.cakeShop!.phone!,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF4CAF50), // สีเขียวเหมือนในแบบ
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 2. ลิงก์เว็บไซต์
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading:
                      const Icon(Icons.language, color: Colors.amber, size: 30),
                  title: Text(
                    widget.cakeShop!.website!,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: const Icon(Icons.link, color: Colors.black54),
                  onTap: () {
                    _launchInBrowser(widget.cakeShop!.website!);
                  },
                ),

                // 3. ลิงก์ Facebook
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading:
                      const Icon(Icons.facebook, color: Colors.blue, size: 30),
                  title: Text(
                    widget.cakeShop!.facebook!,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: const Icon(Icons.link, color: Colors.black54),
                  onTap: () {
                    _launchInBrowser(widget.cakeShop!.facebook!);
                  },
                ),
                const SizedBox(height: 20),

                // 4. กรอบแผนที่ (Flutter Map)
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.amber, width: 2), // ขอบสีเหลืองตามรูป
                  ),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(lat, lng), // จุดศูนย์กลางแผนที่
                      initialZoom: 15.0, // ระดับการซูม
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.google.com/vt/lyrs=m,h&x={x}&y={y}&z={z}&hl=ar-MA&gl=MA',
                        subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
                        userAgentPackageName: 'com.example.app',
                      ),
                      RichAttributionWidget(
                        attributions: [
                          TextSourceAttribution(
                            'OpenStreetMap contributors',
                            onTap: () {
                              launchUrl(
                                Uri.parse(
                                    'https://openstreetmap.org/copyright'),
                              );
                            },
                          ),
                        ],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(
                              double.parse(widget.cakeShop!.latitude!),
                              double.parse(widget.cakeShop!.longitude!),
                            ),
                            child: InkWell(
                              onTap: () {
                                //กดแล้วเปิดไปแผนที่
                                _launchInBrowser(Uri.parse(
                                        'https://www.google.com/maps/search/?api=1&query=${widget.cakeShop!.latitude},${widget.cakeShop!.longitude}')
                                    .toString());
                              },
                              child: Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
