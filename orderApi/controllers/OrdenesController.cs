







using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace orderApi.controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class OrdenesController : ControllerBase
    {
        private readonly IOrdenesService _ordenesService;
        private readonly ILogger<OrdenesController> _logger;

        public OrdenesController(IOrdenesService ordenesService, ILogger<OrdenesController> logger)
        {
            _ordenesService = ordenesService;
            _logger = logger;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<OrdenResDto>>> GetOrdenes()
        {
            try
            {
                var ordenes = await _ordenesService.GetOrdenesAsync();
                return Ok(ordenes);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error retrieving orders");
                return StatusCode(500, "Internal server error");
            }
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<OrdenResDto>> GetOrdenById(int id)
        {
            try
            {
                _logger.LogInformation("Retrieving order with ID {Id}", id);
                var orden = await _ordenesService.GetOrdenByIdAsync(id);
                if (orden == null)
                {
                    _logger.LogWarning("Order with ID {Id} not found", id);
                    return NotFound();
                }
                return Ok(orden);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error retrieving order with ID {Id}", id);
                return StatusCode(500, "Internal server error");
            }
        }

        [HttpPost]
        public async Task<ActionResult<OrdenResDto>> CrearOrden([FromBody] CrearOrdenDto crearOrdenDto)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    _logger.LogWarning("Invalid model state for order creation");
                    return BadRequest(ModelState);
                }
                _logger.LogInformation("Creating new order for patient ID {PacienteId}", crearOrdenDto.PacienteId);
                var ordenCreada = await _ordenesService.CrearOrdenAsync(crearOrdenDto);
                return CreatedAtAction(nameof(GetOrdenById), new { id = ordenCreada.Id }, ordenCreada);
            }
            catch (ArgumentNullException ex)
            {
                _logger.LogError(ex, "Invalid data provided for order creation");
                return BadRequest("Invalid data provided.");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error creating order");
                return StatusCode(500, "Internal server error");
            }
        }

        [HttpGet("paciente/{pacienteId}/count")]
        public async Task<ActionResult<int>> GetOrdenCountByPacienteId(int pacienteId)
        {
            try
            {
                var count = await _ordenesService.GetOrdenCountAsync(pacienteId);
                return Ok(count);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error retrieving order count for patient ID {PacienteId}", pacienteId);
                return StatusCode(500, "Internal server error");
            }
        }
    }
}