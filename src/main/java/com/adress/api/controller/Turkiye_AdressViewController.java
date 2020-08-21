package com.adress.api.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.adress.api.dto.CityDto;
import com.adress.api.dto.DistrictDto;
import com.adress.api.dto.NeighborhoodsDto;
import com.adress.api.dto.TownDto;
import com.adress.api.dto.ZipcodeDto;
import com.adress.api.service.impl.Turkiye_AdressServiceImpl;

@SpringBootApplication
@RestController
@CrossOrigin(origins = "*")
public class Turkiye_AdressViewController {

	private final Turkiye_AdressServiceImpl turkiye_AdressServiceImpl;

	public Turkiye_AdressViewController(Turkiye_AdressServiceImpl turkiye_AdressServiceImpl) {
		this.turkiye_AdressServiceImpl = turkiye_AdressServiceImpl;
	}

	@RequestMapping(value = "/allAdress", method = RequestMethod.GET)
	public ModelAndView getAllCity() {
		// ModelAndView model = new ModelAndView("test");
		ModelAndView model = new ModelAndView("test");
		// List<String> list = turkiye_AdressServiceImpl.getAllCity();
		// model.addObject("city", list);
		return model;
	}


	// İl
	@RequestMapping(value = "/trCity", method = RequestMethod.GET, headers = "Accept=application/json")
	@ResponseBody
	public List<CityDto> City() {
		List<Object> list = turkiye_AdressServiceImpl.AllCity();
		List<CityDto> cityDto = new ArrayList<>();

		Iterator itr = list.iterator();
		int i = 1;
		while (itr.hasNext()) {
			CityDto newCityDto = new CityDto();
			Object ojb = (Object) itr.next();
			newCityDto.setId(i++);
			newCityDto.setIl((String) ojb);
			cityDto.add(newCityDto);
		}
		return cityDto;
	}

	// İlçe
	@RequestMapping(value = "/trTown", method = RequestMethod.POST, headers = "Accept=application/json")
	@ResponseBody
	public List<TownDto> Town(String city) {
		String citys = city.trim();
		List<Object> list = turkiye_AdressServiceImpl.getAllTown(citys);
		List<TownDto> townDto = new ArrayList<>();
		Iterator itr = list.iterator();
		int i = 1;
		while (itr.hasNext()) {
			TownDto newtownDto = new TownDto();
			Object ojb = (Object) itr.next();
			newtownDto.setId(i++);
			newtownDto.setIlce((String) ojb);
			townDto.add(newtownDto);
		}
		return townDto;

	}

	// Semt
	@RequestMapping(value = "/trDistrict", method = RequestMethod.POST, headers = "Accept=application/json")
	@ResponseBody
	public List<DistrictDto> District(String town) {
		
		String towns = town.trim();
		List<Object> list = turkiye_AdressServiceImpl.getAllDistrict(towns);
		List<DistrictDto> districtDto = new ArrayList<>();
		Iterator itr = list.iterator();
		int i = 1;
		while (itr.hasNext()) {
			DistrictDto newdistrictDtoDto = new DistrictDto();
			Object ojb = (Object) itr.next();
			newdistrictDtoDto.setId(i++);
			newdistrictDtoDto.setSemt((String) ojb);
			districtDto.add(newdistrictDtoDto);
		}
		return districtDto;

	}

	// Mahalle
	@RequestMapping(value = "/trNeighborhoods", method = RequestMethod.POST, headers = "Accept=application/json")
	@ResponseBody
	public List<NeighborhoodsDto> Neighborhoods(String district) {
		String districts = district.trim();
		List<Object> list = turkiye_AdressServiceImpl.getAllNeighborhoods(districts);
		List<NeighborhoodsDto> neighborhoodsDto = new ArrayList<>();
		Iterator itr = list.iterator();
		int i = 1;
		while (itr.hasNext()) {
			NeighborhoodsDto newneighborhoodsDto = new NeighborhoodsDto();
			Object ojb = (Object) itr.next();
			newneighborhoodsDto.setId(i++);
			newneighborhoodsDto.setMahalle((String) ojb);
			neighborhoodsDto.add(newneighborhoodsDto);
		}
		return neighborhoodsDto;

	}

	// Posta kodu
	@RequestMapping(value = "/trZipcode", method = RequestMethod.POST, headers = "Accept=application/json")
	@ResponseBody
	public List<ZipcodeDto> ZipcodeDto(String district, String neighborhoods) {
		String neighborhoodss = neighborhoods.trim();
		String districts = district.trim();

		Object list = turkiye_AdressServiceImpl.getZipCode(districts, neighborhoodss);
		List<ZipcodeDto> zipcodeDto = new ArrayList<>();
		ZipcodeDto newzipcodeDto = new ZipcodeDto();
		newzipcodeDto.setId(1);
		newzipcodeDto.setPostakodu((String) (list));
		zipcodeDto.add(newzipcodeDto);
		return zipcodeDto;

	}


	
	//-----------------------------------------------------------------
	// --------------- Json Data Rest Service--------------------------
	//-----------------------------------------------------------------

