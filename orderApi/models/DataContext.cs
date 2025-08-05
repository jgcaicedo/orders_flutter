using Microsoft.EntityFrameworkCore;

namespace orderApi.models
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options) { }

        public DbSet<Orden> Ordenes { get; set; }
        public DbSet<Paciente> Pacientes { get; set; }
        public DbSet<Examen> Examenes { get; set; }
        public DbSet<OrdenExamen> OrdenesExamenes { get; set; }
    }
}
