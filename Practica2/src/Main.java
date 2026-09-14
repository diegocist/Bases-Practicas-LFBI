import java.util.Scanner;

public class Main {
        private Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        Main menu = new Main();
        menu.mostrarMenuPrincipal();
    }

    public void mostrarMenuPrincipal() {

        MenuPremio premios = new MenuPremio();
        MenuSucursal sucursales = new MenuSucursal();

        System.out.println("████  █   █ █████ █     █      ███      ███   ███  █   █ █████ ");
        System.out.println("█   █ █   █ █     █     █     █   █    █     █   █ ██ ██ █    "); 
        System.out.println("████  █   █ ████  █     █     █████    █  ██ █████ █ █ █ ████  ");
        System.out.println("█     █   █ █     █     █     █   █    █   █ █   █ █   █ █    "); 
        System.out.println("█      ███  █████ █████ █████ █   █     ███  █   █ █   █ █████ ");

        int opcion = -1;
        while (opcion != 4) {
            System.out.println("\n1. Sucursales");
            System.out.println("2. Premios");
            System.out.println("3. Clientes");
            System.out.println("4. Salir");
            opcion = leerInt("\nElige una opción: ");
            
            switch (opcion) {
                case 1: sucursales.menuSucursales(); break;
                case 2: premios.menuPremios(); break;
                case 3: break;
                case 4: System.out.println("\nHasta luego :)"); break;
                default: System.out.println("\\nIngresa un número del 1-4");
            }
        }
    }

    /**
     * Muestra un mensaje al usuario y lee un número entero desde consola.
     * Repite la petición hasta que se ingrese un valor válido.
     *
     * @param mensaje texto ingresado el usuario
     * @return el número tipo int ingresado por el usuario
     */
    private int leerInt(String mensaje) {
        while (true) {
            try {
                System.out.print(mensaje);
                return Integer.parseInt(scanner.nextLine().trim());
            } catch (NumberFormatException e) {
                System.out.println("Ingresa un número entero");
            }
        }
    }
}