	// İl
	@RequestMapping(value = "/city", method = RequestMethod.GET,headers = "Accept=application/json")
	@ResponseBody
	public List<CityDto> loadCitys() {
		List<Object> list = turkiye_AdressServiceImpl.AllCity();
		List<CityDto> cityDto = new ArrayList<>();

		Iterator itr = list.iterator();
		int i = 1;
		while (itr.hasNext()) {
			CityDto newCityDto = new CityDto();
			Object ojb = (Object) itr.next();
			newCityDto.setId(i++);
			newCityDto.setIl((String) ojb);
			cityDto.add(newCityDto);
		}
		return cityDto;

	}

	// İlçe
	@RequestMapping(value = "/towns", method = RequestMethod.GET,headers = "Accept=application/json")
	@ResponseBody
	public List<TownDto> loadCityByTown() {

		List<Object> list = turkiye_AdressServiceImpl.getAllTown();
		List<TownDto> townDto = new ArrayList<>();
		Iterator itr = list.iterator();
		int i = 1;
		while (itr.hasNext()) {

			TownDto newtownDto = new TownDto();
			Object[] obj = (Object[]) itr.next();
			// newtownDto.setId(Integer.valueOf(obj[0].toString()));
			newtownDto.setId(i++);
			newtownDto.setIl(obj[0].toString());
			newtownDto.setIlce(obj[1].toString());
			townDto.add(newtownDto);
		}

		return townDto;

	}

	// Semt
	@RequestMapping(value = "/district", method = RequestMethod.GET,headers = "Accept=application/json")
	@ResponseBody
	public List<DistrictDto> loadCityByDistrict() {

		List<Object> list = turkiye_AdressServiceImpl.getAllDistrict();
		List<DistrictDto> districtDto = new ArrayList<>();
		Iterator itr = list.iterator();
		int i = 1;
		while (itr.hasNext()) {

			DistrictDto newdistrictDto = new DistrictDto();
			Object[] obj = (Object[]) itr.next();
			// newdistrictDto.setId(Integer.valueOf(obj[0].toString()));
			newdistrictDto.setId(i++);
			newdistrictDto.setIlce(obj[0].toString());
			newdistrictDto.setSemt(obj[1].toString());
			districtDto.add(newdistrictDto);
		}

		return districtDto;

	}

	// Mahalle
	@RequestMapping(value = "/neighborhoods", method = RequestMethod.GET,headers = "Accept=application/json")
	@ResponseBody
	public List<NeighborhoodsDto> loadCityByneighborhoods() {

		List<Object> list = turkiye_AdressServiceImpl.getAllNeighborhoods();

		List<NeighborhoodsDto> neighborhoodsDto = new ArrayList<>();
		Iterator itr = list.iterator();
		int i = 1;
		while (itr.hasNext()) {

			NeighborhoodsDto newneighborhoodsDto = new NeighborhoodsDto();
			Object[] obj = (Object[]) itr.next();
			// newneighborhoodsDto.setId(Integer.valueOf(obj[0].toString()));
			newneighborhoodsDto.setId(i++);
			newneighborhoodsDto.setSemt(obj[0].toString());
			newneighborhoodsDto.setMahalle(obj[1].toString());
			neighborhoodsDto.add(newneighborhoodsDto);
		}

		return neighborhoodsDto;
	}

	// Posta Kodu
	@RequestMapping(value = "/zipcode", method = RequestMethod.GET,headers = "Accept=application/json")
	@ResponseBody
	public List<ZipcodeDto> getZipCode() {

		List<Object> list = turkiye_AdressServiceImpl.getZipCode();

		List<ZipcodeDto> neighborhoodsDto = new ArrayList<>();
		Iterator itr = list.iterator();
		int i = 1;
		while (itr.hasNext()) {

			ZipcodeDto newZipcodeDto = new ZipcodeDto();
			Object[] obj = (Object[]) itr.next();
			// newZipcodeDto.setId(Integer.valueOf(obj[0].toString()));
			newZipcodeDto.setId(i++);
			newZipcodeDto.setSemt(obj[0].toString());
			newZipcodeDto.setMahalle(obj[1].toString());
			newZipcodeDto.setPostakodu(obj[2].toString());
			neighborhoodsDto.add(newZipcodeDto);
		}

		return neighborhoodsDto;

	}

	// -----------------------------------------------------------------
	// --------------- Json Data Rest Service--------------------------
	// -----------------------------------------------------------------

}
