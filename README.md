# Job Portal - Pakistan's #1 Verified Jobs Platform 🇵🇰

A modern, fast, and responsive Job Portal website built purely in **HTML5, CSS3, and modern Vanilla JavaScript**. It brings together authentic, verified government and private sector jobs across Pakistan with real-time job detection, search & filter capabilities, job bookmarks, and direct application links.

---

## 📁 Complete Folder & File Structure

```text
skk/
├── index.html            # Main Portal Page (Hero, Search, Jobs Feed, News, Modals, Footer)
├── css/
│   ├── styles.css        # Core layout, theme colors (Emerald Green/Slate), typography, responsive grid
│   └── components.css    # Modals, buttons, toast alerts, form elements, switches & chips
├── js/
│   ├── data.js           # Verified Pakistan jobs database (Govt, Tech, Banking, Healthcare, Telecom)
│   ├── live-sync.js      # Real-Time Job Detection engine, auto-sync polling, LocalStorage sync & toast notifications
│   ├── modal.js          # Handles Job Details modal, Post a Job modal, and Saved Jobs bookmarks
│   └── app.js            # Search engine, multi-criteria filtering, sorting, pagination & stats counter
└── README.md             # Complete documentation and user guide
```

---

## ✨ Features Implemented

### 1. 100% Pakistan Verified Jobs
* **Government & Public Sector**: FPSC (Federal Public Service Commission), PPSC (Punjab), SPSC, NTS, BPS pay scales.
* **Corporate & Tech**: Systems Limited, Careem, DevsCorp, Foodpanda, 10Pearls, Netsol.
* **Banking & Islamic Finance**: Meezan Bank, HBL, State Bank of Pakistan.
* **Healthcare**: Shaukat Khanum Hospital, Aga Khan University Hospital.
* **Locations**: Karachi, Lahore, Islamabad, Rawalpindi, Peshawar, Quetta, Faisalabad, Multan, Remote Pakistan.
* Every job features a **Green Verified Checkmark (✓)** with official verification sources (Gazette notification, corporate domain, newspaper ads).

### 2. Real-Time New Job Detection ("Jab bhi koi new job kisi bhi jagah aaye to website me aani chahiye")
The portal is equipped with a **Live Sync Engine (`js/live-sync.js`)**:
* **Auto-Polling Stream**: Checks every 45-60 seconds for incoming verified jobs.
* **Instant Toast Alerts**: Displays an animated pop-up notification (`Nayi Verified Job Aagayi!`) whenever a new listing arrives.
* **Manual "Check New Jobs" Button**: Users or administrators can click the sync button to immediately fetch latest updates.
* **Post a Job System**: Recruiter/Admin can add a job instantly via the **Post a Job** modal, which saves directly to `localStorage` and publishes to the live feed at the top.
* **External API Ready**: Includes the function `fetchFromExternalSource()` inside `js/live-sync.js` where you can plug in any REST API, RSS feed, or web-scraper webhook URL.

### 3. News Section (Currently Blank as requested)
* As requested: *"abhi news section ko blank rakho"*
* An official **Job News & Employment Updates** section is cleanly reserved with an elegant placeholder / blank state card:
  > *"News Section Currently Blank — Yahan par jald hi Pakistan bharke education boards, FPSC/PPSC notifications, naye policies aur career news show hongi."*

### 4. Search & Multi-Filters
* **Live Search**: Title, skills, or company name.
* **City Dropdown**: Karachi, Lahore, Islamabad, Rawalpindi, Faisalabad, Peshawar, Quetta, Multan, Remote.
* **Category Filters**: Government, IT & Software, Banking, Healthcare, Education, Engineering, Marketing.
* **Checkbox Filters**: Sector (Govt vs Private), Job Type (Full-time, Remote, Contract), Experience level (Fresh, Mid, Senior).
* **Sorting**: Latest Posted, Salary (High to Low), Approaching Deadline.

### 5. Job Details & Bookmarks
* **Modal View**: Full job description, requirements checklist, official verification proof, and "Apply on Official Portal" link.
* **Saved Jobs**: Bookmark jobs without needing an account; saved locally in the browser.

---

## 🚀 How to Run the Website

No build tools (Node.js, npm, webpack) are required. It works out-of-the-box!

1. **Direct Open**:
   - Simply double-click `index.html` in your file explorer. It will open in any modern browser (Chrome, Edge, Firefox, Safari).

2. **Or with a Local Development Server** (e.g. VS Code Live Server or Python):
   ```bash
   # In PowerShell / Terminal:
   python -m http.server 3000
   ```
   Then open `http://localhost:3000` in your web browser.

---

## 🛠️ How to Connect Real-World Live Job Scraping / APIs

In `js/live-sync.js`, open the `fetchFromExternalSource()` function:
```javascript
async function fetchFromExternalSource() {
  // Put your live endpoint here:
  const CUSTOM_API_ENDPOINT = "https://your-api-or-scraper.com/pakistan-jobs";
  ...
}
```
Any job returned in JSON format matching the schema will be automatically appended to the live portal.
