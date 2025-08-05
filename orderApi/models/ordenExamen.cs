//modelo de relacion entre ordenes y examenes
namespace orderApi.models
{
    public class OrdenExamen
    {
        public int OrdenExamenId { get; set; }
        public int ExamenId { get; set; }
        public int OrdenId { get; set; }
        //relacion con orden 
        public Orden Orden { get; set; } = null!;
        //relacion con examen
        public Examen Examen { get; set; } = null!;
    }
}
