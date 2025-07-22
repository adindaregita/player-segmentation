#!/bin/bash

echo "⚠️  Pastikan kamu sudah backup repo ini, karena riwayat akan diubah secara permanen."

# 1. Cek dan install git-filter-repo jika belum ada
if ! command -v git-filter-repo &> /dev/null; then
  echo "🔧 Menginstal git-filter-repo..."
  brew install git-filter-repo || {
    echo "❌ Gagal menginstal git-filter-repo. Install manual lalu jalankan ulang skrip ini."; exit 1;
  }
fi

# 2. Bersihkan semua file besar dari riwayat
echo "🧹 Menghapus file besar dari riwayat Git..."
git filter-repo --path Experiment/topic_model.pkl --invert-paths
git filter-repo --path Experiment/topic_model_with_labels.pkl --invert-paths
git filter-repo --path Experiment/topic_model_labeled.pkl --invert-paths

# 3. Tambahkan semua ke .gitignore
echo "📄 Memperbarui .gitignore..."
echo "Experiment/topic_model.pkl" >> .gitignore
echo "Experiment/topic_model_with_labels.pkl" >> .gitignore
echo "Experiment/topic_model_labeled.pkl" >> .gitignore

# 4. Commit perubahan
git add .gitignore
git commit -m "Ignore and remove large model files from history"

# 5. Push ulang secara paksa
echo "🚀 Melakukan force push ke remote..."
git push origin main --force

echo "✅ Selesai! Ketiga file besar dihapus dan repo sudah bersih."
