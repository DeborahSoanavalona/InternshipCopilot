// lib/prisma.ts

import { PrismaClient } from '../app/generated/prisma/client' // ✅ Chemin vers le client généré
import { withAccelerate } from '@prisma/extension-accelerate'

// ✅ On définit une variable globale pour éviter de recréer plusieurs instances en dev
const globalForPrisma = globalThis as unknown as {
  prisma: PrismaClient
}

// ✅ On réutilise le client s’il existe, sinon on en crée un avec l'extension Accelerate
const prisma =
  globalForPrisma.prisma ||
  new PrismaClient().$extends(withAccelerate())

// ✅ En développement, on sauvegarde le client dans le contexte global
if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = prisma

// ✅ On exporte l’instance réutilisable dans tout le projet
export default prisma
