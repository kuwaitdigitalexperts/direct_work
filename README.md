# Direct Work Kuwait (دايركت وورك الكويت)

Official repository for **Direct Work Kuwait** — the complete recruitment platform for Kuwait & GCC markets.

---

## 📁 Repository Structure

```
direct_work/
├── web/                  # Laravel 11 Employer Portal & Web Platform
│   ├── app/              # Controllers, Models, Services (DatabaseService)
│   ├── resources/views/  # Employer Dashboard, Portals, Sectors, Applicants (Royal Blue Theme)
│   ├── storage/app/      # JSON Database & Sector definitions
│   └── public/           # Assets, Logos, and Web Entry Point
├── mobile/               # Flutter Multi-Platform Mobile App (iOS / Android)
│   ├── lib/              # Riverpod State Management, Localization, Screens
│   └── assets/           # Sector Banners, Fonts, Logos
├── backend/              # Standalone lightweight PHP API endpoint
│   ├── index.php         # REST API for mobile app sync
│   └── storage/          # Shared database storage
├── .cpanel.yml           # Automated deployment script for Namecheap cPanel Git
└── README.md             # Project documentation & deployment guide
```

---

## 🚀 Hosting Guide: Deploying to Namecheap via GitHub

No more manual ZIP uploading! With GitHub Git Deployment on Namecheap, you can update your live site in seconds.

### Method 1: Using Namecheap cPanel "Git Version Control" (Recommended - No Terminal Needed)

1. **Log in to Namecheap cPanel**.
2. Under the **Files** section, click **Git™ Version Control**.
3. Click the blue **Create** button.
4. Fill in the repository details:
   - **Clone URL**: `https://github.com/kuwaitdigitalexperts/direct_work.git`
     *(If private, generate an SSH key in cPanel > SSH Access and add it to your GitHub Deploy Keys)*
   - **Repository Path**: `repositories/direct_work` (or `/home/YOUR_CPANEL_USER/repositories/direct_work`)
   - **Repository Name**: `direct_work`
5. Click **Create**. cPanel will clone the repository from GitHub.
6. **Set Document Root**:
   - In cPanel, go to **Domains** (or **Subdomains**).
   - Set the document root for your domain (e.g. `directjobs.app`) to:
     `/home/YOUR_CPANEL_USER/repositories/direct_work/web/public`
7. **Future Updates (One-Click Pull)**:
   - When you push new code to GitHub, open cPanel > **Git™ Version Control**.
   - Click **Manage** next to `direct_work`.
   - Go to the **Pull or Deploy** tab and click **Update from Remote**. Done!

---

### Method 2: Deploying via Namecheap cPanel Terminal / SSH

1. In cPanel, open **Terminal** (under the Advanced section).
2. Clone the repository:
   ```bash
   cd ~
   git clone https://github.com/kuwaitdigitalexperts/direct_work.git
   ```
3. Set up the web environment:
   ```bash
   cd ~/direct_work/web
   cp .env.example .env
   composer install --no-dev --optimize-autoloader
   php artisan key:generate
   chmod -R 775 storage bootstrap/cache
   ```
4. **Symlink to public_html** (if your main domain uses `public_html`):
   ```bash
   mv ~/public_html ~/public_html_backup
   ln -s ~/direct_work/web/public ~/public_html
   ```
5. **Whenever you push new changes, simply run**:
   ```bash
   cd ~/direct_work
   git pull origin main
   ```

---

## 💾 Database Synchronization (`direct_jobs_database.json`)

The platform uses a persistent, high-performance JSON database shared between the web portal and mobile app:
- Path: `web/storage/app/direct_jobs_database.json` and `backend/storage/direct_jobs_database.json`
- All employers, candidates, CVs, jobs, and settings are stored in this file.
- The latest database is committed to this repository. When you `git pull` on Namecheap, the database updates automatically.
- To set a custom database path on Namecheap, set `DIRECT_JOBS_DB_PATH` in `web/.env`:
  ```env
  DIRECT_JOBS_DB_PATH=/home/YOUR_CPANEL_USER/repositories/direct_work/backend/storage/direct_jobs_database.json
  ```

---

## 📞 Support & Inquiries
- Official Support WhatsApp: `+96566707126` (`https://wa.me/96566707126`)
- Phone Hotline: `+965 6670 7126`
- Official Email: `directkwjobs@gmail.com`
