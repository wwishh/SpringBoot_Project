package boot.data.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boot.data.Dto.SangpumDto;
import boot.data.mapper.SangpumMapperInter;


@Service
public class SangpumService implements SangpumServiceInter {
	
	@Autowired
	SangpumMapperInter mapper;

	@Override
	public SangpumDto getSangpumById(int sangIdx) {
		// TODO Auto-generated method stub
		return mapper.getSangpumById(sangIdx);
	}

	

}
