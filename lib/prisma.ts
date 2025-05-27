// lib/prisma.ts
import { PrismaClient } from '@/generated/prisma'; // ← alias propre si configuré dans tsconfig
import { withAccelerate } from '@prisma/extension-accelerate';

type GlobalPrisma = typeof globalThis & {
  prisma?: PrismaClient;
};

const globalForPrisma = globalThis as GlobalPrisma;

const prisma =
  globalForPrisma.prisma ??
  new PrismaClient().$extends(withAccelerate());

if (process.env.NODE_ENV !== 'production') {
  globalForPrisma.prisma = prisma;
}

export default prisma;
