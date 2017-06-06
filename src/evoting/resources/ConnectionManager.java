package evoting.resources;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Created by arpit on 29/1/17.
 */
public class ConnectionManager {

    private Connection connection;

    public ConnectionManager(String connectionUrl, String userName, String password)
            throws ClassNotFoundException, SQLException {

        Class.forName("com.mysql.jdbc.Driver");
        this.connection = DriverManager.getConnection(connectionUrl, userName, password);
    }

    public Connection getConnection(){
        return this.connection;
    }

}
