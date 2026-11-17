import type { Metadata } from "next";
import { Righteous } from "next/font/google";
import "./globals.css";

const righteous = Righteous({
  subsets: ["latin"],
  weight: "400",
  variable: "--font-righteous",
});

export const metadata: Metadata = {
  title: "RaceLink",
  description: "Discover, connect, and join marathons near you.",
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html lang="en" className={`${righteous.variable} h-full antialiased`}>
      <body className="min-h-full">{children}</body>
    </html>
  );
}
