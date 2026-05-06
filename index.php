<?php
session_start();
$message = "";
$success = false;

// Initialize products array in session if not exists
if (!isset($_SESSION['products'])) {
    $_SESSION['products'] = [];
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Ambil data dari form
    $nama = $_POST['nama'];
    $harga = $_POST['harga'];
    $deskripsi = $_POST['deskripsi'];

    // Validasi sederhana
    if (empty($nama) || empty($harga) || empty($deskripsi)) {
        $message = "Semua data harus diisi!";
    } else {
        // Contoh penggunaan operator dan if-else
        if ($harga <= 0) {
            $message = "Harga harus lebih dari 0!";
        } else {
            // Jika semua valid
            $success = true;
            $message = "<h2>Data Produk Berhasil Disimpan</h2>
                        Nama: " . $nama . "<br>
                        Harga: Rp " . $harga . "<br>
                        Deskripsi: " . $deskripsi . "<br>";
            
            // Add to session
            $_SESSION['products'][] = [
                'nama' => $nama,
                'harga' => $harga,
                'deskripsi' => $deskripsi
            ];
        }
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Tambah Produk</title>
</head>
<body>

<h2>Form Tambah Produk</h2>

<?php if (!empty($message)): ?>
    <p style="color: <?php echo $success ? 'green' : 'red'; ?>;">
        <?php echo $message; ?>
    </p>
<?php endif; ?>

<form action="index.php" method="POST">
    <label>Nama Produk:</label><br>
    <input type="text" name="nama" value="<?php echo isset($nama) ? htmlspecialchars($nama) : ''; ?>"><br><br>

    <label>Harga:</label><br>
    <input type="number" name="harga" value="<?php echo isset($harga) ? htmlspecialchars($harga) : ''; ?>"><br><br>

    <label>Deskripsi:</label><br>
    <textarea name="deskripsi"><?php echo isset($deskripsi) ? htmlspecialchars($deskripsi) : ''; ?></textarea><br><br>

    <button type="submit">Simpan</button>
</form>

<?php if (!empty($_SESSION['products'])): ?>
<h2>Daftar Produk</h2>
<table border="1">
    <tr>
        <th>Nama Produk</th>
        <th>Harga</th>
        <th>Deskripsi</th>
    </tr>
    <?php foreach ($_SESSION['products'] as $product): ?>
    <tr>
        <td><?php echo htmlspecialchars($product['nama']); ?></td>
        <td>Rp <?php echo htmlspecialchars($product['harga']); ?></td>
        <td><?php echo htmlspecialchars($product['deskripsi']); ?></td>
    </tr>
    <?php endforeach; ?>
</table>
<?php endif; ?>

</body>
</html>