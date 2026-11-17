"use client";

import { useState, type FormEvent } from "react";
import { useRouter } from "next/navigation";
import styles from "./login.module.css";

type Mode = "signUp" | "logIn";

const SIGN_UP_FIELDS = [
  { id: "name", label: "Full Name", type: "text", placeholder: "Enter your full name", required: true },
  { id: "email", label: "Email", type: "email", placeholder: "Enter your email", required: true },
  { id: "password", label: "Password", type: "password", placeholder: "Enter your password", required: true },
  { id: "phone", label: "Phone", type: "tel", placeholder: "Enter your phone number" },
  { id: "address", label: "Address", type: "text", placeholder: "Enter your address" },
] as const;

const EMERGENCY_FIELDS = [
  { id: "emergencyName", label: "Emergency Contact Name", type: "text", placeholder: "Enter emergency contact name" },
  { id: "emergencyPhone", label: "Emergency Contact Number", type: "tel", placeholder: "Enter emergency contact phone" },
] as const;

export default function AuthPanels() {
  const [mode, setMode] = useState<Mode>("signUp");
  const router = useRouter();

  function panelClass(panel: Mode) {
    const state = mode === panel ? styles.active : styles.inactive;
    return `${styles.panel} ${styles[panel]} ${state}`;
  }

  /* wala pang backend, diretso dashboard muna */
  function handleSubmit(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    router.push("/dashboard");
  }

  return (
    <>
      <div className={styles.toggles}>
        <button
          type="button"
          className={`${styles.toggle} ${mode === "signUp" ? styles.active : ""}`}
          aria-pressed={mode === "signUp"}
          onClick={() => setMode("signUp")}
        >
          Sign Up
        </button>
        <button
          type="button"
          className={`${styles.toggle} ${mode === "logIn" ? styles.active : ""}`}
          aria-pressed={mode === "logIn"}
          onClick={() => setMode("logIn")}
        >
          Log In
        </button>
      </div>

      <div className={styles.wrapper}>
        <section
          className={panelClass("signUp")}
          inert={mode !== "signUp"}
        >
          <form className={styles.form} onSubmit={handleSubmit}>
            <div className={styles.grid}>
              {SIGN_UP_FIELDS.map((f) => (
                <div key={f.id}>
                  <label htmlFor={`sign-up-${f.id}`} className={styles.label}>
                    {f.label}
                  </label>
                  <input
                    id={`sign-up-${f.id}`}
                    name={f.id}
                    type={f.type}
                    placeholder={f.placeholder}
                    required={"required" in f}
                    className={styles.input}
                  />
                </div>
              ))}

              <div>
                <label htmlFor="sign-up-gender" className={styles.label}>
                  Gender
                </label>
                <select id="sign-up-gender" name="gender" defaultValue="" className={styles.input}>
                  <option value="" disabled>
                    Select your gender
                  </option>
                  <option value="M">Male</option>
                  <option value="F">Female</option>
                  <option value="O">Other</option>
                </select>
              </div>

              <div>
                <label htmlFor="sign-up-birthdate" className={styles.label}>
                  Birthdate
                </label>
                <input id="sign-up-birthdate" name="birthdate" type="date" className={styles.input} />
              </div>

              {EMERGENCY_FIELDS.map((f) => (
                <div key={f.id}>
                  <label htmlFor={`sign-up-${f.id}`} className={styles.label}>
                    {f.label}
                  </label>
                  <input
                    id={`sign-up-${f.id}`}
                    name={f.id}
                    type={f.type}
                    placeholder={f.placeholder}
                    className={styles.input}
                  />
                </div>
              ))}
            </div>
            <button type="submit" className={styles.submit}>
              Sign Up
            </button>
          </form>
        </section>

        <section
          className={panelClass("logIn")}
          inert={mode !== "logIn"}
        >
          <form className={styles.form} onSubmit={handleSubmit}>
            <div className={styles.field}>
              <label htmlFor="log-in-email" className={styles.label}>
                Email
              </label>
              <input
                id="log-in-email"
                name="email"
                type="email"
                placeholder="Enter your email"
                required
                className={styles.input}
              />
            </div>
            <div className={styles.field}>
              <label htmlFor="log-in-password" className={styles.label}>
                Password
              </label>
              <input
                id="log-in-password"
                name="password"
                type="password"
                placeholder="Enter your password"
                required
                className={styles.input}
              />
            </div>
            <button type="submit" className={styles.submit}>
              Log In
            </button>
          </form>
        </section>
      </div>
    </>
  );
}
