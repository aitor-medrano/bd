import java.util.List;
import java.util.Scanner;
import java.util.Set;

public class RedisApp {
    private static final int SORTEO_CONCURSANTES = 3;
    private static RedisService sorteoService = new RedisService();
    
    public static void main(String[] args) {
        if (!RedisConnectionManager.isConnected()) {
            System.err.println("Error: No se pudo conectar a Redis. Verifica que el servidor esté en funcionamiento.");
            return;
        }
        
        System.out.println("Conectado a Redis correctamente.");
        
        try (Scanner scanner = new Scanner(System.in)) {
            boolean running = true;
            while (running) {
                System.out.println("\n--- Aplicación de Sorteo ---");
                System.out.println("1. Añadir usuario");
                System.out.println("2. Ver todos los usuarios");
                System.out.println("3. Realizar sorteo (3 ganadores)");
                System.out.println("4. Borrar todos los usuarios");
                System.out.println("5. Salir");
                System.out.print("Elige una opción: ");
                
                String option = scanner.nextLine();
                
                switch (option) {
                    case "1":
                        addUser(scanner);
                        break;
                    case "2":
                        displayAllUsers();
                        break;
                    case "3":
                        selectWinners();
                        break;
                    case "4":
                        deleteAllUsers(scanner);
                        break;
                    case "5":
                        running = false;
                        System.out.println("¡Hasta pronto!");
                        RedisConnectionManager.closePool();
                        break;
                    default:
                        System.out.println("Opción no válida. Inténtalo de nuevo.");
                }
            }
        } catch (Exception e) {
            System.err.println("Error en la aplicación: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    private static void addUser(Scanner scanner) {
        System.out.print("Introduce el nombre del usuario: ");
        String username = scanner.nextLine().trim();
        
        if (username.isEmpty()) {
            System.out.println("El nombre no puede estar vacío.");
            return;
        }
        
        boolean added = sorteoService.addUser(username);
        if (added) {
            System.out.println("Usuario añadido correctamente.");
        } else {
            System.out.println("El usuario ya existe en el sorteo.");
        }
    }
    
    private static void displayAllUsers() {
        System.out.println("\n--- Lista de Participantes ---");
        long count = sorteoService.getUsersCount();
        
        if (count == 0) {
            System.out.println("No hay usuarios registrados.");
            return;
        }
        
        System.out.println("Total de participantes: " + count);
        int i = 1;
        Set<String> users = sorteoService.getAllUsers();
        for (String username : users) {
            System.out.println(i + ". " + username);
            i++;
        }
    }
    
    private static void selectWinners() {
        long totalUsers = sorteoService.getUsersCount();
        
        if (totalUsers == 0) {
            System.out.println("No hay usuarios para realizar el sorteo.");
            return;
        }
        
        int winnersCount = Math.min(SORTEO_CONCURSANTES, (int) totalUsers);
        
        System.out.println("\n--- Realizando sorteo para " + winnersCount + " ganadores ---");
        
        List<String> winners = sorteoService.selectRandomWinners(winnersCount);
        
        System.out.println("\n¡Felicidades a los ganadores!");
        String[] prizes = {"Primer premio 🏆", "Segundo premio 🥈", "Tercer premio 🥉"};
        
        for (int i = 0; i < winners.size(); i++) {
            System.out.println(prizes[i] + ": " + winners.get(i));
        }
    }
    
    private static void deleteAllUsers(Scanner scanner) {
        System.out.print("¿Estás seguro de borrar todos los usuarios? (s/n): ");
        String confirmation = scanner.nextLine();
        
        if (confirmation.equalsIgnoreCase("s")) {
            sorteoService.deleteAllUsers();
            System.out.println("Todos los usuarios han sido eliminados.");
        } else {
            System.out.println("Operación cancelada.");
        }
    }
}