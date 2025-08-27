package com.example.demo.base;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public abstract class BaseVo {

    private Timestamp regDate;
    private Timestamp modDate;
    
    public BaseVo() { }

    // DTO를 생성자에서 받도록 변경
    public BaseVo(BaseDto baseDto) {
        if (baseDto == null) return;

        // 날짜 변환 (String → Timestamp)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        if (baseDto.getRegDate() != null && !baseDto.getRegDate().isEmpty()) {
            LocalDateTime regLdt = LocalDateTime.parse(baseDto.getRegDate(), formatter);
            this.regDate = Timestamp.valueOf(regLdt);
        }
        if (baseDto.getModDate() != null && !baseDto.getModDate().isEmpty()) {
            LocalDateTime modLdt = LocalDateTime.parse(baseDto.getModDate(), formatter);
            this.modDate = Timestamp.valueOf(modLdt);
        }
    }

	@Override
	public String toString() {
		return "BaseVo [regDate=" + regDate + ", modDate=" + modDate + "]";
	}
}
