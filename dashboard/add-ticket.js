const { PrismaClient } = require("./prisma/generated/prisma");

const prisma = new PrismaClient();

async function main() {
  const report = await prisma.report.create({
    data: {
      title: "KRAT Test Report",
      dates: ["2026-09-21"],
      status: "pending",
    },
  });

  const ticket = await prisma.ticket.create({
    data: {
      topdeskId: "KRAT-TEST-001",
      category: "Hardware",
      subCategory: "Laptop",
      systems: ["Laptop"],
      issue_types: ["hardware"],
      briefDescriptionAI: "Laptop does not start",
      callerDepartment: "IT",
      callerRole: "Employee",
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
      briefDescription: "Laptop does not start",
      latestUpdate: new Date(),
      latestUpdateBy: "KRAT Test",
      reportId: report.id,
    },
  });

  console.log("Report created:", report.id);
  console.log("Ticket created:", ticket.id);
  console.log("TOPdesk ID:", ticket.topdeskId);
}

main()
  .catch((error) => {
    console.error(error);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
