"use client";
import { useEffect, useState } from "react";

/** @param {{ endsAt: number, tone?: "light"|"dark" }} props  endsAt = epoch ms */
export default function Countdown({ endsAt, tone = "light" }) {
  const end = endsAt;
  const [now, setNow] = useState(null);
  useEffect(() => {
    const tick = () => setNow(Date.now());
    const first = setTimeout(tick, 0);
    const t = setInterval(tick, 1000);
    return () => {
      clearTimeout(first);
      clearInterval(t);
    };
  }, []);
  if (now === null || now > end) return null;
  const s = Math.floor((end - now) / 1000);
  const parts = [["Days", Math.floor(s / 86400)], ["Hrs", Math.floor((s % 86400) / 3600)], ["Min", Math.floor((s % 3600) / 60)], ["Sec", s % 60]];
  return (
    <div className="inline-flex gap-3" aria-label="Time left in the campaign">
      {parts.map(([l, v]) => (
        <div key={l} className={`min-w-16 border px-3 py-2 ${tone === "dark" ? "border-gold/60" : "border-gold/50 bg-white/60"}`}>
          <div className={`font-display text-2xl ${tone === "dark" ? "text-gold" : "text-gold-dark"}`}>{String(v).padStart(2, "0")}</div>
          <div className={`text-[10px] uppercase tracking-widest ${tone === "dark" ? "text-white/70" : "text-ink/60"}`}>{l}</div>
        </div>
      ))}
    </div>
  );
}
