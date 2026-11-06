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
  async redirects() {
    return [
      // Old one-line page, replaced by the full policy.
      { source: "/pages/delivery-information", destination: "/pages/shipping-and-returns", permanent: true },
    ];
  },
  experimental: {
    serverActions: { bodySizeLimit: "10mb" },
  },
};

export default nextConfig;
