"use client";

import Image from "next/image";
import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import type { IconType } from "react-icons";
import { FaInfoCircle, FaRunning, FaSignOutAlt, FaTachometerAlt, FaUser } from "react-icons/fa";
import styles from "@/app/(app)/shell.module.css";

const LINKS: { href: string; label: string; icon: IconType }[] = [
  { href: "/dashboard", label: "Dashboard", icon: FaTachometerAlt },
  { href: "/marathons", label: "Marathons", icon: FaRunning },
  { href: "/about", label: "About Us", icon: FaInfoCircle },
  { href: "/profile", label: "User Profile", icon: FaUser },
];

export default function Sidebar() {
  const pathname = usePathname();
  const router = useRouter();

  function logout() {
    if (window.confirm("Are you sure you want to log out?")) {
      router.push("/login");
    }
  }

  return (
    <nav className={styles.panel} aria-label="Main navigation">
      <Link href="/" className={styles.logo}>
        <Image src="/images/RACELINK_LOGO.png" alt="RaceLink home" width={80} height={80} />
      </Link>

      {LINKS.map(({ href, label, icon: Icon }) => {
        const current = pathname.startsWith(href);
        return (
          <Link
            key={href}
            href={href}
            title={label}
            aria-current={current ? "page" : undefined}
            className={`${styles.item} ${current ? styles.current : ""}`}
          >
            <Icon className={styles.icon} aria-hidden />
            <span className={styles.label}>{label}</span>
          </Link>
        );
      })}

      <button type="button" title="Log Out" onClick={logout} className={`${styles.item} ${styles.logout}`}>
        <FaSignOutAlt className={styles.icon} aria-hidden />
        <span className={styles.label}>Log Out</span>
      </button>
    </nav>
  );
}
