import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  const admin = await prisma.admin.create({
    data: {
      firstname_admin: 'Sophie',
      lastname_admin: 'Dupont',
      email_admin: 'sophie.dupont@example.com',
      password_admin: 'hashed-password', // à sécuriser plus tard
      phone_number_admin: '0601020304',
    },
  });

  const trainee = await prisma.trainee.create({
    data: {
      firstname_trainee: 'Lucas',
      lastname_trainee: 'Martin',
      email_trainee: 'lucas.martin@example.com',
      password_trainee: 'hashed-password',
      phone_number_trainee: '0612345678',
      school: 'ESGI',
    },
  });

  const internship = await prisma.internship.create({
    data: {
      category: 'Développement Web',
      start_date_internship: new Date('2025-06-01'),
      end_date_internship: new Date('2025-08-31'),
      convention: 'Convention signée PDF',
      trainee: {
        connect: { trainee_id: trainee.trainee_id },
      },
    },
  });

  const project = await prisma.internshipProject.create({
    data: {
      name_project: 'Plateforme de Suivi',
      description_project: 'Application Next.js pour le suivi de stage',
      url_project: 'https://github.com/example/project',
      internship: {
        connect: { internship_id: internship.internship_id },
      },
      trainee: {
        connect: { trainee_id: trainee.trainee_id },
      },
    },
  });

  await prisma.task.create({
    data: {
      task_name: 'Créer le dashboard',
      description_task: 'Page admin avec stats',
      start_date_task: new Date(),
      end_date_task: new Date('2025-07-01'),
      status: false,
      admin: { connect: { admin_id: admin.admin_id } },
      project: { connect: { project_id: project.project_id } },
    },
  });

  await prisma.rapport.create({
    data: {
      week_rapport: new Date('2025-06-07'),
      description_rapport: 'Mise en place du projet et début du front',
      trainee: { connect: { trainee_id: trainee.trainee_id } },
      internship: { connect: { internship_id: internship.internship_id } },
    },
  });

  await prisma.evaluation.create({
    data: {
      date_evaluation: new Date('2025-07-10'),
      remarks: 'Bon début, à suivre',
      grade: 15,
      admin: { connect: { admin_id: admin.admin_id } },
      project: { connect: { project_id: project.project_id } },
    },
  });
}

main()
  .then(() => {
    console.log('✅ Seeding terminé');
    return prisma.$disconnect();
  })
  .catch((e) => {
    console.error(e);
    return prisma.$disconnect();
  });
