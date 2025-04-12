import redis.clients.jedis.Jedis;
import java.util.List;
import java.util.Set;

// Todo los métodos que acceden a Redis están dentro de un bloque try-with-resources, que garantiza que la conexión se cierra automáticamente al finalizar el bloque. Esto es importante para liberar recursos y evitar fugas de memoria.
// La conexión Jedis implementa AutoCloseable, por lo que Java garantiza que jedis.close() se llamará automáticamente al finalizar el bloque try, independientemente de si la operación tuvo éxito o falló con una excepción.

public class RedisService {
    private static final String USERS_SET_KEY = "usuarios:sorteo";
    
    /**
     * Añade un usuario al conjunto de participantes
     * @param username Nombre del usuario
     * @return true si se añadió correctamente, false si ya existía
     */
    public boolean addUser(String username) {
        try (Jedis jedis = RedisConnectionManager.getConnection()) {
            long result = jedis.sadd(USERS_SET_KEY, username);
            return result == 1;
        }
    }
    
    /**
     * Obtiene todos los usuarios participantes
     * @return Conjunto con los nombres de los usuarios
     */
    public Set<String> getAllUsers() {
        try (Jedis jedis = RedisConnectionManager.getConnection()) {
            return jedis.smembers(USERS_SET_KEY);
        }
    }
    
    /**
     * Cuenta el número total de participantes
     * @return Número de participantes
     */
    public long getUsersCount() {
        try (Jedis jedis = RedisConnectionManager.getConnection()) {
            return jedis.scard(USERS_SET_KEY);
        }
    }
    
    /**
     * Selecciona ganadores aleatorios
     * @param count Número de ganadores a seleccionar
     * @return Lista con los nombres de los ganadores
     */
    public List<String> selectRandomWinners(int count) {
        try (Jedis jedis = RedisConnectionManager.getConnection()) {
            return jedis.srandmember(USERS_SET_KEY, count);
        }
    }
    
    /**
     * Elimina todos los usuarios
     */
    public void deleteAllUsers() {
        try (Jedis jedis = RedisConnectionManager.getConnection()) {
            jedis.del(USERS_SET_KEY);
        }
    }
}