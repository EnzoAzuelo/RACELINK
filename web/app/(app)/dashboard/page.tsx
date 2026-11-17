import type { Metadata } from "next";
import Link from "next/link";
import { FaUser } from "react-icons/fa";
import MarathonCard, { cardStyles } from "@/components/MarathonCard";
import { getMarathons } from "@/lib/marathons";
import { currentUser } from "@/lib/user";
import styles from "./dashboard.module.css";

export const metadata: Metadata = { title: "Dashboard · RaceLink" };

export default function DashboardPage() {
  const latest = getMarathons().slice(0, 5);
  const firstName = currentUser.name.split(" ")[0];

  return (
    <>
      <h1 className={styles.title}>Runner Dashboard</h1>

      <div className={styles.header}>
        <p className={styles.welcome}>Welcome, {firstName}!</p>
        <Link href="/profile" className={styles.profileBtn}>
          <FaUser aria-hidden /> Profile
        </Link>
      </div>

      <section className={styles.section}>
        <h2 className={styles.sectionTitle}>Latest Marathons</h2>
        <div className={cardStyles.grid}>
          {latest.map((m) => (
            <MarathonCard
              key={m.id}
              marathon={m}
              action={
                <Link href={`/marathons?event=${m.id}`} className={cardStyles.button}>
                  Register
                </Link>
              }
            />
          ))}
        </div>
      </section>
    </>
  );
}
