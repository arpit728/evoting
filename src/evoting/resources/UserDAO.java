package evoting.resources;

import evoting.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by arpit on 31/1/17.
 */
public class UserDAO {

    public static String  addUser(User user,Connection connection){

        try {
            PreparedStatement statement=connection.prepareStatement("INSERT INTO user(" +
                    "firstName,lastName,email,mobile,uniqueId,grid,password)" +
                    "VALUES(?,?,?,?,?,?,?) ");
            statement.setString(1,user.getFirstName());
            statement.setString(2,user.getLastName());
            statement.setString(3,user.getEmail());
            statement.setString(4,user.getMobile());
            statement.setString(5,user.getUniqueId());
            statement.setString(6,user.getGrid());
            statement.setString(7,user.getPassword());
            int  result=statement.executeUpdate();
            System.out.println(result);
            System.out.println(statement.getUpdateCount()+" rows updated");
            if (result>0){
                return "success";
            }
        } catch (SQLException e) {
            System.out.println(e);
            e.printStackTrace();
        }
        return "error";
    }

    public static boolean ifAllValuesFilled(User user) {
        if ((user.getFirstName() != null) && (user.getLastName() != null) && (user.getMobile() != null) && (user.getUniqueId() != null) )
            return true;

        return false;
    }

    public static boolean isAlreadyRegistered(User user, Connection connection) {

        PreparedStatement statement= null;
        System.out.println(connection);
        try {
            statement = connection.prepareStatement("SELECT * FROM user WHERE email=? or uniqueId=? or mobile=?");
            statement.setString(1,user.getEmail());
            statement.setString(2,user.getUniqueId());
            statement.setString(3,user.getMobile());
            ResultSet rs= statement.executeQuery();
            if (rs.next()){
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static String addVote(Connection connection,User user,String encryptedVote,String hashedVote){

        if (hasVoted(connection,user)){
            return "voted";
        }

        try {
            PreparedStatement statement=connection.prepareStatement("update user set encryptedVote =?,hashedVote=? where uniqueId =?");
            statement.setString(1,encryptedVote);
            statement.setString(2,hashedVote);
            statement.setString(3,user.getUniqueId());
            if (statement.executeUpdate()==1){
                return "success";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "error";
    }

    private static boolean hasVoted(Connection connection, User user) {

        try {
            PreparedStatement statement=connection.prepareStatement("select * from user WHERE encryptedVote is not NULL AND hashedVote is NOT NULL AND uniqueId=?");
            statement.setString(1,user.getUniqueId());
            ResultSet rs=statement.executeQuery();
            if (rs.next()){
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public static void deleteUser(String uniqueId,Connection connection) {

        try {
            PreparedStatement statement=connection.prepareStatement("DELETE  FROM user WHERE uniqueId=?");
            statement.setString(1,uniqueId);
            statement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
