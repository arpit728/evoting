package evoting.model;

import evoting.resources.Utility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by arpit on 29/1/17.
 */

public class Login {

    String uniqueId;
    String password;
    String grid;

    @Override
    public String toString() {
        return "Login{" +
                "uniqueId='" + uniqueId + '\'' +
                ", password='" + password + '\'' +
                ", grid='" + grid + '\'' +
                '}';
    }

    public String getUniqueId() {
        return uniqueId;
    }

    public void setUniqueId(String uniqueId) {
        this.uniqueId = uniqueId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGrid() {
        return grid;
    }

    public void setGrid(String grid) {
        this.grid = grid;
    }


    public boolean areAllFieldsFilled(){
        if (grid=="" || grid==null || password=="" || password==null || uniqueId==null || uniqueId=="")
            return false;

        return true;
    }

    public String validate(Connection connection, User user){
        if (!areAllFieldsFilled())return "incomplete";
        try {
            PreparedStatement preparedStatement=connection.prepareStatement("SELECT grid,firstName,lastName,uniqueId,email,mobile FROM user WHERE uniqueId=? AND password=?;");
            preparedStatement.setString(1,uniqueId);
            preparedStatement.setString(2,password);
            ResultSet resultSet=preparedStatement.executeQuery();
            if (resultSet.next()){
                String dbGrid=resultSet.getString(1);
                if (Utility.equalsGrid(dbGrid, this.getGrid()))
                {
                    user.setGrid(dbGrid);
                    user.setFirstName(resultSet.getString(2));
                    user.setLastName(resultSet.getString(3));
                    user.setUniqueId(resultSet.getString(4));
                    user.setEmail(resultSet.getString(5));
                    user.setMobile(resultSet.getString(6));
                    return "success";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Hey, I am the cause of error");
            return "error";
        }

        return "invalid";
    }



}
