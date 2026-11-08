"use server";
import { z } from "zod";
import { headers } from "next/headers";
import { getSetting } from "@/lib/settings";
import { TOPICS, createChallenge, checkHuman, countLinks, LINK_LIMIT, tooManyFrom, saveMessage, notifyStore } from "@/lib/contact";

const schema = z.object({
  name: z.string().trim().min(2, "Please enter your name").max(120),
  email: z.string().trim().toLowerCase().email("Please enter a valid email address").max(190),
  phone: z.string().trim().max(40).optional().default(""),
  topic: z.enum(TOPICS, { message: "Please choose a topic" }),
  message: z.string().trim().min(10, "Please write a little more (at least 10 characters)").max(4000, "Please keep your message under 4,000 characters"),
});

/** Contact form action. Always returns a new captcha question, since each one works once. */
export async function sendContactMessage(_prev, fd) {
  const challenge = await createChallenge();
  const values = Object.fromEntries(["name", "email", "phone", "topic", "message"].map((k) => [k, String(fd.get(k) ?? "")]));
  const fail = (error) => ({ error, challenge, values });

  const parsed = schema.safeParse(values);
  if (!parsed.success) return fail(parsed.error.issues[0].message);

  const human = await checkHuman({ token: fd.get("token"), answer: fd.get("answer"), website: fd.get("website") });
  // Bots get a normal-looking "sent" reply, so they don't learn what tripped them.
  if (human.error === "spam") return { ok: true, challenge };
  if (human.error) return fail(human.error);

  if (countLinks(parsed.data.message) > LINK_LIMIT) return fail(`Please include no more than ${LINK_LIMIT} links in your message.`);

  const h = await headers();
  const ip = (h.get("x-nf-client-connection-ip") || h.get("x-forwarded-for") || "").split(",")[0].trim().slice(0, 64) || null;
  if (await tooManyFrom(ip)) return fail("You've sent several messages in the last hour. Please try again later, or WhatsApp us.");

  const message = { ...parsed.data, ip, userAgent: h.get("user-agent") || "", nonce: human.nonce };
  if (!(await saveMessage(message))) return fail("This form was already sent. Please answer the new question to send another message.");

  const sent = await notifyStore(message, await getSetting("store"));
  if (!sent.ok) console.error("Contact form email failed:", sent.error); // the message is still saved in Admin, Messages
  return { ok: true, challenge };
}
