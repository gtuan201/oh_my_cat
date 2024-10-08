import '../../gen/assets.gen.dart';

class SelfCare {
  final int id;
  final AssetGenImage image;
  final String pdfUrl;
  final String title;

  SelfCare({
    required this.id,
    required this.image,
    required this.pdfUrl,
    required this.title,
  });
}

List<SelfCare> createSelfCareList() {
  List<String> listSelfCare = [
    "https://www.johas.go.jp/Portals/0/data0/sanpo/pdf/vietnamese_selfcare.pdf",
    "https://moet.gov.vn/content/vanban/Lists/VBDH/Attachments/3584/hoc-phan-5full16012024-3173527.pdf",
    "https://www.johas.go.jp/Portals/0/data0/sanpo/pdf/vietnamese_mental%20health.pdf",
    "https://swsphn.com.au/wp-content/uploads/2022/06/Live_Well_Guide_wb__Vietnamese_LR.pdf",
    "https://moet.gov.vn/content/vanban/Lists/VBDH/Attachments/3533/tai-lieu-truyen-thong-ve-sktt-hspt.pdf",
    "https://www.unicef.org/vietnam/media/1481/file/Training%20resources%20on%20social%20work.pdf",
    "https://assets.kpmg.com/content/dam/kpmg/vn/pdf/publication/2020/8/VI-The-Power-of-Self-Care-in-Achieving-Health-for-All.pdf",
    "https://static1.squarespace.com/static/5efd6da647cafa28a42055fc/t/6271f80f98e6b0586acd4701/1651636304573/Cam+Nang+Cham+Soc+Suc+Khoe+Tinh+Than+Ca+Nhan.pdf",
    "http://handbook.uet.vnu.edu.vn/C%E1%BA%A9m%20nang%20s%E1%BB%A9c%20kh%E1%BB%8Fe%20tinh%20th%E1%BA%A7n%20cho%20SV%20(1).pdf",
    "https://nwmphn.org.au/wp-content/uploads/2021/03/NWMPHN_Mental-Health_Community-Flyer_Vietnamese-Interactive.pdf",
    "https://nls.hcmuaf.edu.vn/data/file/NLS/tu%20van%20tam%20ly/S%E1%BB%95%20tay%20ch%C4%83m%20s%C3%B3c%20s%E1%BB%A9c%20kh%E1%BB%8Fe%20t%C3%A2m%20th%E1%BA%A7n%20cho%20sinh%20vi%C3%AAn.pdf",
    "https://www.cms.gov/marketplace/technical-assistance-resources/c2c-put-your-health-first-vietnamese.pdf",
    "https://mindpeacecincinnati.com/wp-content/uploads/SelfCareReportR13.pdf",
    "https://education.vnu.edu.vn/files/cam%20nang%20tu%20van%20huong%20nghiep/Cam%20nang%20SKTT%20cho%20SV%20(10)%20final.pdf",
    "https://www.care2caregivers.com/wp-content/uploads/2019/12/Individual-Self-Care-Booklet-English.pdf",
    "https://storage-vnportal.vnpt.vn/lci-ubnd-responsive/7038/Filevanban/nguoi-cao-tuoi-2023-in.pdf",
    "https://www.unicef.org/vietnam/media/9771/file/B%E1%BA%A3n%20t%C3%B3m%20t%E1%BA%AFt%20nghi%C3%AAn%20c%E1%BB%A9u%20v%E1%BB%81%20s%E1%BB%A9c%20kh%E1%BB%8Fe%20t%C3%A2m%20th%E1%BA%A7n%20v%C3%A0%20s%E1%BB%B1%20ph%C3%A1t%20tri%E1%BB%83n%20to%C3%A0n%20di%E1%BB%87n%20c%E1%BB%A7a%20thanh%20thi%E1%BA%BFu%20ni%C3%AAn%20t%E1%BA%A1i%20Vi%E1%BB%87t%20Nam.pdf",
    "https://rtccd.org.vn/wp-content/uploads/2015/11/WHO-MOLISA_System-Analysis_Report_VIE-final_21Mar2012.pdf"
  ];

  List<AssetGenImage> images = [
    Assets.image.selfcarePoster1,
    Assets.image.selfcarePoster2,
    Assets.image.selfcarePoster3,
    Assets.image.selfcarePoster4,
    Assets.image.selfcarePoster5,
    Assets.image.selfcarePoster6,
    Assets.image.selfcarePoster7,
    Assets.image.selfcarePoster8,
    Assets.image.selfcarePoster9,
    Assets.image.selfcarePoster10,
    Assets.image.selfcarePoster11,
    Assets.image.selfcarePoster12,
    Assets.image.selfcarePoster13,
    Assets.image.selfcarePoster14,
    Assets.image.selfcarePoster15,
    Assets.image.selfcarePoster16,
    Assets.image.selfcarePoster17,
    Assets.image.selfcarePoster18,
  ];

  List<String> titles = [
    "Sức Khoẻ Tâm Lý: Điểm Nhấn",
    "Chăm Sóc Tâm Hồn: Cân Bằng Sống",
    "Bảo Vệ Tâm Lý Hằng Ngày",
    "Kết Nối Tâm Hồn Với Cuộc Sống",
    "Giải Tỏa Stress Hiệu Quả",
    "Hành Trình Hồi Phục Tâm Lý",
    "Tăng Cường Sức Khoẻ Tinh Thần",
    "Tư Duy Tích Cực: Chìa Khóa Sức Khoẻ Tâm Hồn",
    "Bảo Vệ Tâm Hồn Trước Biến Cố",
    "Tháo Gỡ Bế Tắc Tâm Lý",
    "Sống Vui Vẻ: Năng Lượng Tâm Hồn",
    "Chăm Sóc Bản Thân Tâm Hồn",
    "Cân Bằng Tâm Hồn Trong Xã Hội",
    "Đắm Mình Trong Niềm Vui",
    "Cải Thiện Sức Khoẻ Tâm Lý",
    "Khám Phá Bản Thân Tâm Lý",
    "Đánh Thức Niềm Tin Tâm Hồn",
    "Thiết Lập Mục Tiêu Sống"
  ];

  List<SelfCare> selfCareList = [];

  for (int i = 0; i < listSelfCare.length; i++) {
    selfCareList.add(
        SelfCare(
          id: i + 1,
          image: images[i],
          pdfUrl: listSelfCare[i],
          title: titles[i],
        )
    );
  }

  return selfCareList;
}