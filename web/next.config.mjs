/** @type {import('next').NextConfig} */
const nextConfig = {
  // Every storefront/admin page reads live data from MySQL, so we use the
  // classic (non Cache Components) rendering model with explicit dynamic pages.
  cacheComponents: false,
  turbopack: {
    rules: {
      "*.css": {
        loaders: ["@tailwindcss/turbopack"],
        as: "*.css",
      },
    },
  },
  serverExternalPackages: ["mysql2"],
  experimental: {
    serverActions: { bodySizeLimit: "10mb" },
  },
};

export default nextConfig;
