import type { Metadata } from "next";
import Image from "next/image";
import AuthPanels from "./AuthPanels";
import styles from "./login.module.css";

export const metadata: Metadata = {
  title: "Sign Up / Log In · RaceLink",
};

export default function LoginPage() {
  return (
    <div className={styles.page}>
      <Image src="/images/background.png" alt="" fill priority sizes="100vw" className={styles.bg} />

      <main className={styles.card}>
        <div className={styles.brand}>
          <span>Race</span>Link
        </div>
        <p className={styles.subtitle}>Your Marathon Registration Platform</p>
        <AuthPanels />
      </main>
    </div>
  );
}
