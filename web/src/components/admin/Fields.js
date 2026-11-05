export function Field({ label, name, hint, className = "", ...rest }) {
  return (
    <div className={className}>
      <label className="label" htmlFor={name}>{label}</label>
      <input id={name} name={name} className="input" {...rest} />
      {hint && <p className="mt-1 text-xs text-muted">{hint}</p>}
    </div>
  );
}

export function TextArea({ label, name, hint, className = "", rows = 4, ...rest }) {
  return (
    <div className={className}>
      <label className="label" htmlFor={name}>{label}</label>
      <textarea id={name} name={name} rows={rows} className="input" {...rest} />
      {hint && <p className="mt-1 text-xs text-muted">{hint}</p>}
    </div>
  );
}

export function Check({ label, name, defaultChecked, hint }) {
  return (
    <label className="flex items-start gap-2 text-sm">
      <input type="checkbox" name={name} defaultChecked={!!defaultChecked} className="mt-0.5 h-4 w-4" />
      <span>
        {label}
        {hint && <span className="block text-xs text-muted">{hint}</span>}
      </span>
    </label>
  );
}

export function Card({ title, children, actions }) {
  return (
    <section className="border border-line bg-white p-5">
      {(title || actions) && (
        <div className="mb-4 flex items-center justify-between">
          {title && <h2 className="font-sans text-sm font-bold uppercase tracking-wider">{title}</h2>}
          {actions}
        </div>
      )}
      <div className="space-y-4">{children}</div>
    </section>
  );
}

export function PageHeader({ title, children }) {
  return (
    <div className="mb-6 flex flex-wrap items-center justify-between gap-4">
      <h1 className="text-3xl">{title}</h1>
      <div className="flex gap-2">{children}</div>
    </div>
  );
}

export function Badge({ children, tone = "gray" }) {
  const tones = {
    gray: "bg-gray-100 text-gray-700",
    green: "bg-green-100 text-green-800",
    yellow: "bg-yellow-100 text-yellow-800",
    red: "bg-red-100 text-red-700",
    blue: "bg-sky-100 text-sky-800",
    gold: "bg-festive/20 text-festive-dark",
  };
  return <span className={`inline-block px-2 py-0.5 text-xs font-medium capitalize ${tones[tone]}`}>{children}</span>;
}

export const paymentTone = (s) => ({ paid: "green", pending: "yellow", failed: "red", unpaid: "gray" })[s] || "gray";
export const statusTone = (s) => ({ completed: "green", processing: "blue", ready: "blue", shipped: "blue", cancelled: "red", refunded: "red" })[s] || "gray";
