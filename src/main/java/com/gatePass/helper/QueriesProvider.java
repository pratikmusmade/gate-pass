package com.gatePass.helper;

public class QueriesProvider {

	public static String queryForStudentInfo = "select  " + "student.id, " + "student.firstName, "
			+ "student.middleName, " + "student.lastName, " + "student.enrolment_number, " + "student.address, "
			+ "student.email, " + "student.pass, " + "student.student_image, " + "branch.branch_name, "
			+ "acc_year.year_name " + "from student " + "inner join branch on student.branch_id = branch.id "
			+ "inner join acc_year on student.year_id = acc_year.id ";

	public static String queryForWardenInfo = "select " + " warden.id , " + " warden.firstName , "
			+ " warden.middleName , " + " warden.lastName , " + " warden.address , " + " warden.email , "
			+ " warden.pass , " + " warden.phoneNumber , " + " warden.warden_image , " + " warden.warden_status , "
			+ " warden.branch_id , " + " warden.year_id, " + " branch.branch_name, " + "acc_year.year_name"
			+ " from warden " + " inner join branch on warden.branch_id = branch.id "
			+ " inner join acc_year on warden.year_id = acc_year.id ";

	public static String queryForStudentInfoWithBranchAndYearId = "select " + "student.id, " + "student.firstName, "
			+ "student.middleName, "
			+ "student.lastName, " 
			+ "student.enrolment_number, " 
			+ "student.address, "
			+ "student.email, "			
			+ "student.phone_number,"  
			+ "student.pass, " + "student.student_image, " + "student.branch_id,"
			+ "branch.branch_name, " + "student.year_id," + "acc_year.year_name " + "from student "
			+ "inner join branch on student.branch_id = branch.id "
			+ "inner join acc_year on student.year_id = acc_year.id ";
	
	
	public static String queryForUpdatingStudent = "UPDATE student SET" + " firstName = ?," + " middleName = ?,"
			+ " lastName = ?,  " + " enrolment_number = ?," + " address = ?," + " email = ?," + " pass = ?,"
			+ " branch_id = ?," + " year_id = ?";

	public static String insertIntoWarden = "insert into warden " + "( firstName ," + "middleName ," + "lastName ,"
			+ "address ," + "email ," + "pass ," + "phoneNumber ," + "warden_image ," + "warden_status ,"
			+ "branch_id ," + "year_id )" + "values(?,?,?,?,?,?,?,?,?,?,?)";

	public static String updateWardenQuery = "UPDATE warden SET " + "firstName  = ? ," + "middleName  = ? ,"
			+ "lastName  = ? ," + "address  = ? ," + "email  = ? ," + "pass  = ? ," + "phoneNumber  = ? ,"
			+ "warden_status  = ? ," + "branch_id = ? ," + "year_id = ? ";

	public static String studentRequestDetail = " SELECT " + "s.id AS student_id, " + "s.firstName, " + "s.middleName, "
			+ "s.lastName, " + "s.enrolment_number, " + "s.address, " + "s.email, " + "s.pass, " + "s.student_image, "
			+ "b.branch_name, " + "ay.year_name, " + "r.id AS request_id, " + "r.message AS request_message, "
			+ "r.warden_id, " + "r.current_date AS request_current_date, " + "r.request_date, "
			+ "r.status AS request_status " + " FROM " + " student AS s " + " JOIN "
			+ "branch AS b ON s.branch_id = b.id " + " JOIN " + " acc_year AS ay ON s.year_id = ay.id " + " JOIN "
			+ " request AS r ON s.id = r.student_id; " + " where r.id = ? ";
}
