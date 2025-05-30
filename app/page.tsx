import prisma from '../lib/prisma'

export default async function HomePage() {
  // 🔍 Requête côté serveur (Next.js App Router le permet directement ici)
  const admins = await prisma.admin.findMany()
  const trainees = await prisma.trainee.findMany()

  return (
    <html>
      <body>
        <main style={{ padding: '2rem' }}>
          <h1>Liste des administrateurs</h1>

          {admins.length === 0 ? (
            <p>Aucun administrateur trouvé.</p>
          ) : (
            <ul>
              {admins.map((admin) => (
                <li key={admin.admin_id} style={{ marginBottom: '1rem' }}>
                  <strong>{admin.firstname_admin} {admin.lastname_admin}</strong><br />
                  Email : {admin.email_admin}<br />
                  Téléphone : {admin.phone_number_admin}
                </li>
              ))}
            </ul>
          )}
        </main>

        <main style={{ padding: '2rem' }}>
          <h1>Liste des stagiaires</h1>

          {admins.length === 0 ? (
            <p>Aucun stagiaire trouvé.</p>
          ) : (
            <ul>
              {trainees.map((trainee) => (
                <li key={trainee.trainee_id} style={{ marginBottom: '1rem' }}>
                  <strong>{trainee.firstname_trainee} {trainee.lastname_trainee}</strong><br />
                  Email : {trainee.email_trainee}<br />
                  Téléphone : {trainee.phone_number_trainee}
                </li>
              ))}
            </ul>
          )}
        </main>

      </body>
    </html>
  )
}
