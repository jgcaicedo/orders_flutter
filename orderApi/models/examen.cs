//modelo de examen
namespace orderApi.models
{
    public class Examen
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public string Codigo { get; set; } = string.Empty;
        public string Descripcion { get; set; } = string.Empty;
        public DateTime Fecha { get; set; }
        public int PacienteId { get; set; }
    }
}