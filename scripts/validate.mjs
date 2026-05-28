import { existsSync, readFileSync, readdirSync, statSync } from "node:fs";
import path from "node:path";

const root = process.cwd();
const requiredFiles = [
  "makepay-rails.gemspec",
  "Gemfile",
  "Rakefile",
  "lib/makepay/rails.rb",
  "lib/makepay/rails/version.rb",
  "lib/makepay/rails/configuration.rb",
  "lib/makepay/rails/engine.rb",
  "lib/generators/makepay/rails/install_generator.rb",
  "lib/generators/makepay/rails/templates/makepay.rb",
  "app/controllers/makepay/rails/application_controller.rb",
  "app/controllers/makepay/rails/payment_links_controller.rb",
  "app/controllers/makepay/rails/webhooks_controller.rb",
  "app/jobs/makepay/rails/webhook_job.rb",
  "config/routes.rb",
  "README.md",
  "CHANGELOG.md",
  "LICENSE",
  "SECURITY.md",
  "CONTRIBUTING.md",
  "docs/ROADMAP.md",
  "docs/REPOSITORY_PROTECTION.md",
  "docs/ENGINE_CONTRACT.md"
];

const forbiddenPatterns = [
  new RegExp("Jo" + "zef\\s+Voj" + "tas", "i"),
  new RegExp("orange" + "btc", "i"),
  new RegExp("vc" + "p_[A-Za-z0-9]+"),
  new RegExp("sb" + "p_[A-Za-z0-9]+"),
  new RegExp("Payments" + "2025", "i")
];

function fail(message) {
  console.error(`validate: ${message}`);
  process.exitCode = 1;
}

for (const file of requiredFiles) {
  if (!existsSync(path.join(root, file))) {
    fail(`missing ${file}`);
  }
}

const gemspec = readFileSync(path.join(root, "makepay-rails.gemspec"), "utf8");
for (const expected of [
  'spec.name = "makepay-rails"',
  'spec.add_dependency "makepay"',
  'spec.add_dependency "rails"',
  "rubygems_mfa_required"
]) {
  if (!gemspec.includes(expected)) {
    fail(`gemspec missing ${expected}`);
  }
}

const engine = readFileSync(path.join(root, "lib/makepay/rails/engine.rb"), "utf8");
for (const expected of ["Rails::Engine", "isolate_namespace MakePay::Rails", "filter_parameters"]) {
  if (!engine.includes(expected)) {
    fail(`engine missing ${expected}`);
  }
}

const webhook = readFileSync(path.join(root, "app/controllers/makepay/rails/webhooks_controller.rb"), "utf8");
for (const expected of ["skip_before_action :verify_authenticity_token", "MakePay::Webhook.verify!", "webhook_handler"]) {
  if (!webhook.includes(expected)) {
    fail(`webhook controller missing ${expected}`);
  }
}

function listFiles(directory) {
  const files = [];
  for (const entry of readdirSync(directory)) {
    if ([".git", "pkg", "vendor", "node_modules"].includes(entry)) {
      continue;
    }
    const absolute = path.join(directory, entry);
    const relative = path.relative(root, absolute);
    const stat = statSync(absolute);
    if (stat.isDirectory()) {
      files.push(...listFiles(absolute));
    } else {
      files.push(relative);
    }
  }
  return files;
}

for (const file of listFiles(root)) {
  const body = readFileSync(path.join(root, file), "utf8");
  for (const pattern of forbiddenPatterns) {
    if (pattern.test(body)) {
      fail(`${file} contains forbidden pattern ${pattern}`);
    }
  }
}

if (process.exitCode) {
  process.exit();
}

console.log("validate: Rails engine metadata and safety checks passed");
