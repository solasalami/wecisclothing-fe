import "server-only";
import crypto from "node:crypto";
import { signToken, verifyToken } from "./auth";

// Simple self-hosted spam check for public forms (no third-party captcha or keys):
//  1. a short arithmetic question; the answer is never sent to the browser, only a
//     signed hash of it, so it can't be read from the page or forged;
//  2. a hidden "website" field that people never see but form-filling bots do;
//  3. timing: a person needs more than a few seconds, and stale pages expire;
//  4. each question is tied to one form ("kind"), and the caller stores the returned
//     nonce with what it saves (UNIQUE column) so a solved question works only once.
// This stops ordinary spam bots. A determined AI browser agent can still solve a
// sum; if that becomes a problem, add Cloudflare Turnstile (free) on top.

const MIN_SECONDS = 3;
const MAX_AGE = 2 * 60 * 60; // 2 hours

const hashAnswer = (kind, nonce, answer) =>
  crypto.createHash("sha256").update(`${kind}:${nonce}:${String(answer).trim()}:${process.env.AUTH_SECRET || ""}`).digest("hex");

/** A fresh question for a form: { question, token }. kind: "contact", "register", … */
export async function createChallenge(kind) {
  const plus = crypto.randomInt(0, 2) === 1;
  let a = crypto.randomInt(2, 10);
  let b = crypto.randomInt(1, 10);
  if (!plus && b > a) [a, b] = [b, a];
  const answer = plus ? a + b : a - b;
  const nonce = crypto.randomBytes(16).toString("hex");
  const token = await signToken({ kind, n: nonce, h: hashAnswer(kind, nonce, answer) }, MAX_AGE);
  return { question: `What is ${a} ${plus ? "+" : "−"} ${b}?`, token };
}

/**
 * Checks the answer, honeypot and timing for a form of this kind.
 * Returns { nonce } or { error }; error "spam" means a bot (answer it as if all went well).
 */
export async function checkHuman(kind, { token, answer, website }) {
  if (website) return { error: "spam" }; // hidden field filled in: a bot
  const payload = await verifyToken(token);
  if (payload?.kind !== kind) return { error: "This form has expired. Please answer the new question and try again." };
  const age = Date.now() / 1000 - (payload.iat || 0);
  if (age < MIN_SECONDS) return { error: "spam" };
  const given = String(answer ?? "").replace(/[^\d-]/g, "");
  if (!given || hashAnswer(kind, payload.n, given) !== payload.h) return { error: "That answer isn't right. Please try the new question." };
  return { nonce: payload.n };
}
