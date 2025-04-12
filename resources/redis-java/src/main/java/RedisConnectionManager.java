import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class RedisConnectionManager {
    private static final String REDIS_HOST = "localhost";
    private static final int REDIS_PORT = 6379;
    private static JedisPool jedisPool;
    
    static {
        // Configuración del pool de conexiones
        JedisPoolConfig poolConfig = new JedisPoolConfig();
        poolConfig.setMaxTotal(10);
        poolConfig.setMaxIdle(5);
        poolConfig.setMinIdle(1);
        
        jedisPool = new JedisPool(poolConfig, REDIS_HOST, REDIS_PORT);
    }
    
    /**
     * Obtiene una conexión del pool de conexiones
     * @return Conexión Jedis
     */
    public static Jedis getConnection() {
        return jedisPool.getResource();
    }
    
    /**
     * Cierra el pool de conexiones
     */
    public static void closePool() {
        if (jedisPool != null) {
            jedisPool.close();
        }
    }
    
    /**
     * Comprueba si la conexión a Redis está activa
     * @return true si está activa, false en caso contrario
     */
    public static boolean isConnected() {
        try (Jedis jedis = getConnection()) {
            return jedis.ping().equalsIgnoreCase("PONG");
        } catch (Exception e) {
            return false;
        }
    }
}