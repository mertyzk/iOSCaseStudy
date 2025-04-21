//
//  FavoritesVM.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import Foundation

final class FavoritesViewModel {
    
    // MARK: YAPILAN İŞLEM VE ÇÖZÜM NEDİR?
    /// Aynı anda hem okuma hem yazma işlemleri olursa oluşabilecek çökme veya tutarsızlık => syncQueue ile okuma/yazmayı kontrol altına alındı.
    /// Performans kaybı olur mu? => Hayır, çünkü .concurrent queue sayesinde birden fazla okuma işlemi aynı anda yapılabiliyor.
    /// Yazma işlemi güvenli mi? => Evet, .barrier ile sadece tek yazma oluyor.
    
    // MARK: - Properties
    private var favoriteHandler: FavoriteHandler
    
    /*var favoriteProducts: [Product] = [] // KALDIRILDI. HEM GET HEM SET EDİLMESİNİN ÖNÜNE GEÇİLEREK UI TUTARSIZLIKLARI ENGELLENDİ. _favoriteProducts tanımlandı.
        * ---------------------------------------------------------------------------------------------------------------------------------------------------------
        - favoriteProducts hem yazılıyor (getFavoritesFromLocalDB) hem de VC tarafında okunuyor.
        - Bu senaryoda, eğer bu ViewModel farklı thread’ler üzerinden erişilecek şekilde kullanılacaksa, favoriteProducts'a yapılan eşzamanlı okuma/yazma işlemleri veri tutarsızlığına (race condition) yol açabilir.
        - UI Sorunlarına yol açabilir.
        - İşte burada DispatchQueue ile .barrier kullanacağız. Böylece;
        - Yazma işlemleri (set) .barrier ile korunsun & Okuma işlemleri (get) thread-safe olsun istiyoruz.
    */
    
    private var _favoriteProducts: [Product] = []
    
    private let syncQueue = DispatchQueue(label: "com.yourapp.favorites.syncQueue", attributes: .concurrent)
    /// Eğer doğrudan barrier kullanmak istiyorsak, DispatchQueue'un custom ve concurrent olması şarttır. Çünkü barrier yalnızca concurrent queue'de işe yarar.
    /// Concurrrent queue birden fazla işi aynı anda çalıştırır.
    /// .barrier ise diğer tüm görevler bitmeden kendi görevine geçilmesini sağlar. Kendisinden sonra gelen görevleri bloklar.
    /// Böylece eş zamanlı okuma / tekil yazma gibi thread-safe yapı kurabiliriz.
    
    // Güvenli getter
     var favoriteProducts: [Product] {
         var products: [Product] = []
         syncQueue.sync { /// syncQueue.sync bloğu, Başka bir yazma işlemi varsa onu bekler. Aynı anda başka okumalarla birlikte çalışabilir.
             /// KISACA .SYNC ŞUDUR => “Bu işi sıraya koy ve tamamlanmadan devam etme."
             products = _favoriteProducts
             /// _favoriteProducts dizisini güvenli bir şekilde okuyoruz ve aynı anda başka bir işlem tarafından değiştirilmeyecek (yazılmayacak).
         }
         return products
     }
    
    // MARK: _favoriteProducts’a aynı anda hem okuma hem yazma olmasın istiyoruz.
    /// Okumalar paralel olabilir fakat yazma işlemleri tek başına olmalıdır.
    /// _favoriteProducts: Asıl veriyi burada tutuyorsun. Dışarıdan kimse doğrudan erişemez.

    var favoritesChanged: ((DBErrors?) -> Void)?
    
    // MARK: - Initializer
    init(favoriteHandler: FavoriteHandler) {
        self.favoriteHandler = favoriteHandler
    }
    
    
    // MARK: - Helper Functions
    func getFavoritesFromLocalDB() {
        favoriteHandler.fetchProductsFromLocalDB { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let favorites):
                self.syncQueue.async(flags: .barrier) {
                    self._favoriteProducts = favorites
                    DispatchQueue.main.async {
                        self.favoritesChanged?(nil)
                    }
                    /// .barrier sayesinde bu blok;
                    /// Queue'daki tüm önceki işlemler bitmeden başlamaz.
                    /// Kendi çalışırken başka hiç bir iş (okuma bile) başlamaz.
                    /// Bittikten sonra diğer işler sırayla devam eder.
                }
            case .failure(let failure):
                favoritesChanged?(failure)
            }
        }
    }
    
    
    func deleteProductFromLocalDB(for product: Product) {
        favoriteHandler.deleteFromLocalDB(product: product) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                getFavoritesFromLocalDB()
                NotificationCenter.default.post(name: .favUpdated, object: nil)
            case .failure(let error):
                favoritesChanged?(error)
            }
        }
    }
}
