package model.dto;

public class SdqReply {
	
	private int sdqReplyId;
	private int sdqTestLogId;
	private int sdqQuestionId;
	private String sdqReplyContent;
	
	public int getSdqReplyId() {
		return sdqReplyId;
	}
	public void setSdqReplyId(int sdqReplyId) {
		this.sdqReplyId = sdqReplyId;
	}
	public int getSdqTestLogId() {
		return sdqTestLogId;
	}
	public void setSdqTestLogId(int sdqTestLogId) {
		this.sdqTestLogId = sdqTestLogId;
	}
	public int getSdqQuestionId() {
		return sdqQuestionId;
	}
	public void setSdqQuestionId(int sdqQuestionId) {
		this.sdqQuestionId = sdqQuestionId;
	}
	public String getSdqReplyContent() {
		return sdqReplyContent;
	}
	public void setSdqReplyContent(String sdqReplyContent) {
		this.sdqReplyContent = sdqReplyContent;
	}

}
