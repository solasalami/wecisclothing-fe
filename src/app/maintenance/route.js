import { DEFAULT_SETTINGS } from "@/lib/defaults";

export const dynamic = "force-dynamic";

// Served when the database is unreachable. It deliberately never queries the database
// for content, and answers HTTP 503 + Retry-After so search engines treat the outage as temporary.

const esc = (s) => String(s).replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" })[c]);
const digits = (s) => String(s).replace(/\D/g, "");

function safeFrom(value) {
  return value && value.startsWith("/") && !value.startsWith("//") && !value.startsWith("/maintenance") ? value : "/";
}

export async function GET(request) {
  const from = safeFrom(new URL(request.url).searchParams.get("from"));

  // No server-side bounce back here, even if the database answers now: if the page that sent
  // the visitor here still fails, page -> maintenance -> page would loop until the browser
  // gives up with "too many redirects". The script below returns them after a health check,
  // and backs off if the last return didn't stick.

  const { store } = DEFAULT_SETTINGS;
  const wa = `https://wa.me/${digits(store.whatsapp)}?text=${encodeURIComponent("Hello Wecis Clothing, I'd like to place an order.")}`;
  const tel = `tel:+${digits(store.phone)}`;

  const html = `<!DOCTYPE html>
<html lang="en-NG">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex">
<title>We'll be right back | Wecis Clothing</title>
<link rel="icon" href="/icon.png">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=EB+Garamond:wght@400;500&family=Jost:wght@400;500;600&display=swap" rel="stylesheet">
<style>
  *{box-sizing:border-box;margin:0}
  body{min-height:100vh;display:flex;align-items:center;justify-content:center;padding:24px;background:#f6efd9;color:#262626;font-family:Jost,system-ui,sans-serif}
  .card{position:relative;max-width:560px;width:100%;background:#fff;border:1px solid rgba(201,162,39,.5);padding:48px 32px;text-align:center}
  .card:before{content:"";position:absolute;inset:8px;border:1px solid rgba(201,162,39,.3);pointer-events:none}
  img{width:88px;height:auto;border-radius:50%}
  .eyebrow{margin-top:20px;font-size:11px;letter-spacing:.3em;text-transform:uppercase;color:#9c7a12}
  h1{margin-top:10px;font-family:"EB Garamond",Georgia,serif;font-weight:400;font-size:40px;line-height:1.15}
  p{margin-top:14px;line-height:1.6;color:rgba(38,38,38,.75)}
  .actions{margin-top:28px;display:flex;flex-wrap:wrap;gap:10px;justify-content:center}
  a.btn,button.btn{display:inline-flex;align-items:center;gap:8px;padding:12px 22px;font:500 12px/1 Jost,system-ui,sans-serif;letter-spacing:.18em;text-transform:uppercase;text-decoration:none;border:0;cursor:pointer}
  .gold{background:#c9a227;color:#262626}.gold:hover{background:#9c7a12;color:#fff}
  .wa{background:#25d366;color:#fff}
  .outline{background:#fff;color:#262626;box-shadow:inset 0 0 0 1px #c9a227}
  .status{margin-top:22px;font-size:12px;color:rgba(38,38,38,.55)}
  .dot{display:inline-block;width:8px;height:8px;border-radius:50%;background:#c9a227;margin-right:6px;animation:pulse 1.6s infinite}
  @keyframes pulse{50%{opacity:.25}}
  .showrooms{margin-top:28px;padding-top:20px;border-top:1px solid #eee;font-size:13px;color:rgba(38,38,38,.7);line-height:1.7}
</style>
</head>
<body>
  <main class="card">
    <img src="/logo.png" alt="Wecis Clothing">
    <p class="eyebrow">Under maintenance</p>
    <h1>We'll be right back</h1>
    <p>Our online store is briefly unavailable while we carry out maintenance. Your bag is saved on this device. You can still order by WhatsApp or phone, or visit our showrooms.</p>
    <div class="actions">
      <a class="btn wa" href="${esc(wa)}" target="_blank" rel="noopener noreferrer">WhatsApp ${esc(store.whatsapp)}</a>
      <a class="btn outline" href="${esc(tel)}">Call ${esc(store.phone)}</a>
    </div>
    <div class="actions">
      <a class="btn gold" href="${esc(from)}" id="retry">Try again</a>
    </div>
    <p class="status" id="status"><span class="dot"></span>Checking automatically. You'll be taken back as soon as we're online.</p>
    <div class="showrooms">
      Ikeja Showroom: 3 Adeniyi Jones Avenue, Ikeja, Lagos<br>
      Victoria Island Showroom: 49 Adeola Odeku Street, Victoria Island, Lagos
    </div>
  </main>
<script>
(function(){
  var from = ${JSON.stringify(from)};
  var KEY = 'wecisMaintenanceReturn';
  function lastReturn(){ try { return Number(sessionStorage.getItem(KEY)) || 0; } catch(e){ return 0; } }
  function check(){
    fetch('/api/health', {cache:'no-store'}).then(function(r){
      if(!r.ok) return;
      try { sessionStorage.setItem(KEY, String(Date.now())); } catch(e){}
      location.replace(from);
    }).catch(function(){});
  }
  // Quick first check (stale tab or bookmark), but wait longer if we were sent back here within
  // the last minute, so a page that keeps failing can't bounce in a tight loop.
  setTimeout(check, Date.now() - lastReturn() < 60000 ? 30000 : 2000);
  setInterval(check, 30000);
})();
</script>
</body>
</html>`;

  return new Response(html, {
    status: 503,
    headers: {
      "Content-Type": "text/html; charset=utf-8",
      "Retry-After": "120",
      "Cache-Control": "no-store",
    },
  });
}
