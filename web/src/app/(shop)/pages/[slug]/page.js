import { notFound } from "next/navigation";
import { getPage } from "@/lib/catalog";
import { stripHtml } from "@/lib/format";

export async function generateMetadata({ params }) {
  const { slug } = await params;
  const page = await getPage(slug);
  if (!page) return {};
  return { title: page.title, description: page.meta_description || stripHtml(page.body).slice(0, 160) };
}

export default async function InfoPage({ params }) {
  const { slug } = await params;
  const page = await getPage(slug);
  if (!page) notFound();
  return (
    <article className="mx-auto max-w-3xl px-4 py-12">
      <h1 className="mb-8 text-center text-4xl">{page.title}</h1>
      <div className="prose-wecis" dangerouslySetInnerHTML={{ __html: page.body || "" }} />
    </article>
  );
}
