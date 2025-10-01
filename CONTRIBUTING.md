# Katkıda Bulunma Rehberi

APT Rehber projesine katkıda bulunmayı düşündüğünüz için teşekkür ederiz! Bu rehber, projeye nasıl katkıda bulunabileceğinizi açıklar.

## 🤝 Katkı Türleri

### 1. Hata Bildirimi (Bug Report)

Bir hata bulduysanız:

1. [Issues](https://github.com/alibedirhan/Youtube-scripts/issues) sayfasında benzer bir issue olup olmadığını kontrol edin
2. Yoksa yeni bir issue açın
3. Issue'da şunları belirtin:
   - Hatanın açık tanımı
   - Hatayı tekrarlama adımları
   - Beklenen davranış
   - Gerçek davranış
   - Sistem bilgileri (OS, Bash versiyon, vb.)
   - Ekran görüntüleri (varsa)

**Issue Şablonu:**
```markdown
## Hata Açıklaması
[Hatanın kısa açıklaması]

## Tekrarlama Adımları
1. ...
2. ...
3. ...

## Beklenen Davranış
[Ne olmasını bekliyordunuz]

## Gerçek Davranış
[Ne oldu]

## Sistem Bilgileri
- OS: Ubuntu 22.04
- Bash: 5.1.16
- tmux: 3.2a
```

### 2. Özellik İsteği (Feature Request)

Yeni bir özellik öneriyorsanız:

1. Issue açın ve `enhancement` etiketi ekleyin
2. Özelliğin detaylı açıklamasını yapın
3. Kullanım senaryosu belirtin
4. Mümkünse mockup veya örnek ekleyin

### 3. Kod Katkısı

#### Başlamadan Önce

1. Projeyi fork'layın
2. Local'e klonlayın
```bash
git clone https://github.com/KULLANICI_ADINIZ/Youtube-scripts.git
cd Youtube-scripts
```

3. Yeni branch oluşturun
```bash
git checkout -b feature/yeni-ozellik
# veya
git checkout -b fix/hata-duzeltme
```

#### Kod Standartları

**Bash Script Kuralları:**

- Girinti için 4 boşluk kullanın (tab değil)
- Fonksiyon isimleri `snake_case` formatında
- Değişkenler büyük harfle: `VARIABLE_NAME`
- Her fonksiyonun üstüne açıklama yazın
- `set -e` kullanarak hata kontrolü yapın
- Shellcheck ile kod kontrol edin

**Örnek:**
```bash
#!/bin/bash

# Modül gösterici fonksiyonu
# Parametre: modül numarası
show_module() {
    local module_num=$1
    
    if [[ ! -f "$module_file" ]]; then
        echo "Hata: Modül bulunamadı"
        return 1
    fi
    
    # ... devamı
}
```

**Yorum Standartları:**

```bash
# Tek satır yorum

# Çok satırlı yorum
# için her satır böyle
# başlar

# Fonksiyon açıklaması:
# Bu fonksiyon X işlemini yapar
# Parametre 1: kullanıcı adı
# Parametre 2: şifre (opsiyonel)
# Return: 0 başarılı, 1 hata
```

#### Commit Mesajları

Anlamlı commit mesajları yazın:

```bash
# İyi ✅
git commit -m "Modül 3'e disk kullanımı analizi eklendi"
git commit -m "Quiz'de progress bar hatası düzeltildi"
git commit -m "README'ye kurulum videosu eklendi"

# Kötü ❌
git commit -m "düzeltme"
git commit -m "update"
git commit -m "fix bug"
```

**Commit Formatı:**
```
[Tür] Kısa açıklama (50 karakter max)

Detaylı açıklama (isteğe bağlı)
- Neden bu değişiklik yapıldı
- Ne değişti
- Yan etkiler var mı

Fixes #123
```

**Tür örnekleri:**
- `[Özellik]` - Yeni özellik
- `[Düzeltme]` - Hata düzeltme
- `[Döküman]` - Dokümantasyon
- `[Stil]` - Kod formatı, girinti
- `[Refactor]` - Kod yapısı iyileştirme
- `[Test]` - Test ekleme/düzeltme
- `[Performans]` - Performans iyileştirme

#### Pull Request Süreci

1. Değişikliklerinizi commit'leyin
```bash
git add .
git commit -m "[Özellik] Yeni özellik açıklaması"
```

2. Fork'unuza push'layın
```bash
git push origin feature/yeni-ozellik
```

3. GitHub'da Pull Request açın

4. PR açıklamasında:
   - Ne değişti
   - Neden değişti
   - Test nasıl yapıldı
   - Ekran görüntüleri (UI değişikliği varsa)
   - İlgili issue'ları etiketleyin

**PR Şablonu:**
```markdown
## Değişiklik Türü
- [ ] Hata düzeltme
- [ ] Yeni özellik
- [ ] Dokümantasyon
- [ ] Kod iyileştirme

## Açıklama
[Değişikliğin detaylı açıklaması]

## Test Edildi mi?
- [ ] Ubuntu 22.04
- [ ] Ubuntu 20.04
- [ ] Debian 11

## Ekran Görüntüleri
[Varsa ekleyin]

## İlgili Issue
Fixes #[issue numarası]
```

### 4. Dokümantasyon

Dokümantasyon katkıları da çok değerlidir:

- README iyileştirmeleri
- Modül içeriklerinde düzeltmeler
- Yeni örnekler ekleme
- Türkçe yazım hataları düzeltme
- İngilizce çeviri

### 5. Test

Test senaryoları oluşturabilirsiniz:

```bash
# test/test_module_01.sh
#!/bin/bash

test_module_load() {
    source modules/module_01.sh
    if [[ $(type -t show_module_01) == function ]]; then
        echo "✅ Modül 1 yüklendi"
        return 0
    else
        echo "❌ Modül 1 yüklenemedi"
        return 1
    fi
}
```

## 📋 Checklist

Pull Request göndermeden önce:

- [ ] Kod shellcheck ile kontrol edildi
- [ ] En az Ubuntu 22.04'te test edildi
- [ ] Yeni özellikler dokümante edildi
- [ ] Commit mesajları anlamlı
- [ ] Branch güncel (main ile merge edildi)
- [ ] Kodu kırdığım başka bir özellik yok

## 🔍 Code Review

PR'ınız şu kriterlere göre incelenecek:

1. **Fonksiyonellik**: Kod beklendiği gibi çalışıyor mu?
2. **Kod Kalitesi**: Okunabilir ve sürdürülebilir mi?
3. **Test**: Yeterince test edilmiş mi?
4. **Dokümantasyon**: Değişiklikler açıklanmış mı?
5. **Geriye Uyumluluk**: Mevcut özellikleri bozuyor mu?

## 🎯 İyi İlk Issue'lar

Projeye yeni katılıyorsanız, şu etiketli issue'lara bakın:

- `good first issue` - Başlangıç için uygun
- `help wanted` - Yardım isteniyor
- `documentation` - Dokümantasyon
- `easy` - Kolay düzeltmeler

## 💬 İletişim

Sorularınız için:

1. [GitHub Discussions](https://github.com/alibedirhan/Youtube-scripts/discussions) kullanın
2. Veya issue açın

## 🙏 Teşekkürler

Zamanınızı ayırdığınız için teşekkür ederiz! Her katkı projeyi daha iyi hale getirir.

---

## Davranış Kuralları

Bu projede:

✅ Yapılması gerekenler:
- Saygılı olun
- Yapıcı eleştiri yapın
- Yardımsever olun
- Farklı görüşlere açık olun

❌ Yapılmaması gerekenler:
- Saldırgan dil kullanmayın
- Spam yapmayın
- Başkalarının çalışmalarını küçümsemeyin
- Konu dışı tartışmalar başlatmayın

İhlal durumunda maintainer'lar gerekli aksiyonu alır.
