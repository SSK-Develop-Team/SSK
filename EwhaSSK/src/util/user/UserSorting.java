package util.user;

import java.util.Comparator;

import model.dto.User;

/*
 * @author Lee Ji Won
 * 아동 조회 시 기준에 따라 정렬
 * 이름 순 정렬 - AscendingByUserName Class
 * 나이 순 정렬
 * 등록 순 정렬(오름차순)
 * 등록 순 정렬(내림차순)
 */
public class UserSorting {

}

class AscendingByUserName implements Comparator<User>{
	public int compare(User c1, User c2)
	{
		return c1.getUserName().compareTo(c2.getUserName());
	}
}

class AscendingByAge implements Comparator<User>{
	public int compare(User c1, User c2)
	{
		return c1.getCurrentAge()-c2.getCurrentAge();
	}
}

class AscendingById implements Comparator<User>{
	public int compare(User c1, User c2)
	{
		return c1.getUserId()-c2.getUserId();
	}
}

class DescendingById implements Comparator<User>{
	public int compare(User c1, User c2)
	{
		return c2.getUserId()-c1.getUserId();
	}
}