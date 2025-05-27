-- CreateTable
CREATE TABLE "Admin" (
    "admin_id" SERIAL NOT NULL,
    "firstname_admin" TEXT NOT NULL,
    "lastname_admin" TEXT NOT NULL,
    "password_admin" TEXT NOT NULL,
    "email_admin" TEXT NOT NULL,
    "phone_number_admin" TEXT NOT NULL,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("admin_id")
);

-- CreateTable
CREATE TABLE "Trainee" (
    "trainee_id" SERIAL NOT NULL,
    "firstname_trainee" TEXT NOT NULL,
    "lastname_trainee" TEXT NOT NULL,
    "password_trainee" TEXT NOT NULL,
    "email_trainee" TEXT NOT NULL,
    "phone_number_trainee" TEXT NOT NULL,
    "school" TEXT NOT NULL,

    CONSTRAINT "Trainee_pkey" PRIMARY KEY ("trainee_id")
);

-- CreateTable
CREATE TABLE "Internship" (
    "internship_id" SERIAL NOT NULL,
    "category" TEXT NOT NULL,
    "start_date_internship" TIMESTAMP(3) NOT NULL,
    "end_date_internship" TIMESTAMP(3) NOT NULL,
    "convention" TEXT,
    "trainee_id" INTEGER NOT NULL,

    CONSTRAINT "Internship_pkey" PRIMARY KEY ("internship_id")
);

-- CreateTable
CREATE TABLE "InternshipProject" (
    "project_id" SERIAL NOT NULL,
    "name_project" TEXT NOT NULL,
    "description_project" TEXT,
    "url_project" TEXT,
    "internship_id" INTEGER NOT NULL,
    "trainee_id" INTEGER NOT NULL,

    CONSTRAINT "InternshipProject_pkey" PRIMARY KEY ("project_id")
);

-- CreateTable
CREATE TABLE "Task" (
    "task_id" SERIAL NOT NULL,
    "task_name" TEXT NOT NULL,
    "description_task" TEXT,
    "start_date_task" TIMESTAMP(3) NOT NULL,
    "end_date_task" TIMESTAMP(3) NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "admin_id" INTEGER,
    "trainee_id" INTEGER,
    "project_id" INTEGER,

    CONSTRAINT "Task_pkey" PRIMARY KEY ("task_id")
);

-- CreateTable
CREATE TABLE "Evaluation" (
    "evaluation_id" SERIAL NOT NULL,
    "date_evaluation" TIMESTAMP(3) NOT NULL,
    "remarks" TEXT NOT NULL,
    "grade" INTEGER NOT NULL,
    "admin_id" INTEGER NOT NULL,
    "project_id" INTEGER NOT NULL,

    CONSTRAINT "Evaluation_pkey" PRIMARY KEY ("evaluation_id")
);

-- CreateTable
CREATE TABLE "Rapport" (
    "rapport_id" SERIAL NOT NULL,
    "week_rapport" TIMESTAMP(3) NOT NULL,
    "description_rapport" TEXT NOT NULL,
    "trainee_id" INTEGER NOT NULL,
    "internship_id" INTEGER NOT NULL,

    CONSTRAINT "Rapport_pkey" PRIMARY KEY ("rapport_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Admin_email_admin_key" ON "Admin"("email_admin");

-- CreateIndex
CREATE UNIQUE INDEX "Trainee_email_trainee_key" ON "Trainee"("email_trainee");

-- AddForeignKey
ALTER TABLE "Internship" ADD CONSTRAINT "Internship_trainee_id_fkey" FOREIGN KEY ("trainee_id") REFERENCES "Trainee"("trainee_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InternshipProject" ADD CONSTRAINT "InternshipProject_internship_id_fkey" FOREIGN KEY ("internship_id") REFERENCES "Internship"("internship_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InternshipProject" ADD CONSTRAINT "InternshipProject_trainee_id_fkey" FOREIGN KEY ("trainee_id") REFERENCES "Trainee"("trainee_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "Admin"("admin_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_trainee_id_fkey" FOREIGN KEY ("trainee_id") REFERENCES "Trainee"("trainee_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "InternshipProject"("project_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Evaluation" ADD CONSTRAINT "Evaluation_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "Admin"("admin_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Evaluation" ADD CONSTRAINT "Evaluation_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "InternshipProject"("project_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rapport" ADD CONSTRAINT "Rapport_trainee_id_fkey" FOREIGN KEY ("trainee_id") REFERENCES "Trainee"("trainee_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rapport" ADD CONSTRAINT "Rapport_internship_id_fkey" FOREIGN KEY ("internship_id") REFERENCES "Internship"("internship_id") ON DELETE RESTRICT ON UPDATE CASCADE;
