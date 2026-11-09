// Email-client-safe HTML (tables + inline styles) for order emails. No em dashes (house style).
import { formatNaira, formatDate, whatsappLink, telLink } from "./format";
import { DELIVERY_METHODS } from "./orders";
import { vatRows } from "./vat";

const C = { ink: "#262626", muted: "#6b6b6b", gold: "#c9a227", goldDark: "#9c7a12", champagne: "#f6efd9", line: "#e8e2d0", bg: "#f4f1ea", white: "#ffffff" };
const SERIF = "Georgia, 'Times New Roman', serif";
const SANS = "'Helvetica Neue', Helvetica, Arial, sans-serif";

export const esc = (s) =>
  String(s ?? "").replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" })[c]);

const abs = (siteUrl, url) => (!url ? "" : /^https?:\/\//.test(url) ? url : `${siteUrl}${url.startsWith("/") ? "" : "/"}${url}`);
const PAYMENT_LABELS = { paystack: "Paid online with Paystack", opay: "Paid online with OPay", bank_transfer: "Bank transfer", mock: "Test payment" };

function layout({ siteUrl, preheader, body, store, showrooms }) {
  const rooms = (showrooms || [])
    .map((s) => `<p style="margin:0 0 6px;font:13px/1.5 ${SANS};color:${C.muted};"><strong style="color:${C.ink};">${esc(s.name)}</strong><br>${esc(s.address)}</p>`)
    .join("");
  return `<!DOCTYPE html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><meta name="color-scheme" content="light only"><title>${esc(store.name)}</title></head>
<body style="margin:0;padding:0;background:${C.bg};">
<div style="display:none;max-height:0;overflow:hidden;opacity:0;">${esc(preheader)}</div>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:${C.bg};">
<tr><td align="center" style="padding:24px 12px;">
  <table role="presentation" width="600" cellpadding="0" cellspacing="0" style="width:100%;max-width:600px;background:${C.white};border:1px solid ${C.line};">
    <tr><td align="center" style="background:${C.champagne};padding:28px 24px 22px;border-bottom:1px solid ${C.line};">
      <a href="${esc(siteUrl)}" style="text-decoration:none;"><img src="${esc(abs(siteUrl, "/logo.png"))}" width="72" height="70" alt="${esc(store.name)}" style="display:block;border:0;border-radius:50%;"></a>
      <p style="margin:12px 0 0;font:600 13px/1 ${SANS};letter-spacing:4px;text-transform:uppercase;color:${C.ink};">Wecis Clothing</p>
    </td></tr>
    ${body}
    <tr><td style="padding:24px 32px;background:${C.champagne};border-top:1px solid ${C.line};">
      <p style="margin:0 0 10px;font:600 11px/1 ${SANS};letter-spacing:2px;text-transform:uppercase;color:${C.goldDark};">Need help?</p>
      <p style="margin:0 0 14px;font:14px/1.6 ${SANS};color:${C.ink};">
        WhatsApp: <a href="${esc(whatsappLink(store.whatsapp))}" style="color:${C.goldDark};">${esc(store.whatsapp)}</a><br>
        Phone: <a href="${esc(telLink(store.phone))}" style="color:${C.goldDark};">${esc(store.phone)}</a><br>
        Email: <a href="mailto:${esc(store.email)}" style="color:${C.goldDark};">${esc(store.email)}</a>
      </p>
      ${rooms}
    </td></tr>
  </table>
  <p style="margin:16px 0 0;font:12px/1.5 ${SANS};color:${C.muted};">&copy; ${new Date().getFullYear()} ${esc(store.name)}. Prices in Nigerian Naira (NGN).</p>
</td></tr></table>
</body></html>`;
}

function itemsTable(order, siteUrl) {
  const rows = order.items
    .map(
      (i) => `<tr>
  <td width="64" valign="top" style="padding:12px 12px 12px 0;border-bottom:1px solid ${C.line};">${
        i.image ? `<img src="${esc(abs(siteUrl, i.image))}" width="56" height="70" alt="" style="display:block;width:56px;height:70px;object-fit:cover;border:0;">` : ""
      }</td>
  <td valign="top" style="padding:12px 0;border-bottom:1px solid ${C.line};font:14px/1.5 ${SANS};color:${C.ink};">
    ${esc(i.name)}<br><span style="color:${C.muted};font-size:13px;">${i.size ? `Size: ${esc(i.size)} &middot; ` : ""}Qty: ${i.quantity} &middot; ${esc(formatNaira(i.unit_price))} each${
      Number(i.vat_amount) > 0 ? ` &middot; ${i.vat_inclusive ? "VAT inclusive" : "+ VAT"}` : ""
    }</span>
  </td>
  <td valign="top" align="right" style="padding:12px 0;border-bottom:1px solid ${C.line};font:14px/1.5 ${SANS};color:${C.ink};white-space:nowrap;">${esc(formatNaira(i.line_total))}</td>
</tr>`
    )
    .join("");
  const total = (label, value, strong) =>
    `<tr><td></td><td style="padding:${strong ? "10px" : "4px"} 0 0;font:${strong ? "600 16px" : "14px"}/1.5 ${SANS};color:${C.ink};">${label}</td><td align="right" style="padding:${strong ? "10px" : "4px"} 0 0;font:${strong ? "600 16px" : "14px"}/1.5 ${SANS};color:${C.ink};white-space:nowrap;">${value}</td></tr>`;
  return `<table role="presentation" width="100%" cellpadding="0" cellspacing="0">${rows}
    ${total("Subtotal", esc(formatNaira(order.subtotal)))}
    ${vatRows(order).filter((r) => r.kind === "added").map((r) => total(esc(r.label), esc(formatNaira(r.amount)))).join("")}
    ${total("Delivery", Number(order.shipping_fee) ? esc(formatNaira(order.shipping_fee)) : "Free")}
    ${total("Total", esc(formatNaira(order.total)), true)}
    ${vatRows(order)
      .filter((r) => r.kind === "included")
      .map((r) => `<tr><td></td><td style="padding:4px 0 0;font:12px/1.5 ${SANS};color:${C.muted};">${esc(r.label)}</td><td align="right" style="padding:4px 0 0;font:12px/1.5 ${SANS};color:${C.muted};white-space:nowrap;">${esc(formatNaira(r.amount))}</td></tr>`)
      .join("")}
  </table>`;
}

/** Plain-text totals block for the text version of emails. */
function totalsText(order) {
  const rows = vatRows(order);
  return [
    `Subtotal: ${formatNaira(order.subtotal)}`,
    ...rows.filter((r) => r.kind === "added").map((r) => `${r.label}: ${formatNaira(r.amount)}`),
    `Delivery: ${Number(order.shipping_fee) ? formatNaira(order.shipping_fee) : "Free"}`,
    `Total: ${formatNaira(order.total)}`,
    ...rows.filter((r) => r.kind === "included").map((r) => `${r.label}: ${formatNaira(r.amount)}`),
  ].join("\n");
}

function itemsText(order) {
  return order.items.map((i) => `- ${i.quantity} x ${i.name}${i.size ? ` (${i.size})` : ""}: ${formatNaira(i.line_total)}`).join("\n");
}

function deliveryText(order) {
  const method = DELIVERY_METHODS[order.delivery_method] || order.delivery_method;
  const address = order.address_line ? `${order.address_line}, ${order.city}, ${order.state}` : "";
  return { method, address };
}

/** Customer: "Your order is confirmed". */
export function orderConfirmationEmail({ order, store, showrooms, siteUrl, viewUrl }) {
  const { method, address } = deliveryText(order);
  const name = order.first_name;
  const subject = `Your Wecis Clothing order ${order.order_number} is confirmed`;
  const body = `
    <tr><td style="padding:32px 32px 8px;">
      <p style="margin:0;font:600 11px/1 ${SANS};letter-spacing:3px;text-transform:uppercase;color:${C.goldDark};">Order ${esc(order.order_number)}</p>
      <h1 style="margin:10px 0 0;font:400 30px/1.25 ${SERIF};color:${C.ink};">Thank you, ${esc(name)}!</h1>
      <p style="margin:14px 0 0;font:15px/1.6 ${SANS};color:${C.ink};">We've received your payment of <strong>${esc(formatNaira(order.total))}</strong> and your order is confirmed. Our team will contact you on ${esc(order.phone)} about ${order.delivery_method.startsWith("pickup_") ? "your pick-up" : "delivery"}.</p>
    </td></tr>
    <tr><td align="center" style="padding:20px 32px 8px;">
      <a href="${esc(viewUrl)}" style="display:inline-block;background:${C.gold};color:${C.ink};font:600 12px/1 ${SANS};letter-spacing:3px;text-transform:uppercase;text-decoration:none;padding:15px 28px;">View your order</a>
    </td></tr>
    <tr><td style="padding:24px 32px 8px;">
      <p style="margin:0 0 6px;font:600 11px/1 ${SANS};letter-spacing:2px;text-transform:uppercase;color:${C.goldDark};">Order summary</p>
      ${itemsTable(order, siteUrl)}
    </td></tr>
    <tr><td style="padding:20px 32px 28px;">
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0"><tr>
        <td valign="top" width="50%" style="padding-right:12px;">
          <p style="margin:0 0 6px;font:600 11px/1 ${SANS};letter-spacing:2px;text-transform:uppercase;color:${C.goldDark};">Delivery</p>
          <p style="margin:0;font:14px/1.6 ${SANS};color:${C.ink};">${esc(method)}${address ? `<br>${esc(address)}` : ""}</p>
        </td>
        <td valign="top" width="50%" style="padding-left:12px;">
          <p style="margin:0 0 6px;font:600 11px/1 ${SANS};letter-spacing:2px;text-transform:uppercase;color:${C.goldDark};">Payment</p>
          <p style="margin:0;font:14px/1.6 ${SANS};color:${C.ink};">${esc(PAYMENT_LABELS[order.payment_method] || order.payment_method)}${
            order.paid_at ? `<br>${esc(formatDate(order.paid_at))}` : ""
          }${order.payment_reference ? `<br><span style="color:${C.muted};font-size:12px;">Ref: ${esc(order.payment_reference)}</span>` : ""}</p>
        </td>
      </tr></table>
      ${order.notes ? `<p style="margin:18px 0 0;font:14px/1.6 ${SANS};color:${C.muted};"><strong style="color:${C.ink};">Your notes:</strong> ${esc(order.notes)}</p>` : ""}
    </td></tr>`;
  const text = `Thank you, ${name}!

Your Wecis Clothing order ${order.order_number} is confirmed. We've received your payment of ${formatNaira(order.total)}.

${itemsText(order)}
${totalsText(order)}

Delivery: ${method}${address ? `\n${address}` : ""}
Payment: ${PAYMENT_LABELS[order.payment_method] || order.payment_method}${order.payment_reference ? ` (Ref: ${order.payment_reference})` : ""}

View your order: ${viewUrl}

Questions? WhatsApp ${store.whatsapp}, call ${store.phone} or email ${store.email}.
${store.name}`;
  return { subject, html: layout({ siteUrl, preheader: `Order ${order.order_number} confirmed. Total ${formatNaira(order.total)}.`, body, store, showrooms }), text };
}

/** Store team: "New paid order". */
export function adminNewOrderEmail({ order, store, siteUrl, adminUrl }) {
  const { method, address } = deliveryText(order);
  const subject = `New paid order ${order.order_number}: ${formatNaira(order.total)}`;
  const body = `
    <tr><td style="padding:28px 32px 8px;">
      <p style="margin:0;font:600 11px/1 ${SANS};letter-spacing:3px;text-transform:uppercase;color:${C.goldDark};">New paid order</p>
      <h1 style="margin:10px 0 0;font:400 26px/1.3 ${SERIF};color:${C.ink};">${esc(order.order_number)} &middot; ${esc(formatNaira(order.total))}</h1>
      <p style="margin:14px 0 0;font:15px/1.7 ${SANS};color:${C.ink};">
        <strong>${esc(order.first_name)} ${esc(order.last_name)}</strong><br>
        <a href="mailto:${esc(order.email)}" style="color:${C.goldDark};">${esc(order.email)}</a> &middot; <a href="${esc(telLink(order.phone))}" style="color:${C.goldDark};">${esc(order.phone)}</a>
        &middot; <a href="${esc(whatsappLink(order.phone, `Hello ${order.first_name}, this is Wecis Clothing about your order ${order.order_number}.`))}" style="color:${C.goldDark};">WhatsApp</a><br>
        ${esc(method)}${address ? `<br>${esc(address)}` : ""}<br>
        ${esc(PAYMENT_LABELS[order.payment_method] || order.payment_method)}${order.payment_reference ? ` &middot; Ref ${esc(order.payment_reference)}` : ""}
      </p>
      ${order.notes ? `<p style="margin:12px 0 0;padding:12px;background:${C.champagne};font:14px/1.6 ${SANS};color:${C.ink};"><strong>Customer notes:</strong> ${esc(order.notes)}</p>` : ""}
    </td></tr>
    <tr><td style="padding:16px 32px 8px;">${itemsTable(order, siteUrl)}</td></tr>
    <tr><td align="center" style="padding:20px 32px 28px;">
      <a href="${esc(adminUrl)}" style="display:inline-block;background:${C.ink};color:${C.white};font:600 12px/1 ${SANS};letter-spacing:3px;text-transform:uppercase;text-decoration:none;padding:15px 28px;">Open in admin</a>
    </td></tr>`;
  const text = `New paid order ${order.order_number}: ${formatNaira(order.total)}

Customer: ${order.first_name} ${order.last_name}, ${order.email}, ${order.phone}
${method}${address ? `\n${address}` : ""}
Payment: ${PAYMENT_LABELS[order.payment_method] || order.payment_method}${order.payment_reference ? ` (Ref ${order.payment_reference})` : ""}
${order.notes ? `Notes: ${order.notes}\n` : ""}
${itemsText(order)}
${totalsText(order)}

Open in admin: ${adminUrl}`;
  return { subject, html: layout({ siteUrl, preheader: `${order.first_name} ${order.last_name} paid ${formatNaira(order.total)}`, body, store, showrooms: [] }), text };
}

/** Customer: "Confirm your email". */
export function verifyEmailEmail({ customer, url, store, siteUrl }) {
  const subject = "Confirm your email for your Wecis Clothing account";
  const body = `
    <tr><td style="padding:32px 32px 8px;">
      <h1 style="margin:0;font:400 28px/1.25 ${SERIF};color:${C.ink};">Hello ${esc(customer.first_name)},</h1>
      <p style="margin:14px 0 0;font:15px/1.6 ${SANS};color:${C.ink};">Please confirm that this is your email address. Once you do, any orders you placed with ${esc(customer.email)} before you created your account will appear in your account too.</p>
    </td></tr>
    <tr><td align="center" style="padding:24px 32px 12px;">
      <a href="${esc(url)}" style="display:inline-block;background:${C.gold};color:${C.ink};font:600 12px/1 ${SANS};letter-spacing:3px;text-transform:uppercase;text-decoration:none;padding:15px 28px;">Confirm my email</a>
    </td></tr>
    <tr><td style="padding:8px 32px 28px;">
      <p style="margin:0;font:13px/1.6 ${SANS};color:${C.muted};">This link works for 3 days. If you didn't create an account with us, you can ignore this email.</p>
    </td></tr>`;
  const text = `Hello ${customer.first_name},

Please confirm your email address for your Wecis Clothing account. Once you do, any orders you placed with ${customer.email} before you created your account will appear in your account too.

Confirm my email: ${url}

This link works for 3 days. If you didn't create an account with us, you can ignore this email.
${store.name}`;
  return { subject, html: layout({ siteUrl, preheader: "Confirm your email to see all your orders.", body, store, showrooms: [] }), text };
}

/** A reply from Admin, Messages to someone who used the Contact us form. */
export function contactReplyEmail({ message, reply, store, siteUrl }) {
  const subject = `Re: ${message.topic} (your message to ${store.name})`;
  const para = (t) => esc(t).replace(/\n/g, "<br>");
  const body = `
    <tr><td style="padding:32px 32px 8px;">
      <h1 style="margin:0;font:400 28px/1.25 ${SERIF};color:${C.ink};">Hello ${esc(message.name)},</h1>
      <p style="margin:14px 0 0;font:15px/1.6 ${SANS};color:${C.ink};">${para(reply)}</p>
    </td></tr>
    <tr><td style="padding:16px 32px 28px;">
      <p style="margin:0 0 8px;font:600 11px/1 ${SANS};letter-spacing:2px;text-transform:uppercase;color:${C.goldDark};">Your message (${esc(formatDate(message.created_at))})</p>
      <p style="margin:0;padding:14px;background:${C.champagne};font:14px/1.6 ${SANS};color:${C.muted};">${para(message.message)}</p>
      <p style="margin:14px 0 0;font:13px/1.6 ${SANS};color:${C.muted};">You can reply to this email to continue the conversation.</p>
    </td></tr>`;
  const quoted = String(message.message).split("\n").map((l) => `> ${l}`).join("\n");
  const text = `Hello ${message.name},

${reply}

On ${formatDate(message.created_at)} you wrote:
${quoted}

You can reply to this email to continue the conversation.
${store.name}`;
  return { subject, html: layout({ siteUrl, preheader: reply.slice(0, 120), body, store, showrooms: [] }), text };
}
