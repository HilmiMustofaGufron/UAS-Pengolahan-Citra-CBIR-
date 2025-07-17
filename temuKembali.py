import sqlite3
import cv2
import numpy as np
import matplotlib.pyplot as plt
import os
from tkinter import Tk
from tkinter.filedialog import askopenfilename

# === Ekstrak fitur dari gambar query ===
def ekstrak_fitur(image_path):
    img = cv2.imread(image_path)
    if img is None:
        raise ValueError(f"[!] Gambar tidak bisa dibaca: {image_path}")
    img = cv2.resize(img, (256, 256))
    hist = cv2.calcHist([img], [0,1,2], None, [8,8,8], [0,256,0,256,0,256])
    hist = cv2.normalize(hist, hist).flatten()
    return hist

# === Hitung kemiripan cosine ===
def cosine_similarity(a, b):
    return np.dot(a, b) / (np.linalg.norm(a) * np.linalg.norm(b))

# === Fungsi utama pencarian gambar mirip ===
def cari_gambar_mirip(query_path, dataset_path, db_path, top_k=5):
    fitur_query = ekstrak_fitur(query_path)

    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Cek apakah tabel ada
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='fitur_citra'")
    if not cursor.fetchone():
        print("[❌] Tabel 'fitur_citra' tidak ditemukan di database.")
        return

    cursor.execute("SELECT * FROM fitur_citra")
    semua_data = cursor.fetchall()
    conn.close()

    if not semua_data:
        print("[❌] Tidak ada data dalam tabel.")
        return

    hasil = []
    for row in semua_data:
        nama_file = row[0]
        fitur_db = np.array(row[1:], dtype='float32')
        similarity = cosine_similarity(fitur_query, fitur_db)
        hasil.append((nama_file, similarity))

    hasil.sort(key=lambda x: x[1], reverse=True)

    # Tampilkan hasil
    plt.figure(figsize=(12, 6))
    plt.subplot(1, top_k+1, 1)
    plt.imshow(cv2.cvtColor(cv2.imread(query_path), cv2.COLOR_BGR2RGB))
    plt.title("Query")
    plt.axis('off')

    for i in range(min(top_k, len(hasil))):
        img_path = os.path.join(dataset_path, hasil[i][0])
        img = cv2.imread(img_path)
        if img is None:
            continue
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        plt.subplot(1, top_k+1, i+2)
        plt.imshow(img)
        plt.title(f"Rank {i+1}")
        plt.axis('off')

    plt.tight_layout()
    plt.show()

# === Jalankan ===
if __name__ == "__main__":
    root = Tk()
    root.withdraw()

    file_path = askopenfilename(
        title="Pilih gambar query",
        filetypes=[("Image files", "*.jpg *.jpeg *.png *.webp *.jfif")]
    )

    if not file_path:
        print("[❌] Tidak ada file dipilih.")
    else:
        cari_gambar_mirip(
            query_path=file_path,
            dataset_path='d:/Pengolahan Citra/dataset',
            db_path='d:/Pengolahan Citra/fitur_gambar.db'
        )
