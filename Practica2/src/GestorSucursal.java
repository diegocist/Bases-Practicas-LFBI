import java.io.File;
import java.io.IOException;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

/**
 * Clase encargada de la gestión de la entidad Sucursal y la persistencia
 * de sus datos en un archivo de texto con formato CSV.
 * Proporciona las operaciones para crear, leer, actualizar y eliminar objetos
 * de la clase {@link Sucursal}.
 */
public class GestorSucursal {

    /**
     * Ruta del archivo CSV en el sistema de archivos donde se persisten las
     * sucursales.
     */
    private final String rutaArchivo;

    /**
     * Inicializa el gestor configurando la ruta del archivo y asegurando
     * su existencia en el disco.
     *
     * @param rutaArchivo Ruta relativa o absoluta del archivo CSV de sucursales.
     */
    public GestorSucursal(String rutaArchivo) {
        this.rutaArchivo = rutaArchivo;
        verificarArchivo();
    }

    /**
     * Verifica si el archivo CSV existe en la ruta especificada
     * Si no existe, se crea e inserta el encabezado correspondiente.
     */
    private void verificarArchivo() {
        try {
            File archivo = new File(this.rutaArchivo);

            if (!archivo.exists() || archivo.length() == 0) {
                archivo.createNewFile();

                try (BufferedWriter bw = new BufferedWriter(new FileWriter(archivo))) {
                    bw.write(
                            "idSucursal,nombre,calle,numeroInt,numeroExt,colonia,estado,telefono,horarioApertura,horarioCierre");
                    bw.newLine();
                }

                System.out.println("Archivo creado en la ruta: " + archivo.getAbsolutePath());
            }
        } catch (IOException e) {
            System.out.println("Error al encontrar o crear el archivo: " + e.getMessage());
        }
    }

    /**
     * Agrega un nuevo registro de sucursal al final del archivo CSV.
     *
     * @param suc Objeto {@link Sucursal} con los datos a registrar.
     * @return {@code true} si la sucursal se guardó con éxito;
     *         {@code false} si la llave ya existe o ocurrio algún error.
     */
    public void agregar(Sucursal suc) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(this.rutaArchivo, true))) {
            bw.write(suc.toCSV());
            bw.newLine();

            System.out.println("La sucursal se guardó correctamente.");
        } catch (IOException e) {
            System.out.println("Error al escribir en el archivo: " + e.getLocalizedMessage());
        }
    }

    /**
     * Consulta una sucursal específica en el archivo CSV utilizando la llave
     * primaria.
     *
     * @param idSucursal Identificador correspondiente a la sucursal buscada.
     * @return El objeto {@link Sucursal} si es localizado; de lo contrario
     *         {@code null} si no se encuentra.
     */
    public Sucursal buscarPorLlave(String idSucursal) {
        try (BufferedReader br = new BufferedReader(new FileReader(this.rutaArchivo))) {
            String linea;

            br.readLine();

            while ((linea = br.readLine()) != null) {
                if (linea.trim().isEmpty())
                    continue;

                String[] r = linea.split(",");
                if (r[0].trim().equals(idSucursal.trim())) {
                    return Sucursal.fromCSV(linea);
                }
            }

        } catch (IOException e) {
            System.out.println("Error al leer el archivo: " + e.getMessage());
        }
        return null;
    }

    /**
     * Carga y retorna la lista completa de sucursales registradas en el archivo
     * CSV.
     *
     * @return {@link List} con los objetos {@link Sucursal} almacenados.
     */
    public List<Sucursal> obtenerTodas() {
        List<Sucursal> listaSuc = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(this.rutaArchivo))) {
            String linea;

            br.readLine();

            while ((linea = br.readLine()) != null) {
                if (!linea.trim().isEmpty()) {
                    listaSuc.add(Sucursal.fromCSV(linea));
                }
            }

        } catch (IOException e) {
            System.out.println("Error al leer el archivo: " + e.getMessage());
        }
        return listaSuc;
    }

    /**
     * Sobrescribe en su totalidad el archivo CSV actualizando su contenido con la
     * lista provista
     * y preservando la fila de encabezados inicial.
     *
     * @param lista Lista actualizada de objetos {@link Sucursal} a persistir.
     */
    private void sobrescribirArchivo(List<Sucursal> lista) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(this.rutaArchivo, false))) {
            bw.write(
                    "idSucursal,nombre,calle,numeroInt,numeroExt,colonia,estado,telefono,horarioApertura,horarioCierre");
            bw.newLine();

            for (Sucursal suc : lista) {
                bw.write(suc.toCSV());
                bw.newLine();
            }
        } catch (IOException e) {
            System.out.println("No se pudo actualizar el archivo: " + e.getMessage());
        }
    }

    /**
     * Modifica los datos de una sucursal existente en el archivo CSV a partir de su
     * identificador.
     *
     * @param suc Objeto {@link Sucursal} con los datos actualizados.
     * @return {@code true} si la actualización fue exitosa; {@code false} si la
     *         sucursal no existe.
     */
    public boolean editar(Sucursal suc) {
        List<Sucursal> list = obtenerTodas();
        boolean encontrada = false;

        int i = 0;
        String idSuc = suc.getIdSucursal().trim();
        while ((encontrada == false) && i < list.size()) {
            String idTmp = list.get(i).getIdSucursal().trim();
            if (idTmp.equals(idSuc)) {
                list.set(i, suc);
                encontrada = true;
            }
            i++;
        }
        if (encontrada) {
            sobrescribirArchivo(list);
            System.out.println("Sucursal actualizada correctamente");
            return true;
        } else {
            System.out.println("No existe la sucursal a editar");
            return false;
        }
    }

    /**
     * Elimina un registro de sucursal del archivo CSV haciendo coincidir su
     * identificador.
     *
     * @param idSuc Identificador de la sucursal a remover.
     * @return {@code true} si se eliminó el registro; {@code false} si no fue
     *         localizado.
     */
    public boolean eliminar(String idSuc) {
        List<Sucursal> list = obtenerTodas();
        boolean encontrada = false;

        int i = 0;
        while ((encontrada == false) && i < list.size()) {
            String idTmp = list.get(i).getIdSucursal().trim();
            if (idTmp.equals(idSuc.trim())) {
                list.remove(i);
                encontrada = true;
            }
            i++;
        }
        if (encontrada) {
            sobrescribirArchivo(list);
            System.out.println("Sucursal eliminada correctamente");
            return true;
        } else {
            System.out.println("No se encontró ninguna sucursal con ID: " + idSuc);
            return false;
        }
    }
}