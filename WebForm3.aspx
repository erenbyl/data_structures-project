<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="utf-8" />
    <title>Akıllı İlaç ve Nöbetçi Eczane Sistemi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body { font-family: Arial, sans-serif; background: #f4f7fc; padding: 20px; }
        .section { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px #ddd; margin-bottom: 20px; }
        h3 { color: #333; font-size: 1.5rem; }
        .hidden { display: none; }
        .btn-custom { width: 100%; max-width: 300px; padding: 12px; font-size: 1rem; }
        .alert-custom { font-size: 1rem; }
    </style>
</head>
<body>
    <div class="container">
        <div class="section">
            <h3>👥 Vatandaş - İlaç Arama</h3>
            <input type="text" id="searchMedicine" class="form-control mb-3" placeholder="İlaç adı giriniz...">
            <button type="button" class="btn btn-primary btn-custom" onclick="searchMedicine()">Ara</button>
            <p id="searchResult" class="mt-3"></p>
        </div>

        <div class="section">
            <h3>📍 Nöbetçi Eczaneler</h3>
            <ul id="dutyPharmacies" class="list-group"></ul>
        </div>

        <div class="section">
            <h3>💼 Eczacı Girişi</h3>
            <input type="text" id="pharmacyName" class="form-control mb-2" placeholder="Eczane adı giriniz">
            <input type="password" id="pharmacistPass" class="form-control mb-2" placeholder="Şifre giriniz">
            <button type="button" class="btn btn-success btn-custom" onclick="login()">Giriş Yap</button>
            <p id="loginStatus" class="mt-3"></p>
        </div>

        <div class="section hidden" id="pharmacistPanel">
            <h3>📦 Stok Güncelleme</h3>
            <input type="text" id="medicineName" class="form-control mb-2" placeholder="İlaç adı">
            <input type="number" id="medicineCount" class="form-control mb-2" placeholder="Stok (+ ekle, - çıkar)">
            <button type="button" class="btn btn-warning btn-custom" onclick="updateStock()">Stok Güncelle</button>
            <p id="updateStatus" class="mt-3"></p>

            <h3 class="mt-4">🌙 Nöbetçi Eczane Yönetimi</h3>
            <button type="button" class="btn btn-info btn-custom" onclick="toggleDuty()">Nöbetçi Durumunu Değiştir</button>
            <p id="dutyStatus" class="mt-3"></p>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Hash table for pharmacy stocks: Map<pharmacyName, Map<medicineName, stockCount>>
        const pharmacyStocks = new Map();
        // Hash table for duty pharmacies: Set<pharmacyName>
        const dutyPharmacies = new Set();
        const pharmacistPassword = "eczane123";
        let currentPharmacy = null;

        function login() {
            const name = document.getElementById("pharmacyName").value.trim().toLowerCase();
            const pass = document.getElementById("pharmacistPass").value;
            const status = document.getElementById("loginStatus");

            if (!name || pass !== pharmacistPassword) {
                status.innerHTML = '<div class="alert alert-danger alert-custom">❌ Hatalı eczane adı veya şifre.</div>';
                return;
            }

            currentPharmacy = name;
            if (!pharmacyStocks.has(name)) {
                pharmacyStocks.set(name, new Map());
            }

            document.getElementById("pharmacistPanel").classList.remove("hidden");
            status.innerHTML = `<div class="alert alert-success alert-custom">✔ Hoş geldiniz, ${name}!</div>`;
            updateDutyList();
        }

        function updateStock() {
            if (!currentPharmacy) {
                document.getElementById("updateStatus").innerHTML = '<div class="alert alert-danger alert-custom">❌ Lütfen önce giriş yapın.</div>';
                return;
            }

            const medicine = document.getElementById("medicineName").value.trim().toLowerCase();
            const count = parseInt(document.getElementById("medicineCount").value);
            const status = document.getElementById("updateStatus");

            if (!medicine || isNaN(count)) {
                status.innerHTML = '<div class="alert alert-warning alert-custom">⚠ Lütfen ilaç adı ve geçerli bir sayı girin.</div>';
                return;
            }

            const stockMap = pharmacyStocks.get(currentPharmacy);
            const currentStock = stockMap.get(medicine) || 0;
            const newStock = currentStock + count;

            if (newStock < 0) {
                status.innerHTML = '<div class="alert alert-danger alert-custom">❌ Stok negatife düşemez.</div>';
                return;
            }

            if (newStock === 0) {
                stockMap.delete(medicine);
            } else {
                stockMap.set(medicine, newStock);
            }

            status.innerHTML = `<div class="alert alert-success alert-custom">✔ "${medicine}" stoğu: ${newStock} adet.</div>`;
        }

        function searchMedicine() {
            const medicine = document.getElementById("searchMedicine").value.trim().toLowerCase();
            const result = document.getElementById("searchResult");

            if (!medicine) {
                result.innerHTML = '<div class="alert alert-warning alert-custom">⚠ Lütfen bir ilaç adı girin.</div>';
                return;
            }

            let found = false;
            let output = `🔍 "${medicine}" için sonuçlar:<ul class="list-group mt-2">`;

            for (const [pharmacy, stockMap] of pharmacyStocks) {
                const stock = stockMap.get(medicine);
                if (stock && stock > 0) {
                    output += `<li class="list-group-item"><strong>${pharmacy}</strong>: ${stock} adet</li>`;
                    found = true;
                }
            }

            output += "</ul>";
            result.innerHTML = found ? output : `<div class="alert alert-info alert-custom">"${medicine}" hiçbir eczanede bulunamadı.</div>`;
        }

        function toggleDuty() {
            if (!currentPharmacy) {
                document.getElementById("dutyStatus").innerHTML = '<div class="alert alert-danger alert-custom">❌ Lütfen önce giriş yapın.</div>';
                return;
            }

            const status = document.getElementById("dutyStatus");
            if (dutyPharmacies.has(currentPharmacy)) {
                dutyPharmacies.delete(currentPharmacy);
                status.innerHTML = '<div class="alert alert-warning alert-custom">⚠ Nöbetçi listesinden çıkarıldı.</div>';
            } else {
                dutyPharmacies.add(currentPharmacy);
                status.innerHTML = '<div class="alert alert-success alert-custom">✔ Nöbetçi eczanelere eklendi.</div>';
            }

            updateDutyList();
        }

        function updateDutyList() {
            const list = document.getElementById("dutyPharmacies");
            list.innerHTML = "";
            for (const pharmacy of dutyPharmacies) {
                const li = document.createElement("li");
                li.classList.add("list-group-item");
                li.textContent = pharmacy;
                list.appendChild(li);
            }
        }
    </script>
</body>
</html>