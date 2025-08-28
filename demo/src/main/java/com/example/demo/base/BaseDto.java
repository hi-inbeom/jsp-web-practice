package com.example.demo.base;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BaseDto {
    private String regDate; // "yyyy-MM-dd HH:mm:ss"
    private String modDate; // "yyyy-MM-dd HH:mm:ss"

    public BaseDto() {}

    public BaseDto(BaseVo baseVo) {
        this.regDate = (baseVo.getRegDate() != null)
		        		? baseVo.getRegDate().toString()
        				: "null";
        this.modDate = (baseVo.getModDate() != null)
		        		? baseVo.getModDate().toString()
						: "null";
    }

	@Override
	public String toString() {
		return "BaseDto [regDate=" + regDate + ", modDate=" + modDate + "]";
	}
}
