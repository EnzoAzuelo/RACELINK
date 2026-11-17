import Link from "next/link";
import styles from "./home.module.css";

export default function Home() {
  return (
    <div className={styles.page}>
      <main className={styles.main}>
        <nav className={styles.nav}>
          <Link href="/dashboard">Dashboard</Link>
          <Link href="/marathons">Marathons</Link>
          <Link href="/about">About Us</Link>
        </nav>

        <h1 className={styles.title}>
          Your All-in-One
          <br />
          Running
          <br />
          Community
        </h1>
        <p className={styles.subheading}>Discover, Connect, and Join Marathons Near You</p>

        <div className={styles.buttons}>
          <Link href="/login" className={styles.button}>
            Log In
          </Link>
          <Link href="/marathons" className={styles.button}>
            Browse as Guest
          </Link>
        </div>
      </main>

      <aside className={styles.side} aria-hidden="true">
        RaceLink
      </aside>
    </div>
  );
}
