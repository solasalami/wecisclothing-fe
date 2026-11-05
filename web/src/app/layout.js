import { Playfair_Display, Roboto } from "next/font/google";
import "./globals.css";

const playfair = Playfair_Display({ subsets: ["latin"], variable: "--font-playfair", display: "swap" });
const roboto = Roboto({ subsets: ["latin"], weight: ["300", "400", "500", "700"], variable: "--font-roboto", display: "swap" });

export const metadata = {
  metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL || "http://localhost:3000"),
  title: { default: "Wecis Clothing — Premium African Fashion in Lagos", template: "%s | Wecis Clothing" },
  description:
    "Premium African-inspired clothing for men and women. Agbada, kaftan, adire, native and tropical outfits. Showrooms in Ikeja and Victoria Island, Lagos.",
  openGraph: { siteName: "Wecis Clothing", locale: "en_NG", type: "website" },
};

export const viewport = { width: "device-width", initialScale: 1, themeColor: "#262626" };

export default function RootLayout({ children }) {
  return (
    <html lang="en-NG" className={`${playfair.variable} ${roboto.variable}`}>
      <body className="min-h-screen">{children}</body>
    </html>
  );
}
