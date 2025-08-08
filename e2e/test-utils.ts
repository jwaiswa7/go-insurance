import { Page } from '@playwright/test';

export const BASE_URL = 'http://localhost:3000';

export async function navigateTo(page: Page, path: string) {
  await page.goto(`${BASE_URL}${path}`);
  await page.waitForLoadState('networkidle');
}