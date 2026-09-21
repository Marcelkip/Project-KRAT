
const { PrismaClient, ReportStatusTypes } = require("./prisma/generated/prisma");

const prisma = new PrismaClient();

async function main() {
  console.log("Creating test report...");

  const report = await prisma.report.create({
    data: {
      title: "Database Test Report",
      dates: ["2026-09-18"],
      status: ReportStatusTypes.pending,
    },
  });

  console.log("Created report:", report.id);

  const ticket1 = await prisma.ticket.create({
    data: {
      topdeskId: "TEST-001",
      category: "Hardware",
      subCategory: "Laptop",

      systems: ["Laptop"],
      issue_types: ["hardware"],
      briefDescriptionAI: "Test laptop issue",

      callerLocation: "Test location",
      callerDepartment: "IT",
      callerRole: "Employee",

      operatorName: "Test Operator",
      operatorGroup: "IT Support",

      closed: false,
      completed: false,
      responded: true,

      creationDate: new Date(),
      callDate: new Date(),

      status: "Open",
      entryType: "self_service",
      impact: "medium",
      urgency: "medium",
      priority: "medium",

      briefDescription: "Test ticket",

      latestUpdate: new Date(),
      latestUpdateBy: "Test Operator",

      reportId: report.id,
    },
  });

  const ticket2 = await prisma.ticket.create({
    data: {
      topdeskId: "TEST-002",
      category: "Software",

      systems: ["Windows"],
      issue_types: ["software"],
      briefDescriptionAI: "Test software issue",

      closed: true,
      completed: true,
      responded: true,

      creationDate: new Date(),

      status: "Closed",
      entryType: "mail",
      priority: "low",

      reportId: report.id,
    },
  });

  console.log("Created tickets:", ticket1.id, ticket2.id);

  const result = await prisma.report.findUnique({
    where: {
      id: report.id,
    },
    include: {
      tickets: true,
    },
  });

  console.log("\nReport with tickets:");
  console.dir(result, { depth: null });

  await prisma.ticket.deleteMany({
    where: {
      reportId: report.id,
    },
  });

  await prisma.report.delete({
    where: {
      id: report.id,
    },
  });

  console.log("\nTest data deleted.");
}

main()
  .catch((error) => {
    console.error(error);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
