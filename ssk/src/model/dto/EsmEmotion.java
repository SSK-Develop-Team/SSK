package model.dto;

public class EsmEmotion {
	
	private int esmEmotionId;
	private EsmType esmType;
	private String esmEmotion;
	private String esmEmotionKr;
	private String esmEmotionIcon;
	
	public int getEsmEmotionId() {
		return esmEmotionId;
	}
	public void setEsmEmotionId(int esmEmotionId) {
		this.esmEmotionId = esmEmotionId;
	}
	public EsmType getEsmType() {
		return esmType;
	}
	public void setEsmType(EsmType esmType) {
		this.esmType = esmType;
	}
	public String getEsmEmotion() {
		return esmEmotion;
	}
	public void setEsmEmotion(String esmEmotion) {
		this.esmEmotion = esmEmotion;
	}
	public String getEsmEmotionKr() {
		return esmEmotionKr;
	}
	public void setEsmEmotionKr(String esmEmotionKr) {
		this.esmEmotionKr = esmEmotionKr;
	}
	public String getEsmEmotionIcon() {
		return esmEmotionIcon;
	}
	public void setEsmEmotionIcon(String esmEmotionIcon) {
		this.esmEmotionIcon = esmEmotionIcon;
	}

}
