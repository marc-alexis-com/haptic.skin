# Website — haptic.skin

Public website served at [https://haptic.skin](https://haptic.skin).

## How it works

- Static files in `public/` are deployed to the VPS on every push to `main`.
- Served by nginx behind Traefik (auto SSL via Let's Encrypt).
- GitHub Actions handles the deploy automatically.

## Local development

Just open `public/index.html` in a browser. No build step required for now.

When the site grows into a proper frontend (Vue/Vite), the workflow will
run `pnpm build` and deploy the `dist/` folder instead.

## Deploy

Push to `main` → deployed in ~30 seconds. That's it.

The workflow is in `.github/workflows/deploy-website.yml`.

## Structure

```
website/
├── public/          # Static files served as-is
│   └── index.html
└── README.md
```
