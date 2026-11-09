// Small inline SVG icons (no icon-font dependency).
const base = { width: 22, height: 22, viewBox: "0 0 24 24", fill: "none", stroke: "currentColor", strokeWidth: 1.6, strokeLinecap: "round", strokeLinejoin: "round" };

export const BagIcon = (p) => (<svg {...base} {...p}><path d="M6 7h12l-1 13H7L6 7z" /><path d="M9 7a3 3 0 0 1 6 0" /></svg>);
export const UserIcon = (p) => (<svg {...base} {...p}><circle cx="12" cy="8" r="4" /><path d="M4 21c1.5-4 4.5-6 8-6s6.5 2 8 6" /></svg>);
export const MenuIcon = (p) => (<svg {...base} {...p}><path d="M3 6h18M3 12h18M3 18h18" /></svg>);
export const CloseIcon = (p) => (<svg {...base} {...p}><path d="M6 6l12 12M18 6L6 18" /></svg>);
export const SearchIcon = (p) => (<svg {...base} {...p}><circle cx="11" cy="11" r="7" /><path d="M20 20l-3.5-3.5" /></svg>);
export const PhoneIcon = (p) => (<svg {...base} {...p}><path d="M5 4h4l2 5-2.5 1.5a11 11 0 0 0 5 5L15 13l5 2v4a2 2 0 0 1-2 2A16 16 0 0 1 3 6a2 2 0 0 1 2-2" /></svg>);
export const PinIcon = (p) => (<svg {...base} {...p}><path d="M12 22s7-6.5 7-12a7 7 0 0 0-14 0c0 5.5 7 12 7 12z" /><circle cx="12" cy="10" r="2.5" /></svg>);
export const MailIcon = (p) => (<svg {...base} {...p}><rect x="3" y="5" width="18" height="14" rx="1" /><path d="M3 7l9 6 9-6" /></svg>);
export const ClockIcon = (p) => (<svg {...base} {...p}><circle cx="12" cy="12" r="9" /><path d="M12 7v5l3 2" /></svg>);
export const WhatsAppIcon = (p) => (
  <svg width="24" height="24" viewBox="0 0 32 32" fill="currentColor" aria-hidden="true" {...p}>
    <path d="M16.04 3C9.4 3 4 8.36 4 14.97c0 2.11.56 4.17 1.62 5.99L4 29l8.26-1.6a12.1 12.1 0 0 0 3.78.6C22.68 28 28 22.64 28 16.03 28 9.42 22.68 3 16.04 3zm0 22.1c-1.2 0-2.37-.2-3.48-.6l-.25-.09-4.9.95.98-4.73-.16-.26a9.96 9.96 0 0 1-1.5-5.4c0-5.5 4.67-10 9.3-10 5.3 0 9.85 4.5 9.85 10.03 0 5.53-4.5 10.1-9.84 10.1zm5.42-7.48c-.3-.15-1.75-.86-2.02-.96-.27-.1-.47-.15-.67.15-.2.3-.77.96-.94 1.16-.17.2-.35.22-.65.07-.3-.15-1.26-.46-2.4-1.48a9 9 0 0 1-1.66-2.07c-.17-.3 0-.46.13-.6.13-.14.3-.35.45-.52.15-.17.2-.3.3-.5.1-.2.05-.37-.02-.52-.08-.15-.67-1.62-.92-2.22-.24-.58-.49-.5-.67-.51h-.57c-.2 0-.52.07-.8.37-.27.3-1.04 1.02-1.04 2.48 0 1.46 1.07 2.88 1.22 3.08.15.2 2.1 3.2 5.08 4.49.71.3 1.27.49 1.7.63.72.23 1.37.2 1.88.12.57-.08 1.75-.72 2-1.41.25-.7.25-1.29.17-1.41-.07-.13-.27-.2-.57-.35z" />
  </svg>
);
export const InstagramIcon = (p) => (<svg {...base} {...p}><rect x="3" y="3" width="18" height="18" rx="5" /><circle cx="12" cy="12" r="4" /><circle cx="17.5" cy="6.5" r="0.6" fill="currentColor" /></svg>);
export const FacebookIcon = (p) => (<svg {...base} {...p}><path d="M15 3h-2.5A3.5 3.5 0 0 0 9 6.5V10H6.5v3.5H9V21h3.5v-7.5H15l.5-3.5h-3V7a1 1 0 0 1 1-1H15z" /></svg>);
export const TikTokIcon = (p) => (<svg {...base} {...p}><path d="M14 3v11.5a3.5 3.5 0 1 1-3.5-3.5" /><path d="M14 3c.5 2.6 2.4 4.5 5 4.8" /></svg>);
