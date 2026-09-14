-- CreateEnum
CREATE TYPE "ReportStatusTypes" AS ENUM ('pending', 'review_required', 'completed', 'failed');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Report" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "dates" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" "ReportStatusTypes" NOT NULL,

    CONSTRAINT "Report_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ChartDescriptions" (
    "id" SERIAL NOT NULL,
    "chartType" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "trendType" TEXT,
    "severity" TEXT,
    "possibleActions" JSONB,
    "changeReason" TEXT,
    "reportId" INTEGER,

    CONSTRAINT "ChartDescriptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReportTrendsSummary" (
    "id" SERIAL NOT NULL,
    "summary" TEXT NOT NULL,
    "highlights" JSONB,
    "risks" JSONB,
    "recommendedActions" JSONB,
    "reportId" INTEGER,

    CONSTRAINT "ReportTrendsSummary_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ticket" (
    "id" SERIAL NOT NULL,
    "topdeskId" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "subCategory" TEXT,
    "systems" JSONB NOT NULL DEFAULT '[]',
    "issue_types" JSONB NOT NULL DEFAULT '[]',
    "briefDescriptionAI" TEXT,
    "callerLocation" TEXT,
    "callerDepartment" TEXT,
    "callerRole" TEXT,
    "operatorName" TEXT,
    "operatorGroup" TEXT,
    "closed" BOOLEAN NOT NULL,
    "closedDate" TIMESTAMP(3),
    "completed" BOOLEAN NOT NULL,
    "completedDate" TIMESTAMP(3),
    "responded" BOOLEAN NOT NULL,
    "respondedDate" TIMESTAMP(3),
    "creationDate" TIMESTAMP(3) NOT NULL,
    "callDate" TIMESTAMP(3),
    "status" TEXT,
    "entryType" TEXT NOT NULL,
    "impact" TEXT,
    "urgency" TEXT,
    "priority" TEXT,
    "briefDescription" TEXT,
    "latestUpdate" TIMESTAMP(3),
    "latestUpdateBy" TEXT,
    "reportId" INTEGER,

    CONSTRAINT "Ticket_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "Report_createdAt_idx" ON "Report"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "ChartDescriptions_reportId_chartType_key" ON "ChartDescriptions"("reportId", "chartType");

-- CreateIndex
CREATE UNIQUE INDEX "ReportTrendsSummary_reportId_key" ON "ReportTrendsSummary"("reportId");

-- CreateIndex
CREATE INDEX "Ticket_category_idx" ON "Ticket"("category");

-- CreateIndex
CREATE INDEX "Ticket_subCategory_idx" ON "Ticket"("subCategory");

-- CreateIndex
CREATE INDEX "Ticket_creationDate_idx" ON "Ticket"("creationDate");

-- CreateIndex
CREATE INDEX "Ticket_closed_idx" ON "Ticket"("closed");

-- CreateIndex
CREATE INDEX "Ticket_completed_idx" ON "Ticket"("completed");

-- CreateIndex
CREATE INDEX "Ticket_status_idx" ON "Ticket"("status");

-- CreateIndex
CREATE INDEX "Ticket_entryType_idx" ON "Ticket"("entryType");

-- CreateIndex
CREATE INDEX "Ticket_priority_idx" ON "Ticket"("priority");

-- CreateIndex
CREATE INDEX "Ticket_callerDepartment_idx" ON "Ticket"("callerDepartment");

-- AddForeignKey
ALTER TABLE "ChartDescriptions" ADD CONSTRAINT "ChartDescriptions_reportId_fkey" FOREIGN KEY ("reportId") REFERENCES "Report"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReportTrendsSummary" ADD CONSTRAINT "ReportTrendsSummary_reportId_fkey" FOREIGN KEY ("reportId") REFERENCES "Report"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_reportId_fkey" FOREIGN KEY ("reportId") REFERENCES "Report"("id") ON DELETE SET NULL ON UPDATE CASCADE;
