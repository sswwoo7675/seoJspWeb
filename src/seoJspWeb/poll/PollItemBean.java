package seoJspWeb.poll;

public class PollItemBean {
	private int listnum; //������ȣ
	private int itemnum; //�����۹�ȣ
	private String[] item; //�����۳���
	private int count;//��ǥ��
	
	public int getListnum() {
		return listnum;
	}
	public void setListnum(int listnum) {
		this.listnum = listnum;
	}
	public int getItemnum() {
		return itemnum;
	}
	public void setItemnum(int itemnum) {
		this.itemnum = itemnum;
	}
	public String[] getItem() {
		return item;
	}
	public void setItem(String[] item) {
		this.item = item;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	
}