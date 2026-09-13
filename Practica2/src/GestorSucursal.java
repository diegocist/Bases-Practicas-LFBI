import java.io.File;
import java.io.IOException;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

public class GestorSucursal {
    private final String rutaArchivo;

    public GestorSucursal(String rutaArchivo) {
        this.rutaArchivo = rutaArchivo;
        verificarArchivo();
    }

    private void verificarArchivo() {
        try {
            // Creamo un objeto File con la ruta dada
            File archivo = new File(this.rutaArchivo);

            // Si el archivo no existe entonces lo creamos
            if (!archivo.exists()) {
                archivo.createNewFile();

                // Escribimos la estructura de las columnas en la primera línea
                try (BufferedWriter bw = new BufferedWriter(new FileWriter(archivo))) {
                    bw.write(
                            "idSucursal,nombre,calle,numeroInt,numeroExt,colonia,estado,telefono,horarioApertura,horarioCierre");
                    bw.newLine();
                }

                System.out.println("Archivo creando en la ruta: " + archivo.getAbsolutePath());
            }
        } catch (IOException e) { // Cachamos la excepcion
            System.out.println("Error al encontrar o crear el archivo: " + e.getMessage());
        }
    }

    // Agregamos el primer metodo para agregar una Sucursal
    public void agregar(Sucursal suc) {
        // Cachamos las excepcines y el archivo se cieerra automaticamente al terminar
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(this.rutaArchivo, true))) {
            bw.write(suc.toCSV());
            bw.newLine(); // Saltamos una linea para que la siguiente sucursal este en otro linea

            System.out.println("La sucursal se guardo correctamente.");
        } catch (IOException e) {
            System.out.println("Error al escribir en el archivo: " + e.getLocalizedMessage());
        }
    }

    // Agregamos el metodo de buscar por llave
    public Sucursal buscarPorLlave(String idSucursal) {
        try (BufferedReader br = new BufferedReader(new FileReader(this.rutaArchivo))) {
            String linea;

            // Omitimos la primera línea que contiene los encabezados
            br.readLine();

            // Leemos hasta que ya no haya más informacion guardad
            while ((linea = br.readLine()) != null) {
                if (linea.trim().isEmpty())
                    continue; // Saltamos posibles líneas en blanco

                // Cambié el split(",", 2) por split(",") para que separe toda la línea
                // correctamente
                String[] r = linea.split(",");
                // Usamos trim() en ambos lados para evitar errores por espacios invisibles
                if (r[0].trim().equals(idSucursal.trim())) {
                    return Sucursal.fromCSV(linea);
                }
            }

        } catch (IOException e) {
            System.out.println("Error al leer el archivo: " + e.getMessage());
        }
        return null;
    }

    public List<Sucursal> obtenerTodas() {
        List<Sucursal> listaSuc = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(this.rutaArchivo))) {
            String linea;

            // Omitimos la primera línea que contiene los encabezados
            br.readLine();

            while ((linea = br.readLine()) != null) {
                if (!linea.trim().isEmpty()) { // Validamos que no sea una línea vacía
                    listaSuc.add(Sucursal.fromCSV(linea));
                }
            }

        } catch (IOException e) {
            System.out.println("Error al leer el archivo: " + e.getMessage());
        }
        return listaSuc;
    }
}
