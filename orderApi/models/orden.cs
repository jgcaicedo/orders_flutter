//modelo de orden




namespace orderApi.models
{
    public class Orden
    {
        public int Id { get; set; }
        public int PacienteId { get; set; }
        public DateTime FechaAtencion { get; set; }

        // Relación con paciente
        public Paciente Paciente { get; set; } = null!;

        // Relación con examenes
        public List<Examen> Examenes { get; set; } = new List<Examen>();
    }
}