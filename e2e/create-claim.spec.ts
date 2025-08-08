import { test, expect } from '@playwright/test';
import { navigateTo } from './test-utils';

test("home page loads and shows claim form", async ({ page }) => {
  await navigateTo(page, "/");

  await expect(page.locator("h1")).toHaveText("Travel Insurance Claim");

  await page.locator('select[name="claim[trip_type_id]"]').selectOption("1");
  await page.locator('select[name="claim[age_id]"]').selectOption("17");
  await page.locator('select[name="claim[excess_id]"]').selectOption("1");
  await page
    .locator('select[name="claim[policy]"]')
    .selectOption("Single Trip");
  await page
    .locator('input[name="claim[trip_start_date]"]')
    .fill(new Date().toISOString().split("T")[0]);

  const endDate = new Date();
  endDate.setDate(endDate.getDate() + 4);
  await page
    .locator('input[name="claim[trip_end_date]"]')
    .fill(endDate.toISOString().split("T")[0]);
  await page.locator('select[name="claim[destinations][]"]').selectOption("1");
  await page.locator('select[name="claim[destinations][]"]').selectOption("2");
  await page.locator('input[type="submit"]').click();

  await page.waitForTimeout(2000); // wait for 2 seconds for redirect

  await expect(page).toHaveURL(/.*claims\/.*\/edit/);

  await expect(page.locator("h1")).toHaveText("Update Claim");
  await expect(page.locator("h2#premiums")).toHaveText("Premiums");

  const premiumBasic = page.locator("#premium-Basic");
  await expect(premiumBasic.locator("h2")).toHaveText("Basic");
  await expect(premiumBasic.locator("p")).toHaveText("$3.81");

  const premiumPlus = page.locator("#premium-Plus");
  await expect(premiumPlus.locator("h2")).toHaveText("Plus");
  await expect(premiumPlus.locator("p")).toHaveText("$5.52");

  const premiumElite = page.locator("#premium-Elite");
  await expect(premiumElite.locator("h2")).toHaveText("Elite");
  await expect(premiumElite.locator("p")).toHaveText("$5.91");
});
