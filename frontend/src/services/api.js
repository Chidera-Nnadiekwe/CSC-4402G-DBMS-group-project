import axios from 'axios';

const API = axios.create({ baseURL: 'http://localhost:3001/api' });

export const getCountries      = ()      => API.get('/countries');
export const getCountryTrade   = (iso3)  => API.get(`/countries/${iso3}/trade`);
export const getCountryBalance = (iso3)  => API.get(`/countries/${iso3}/balance`);
export const getCountrySanctions = (iso3) => API.get(`/countries/${iso3}/sanctions`);
export const getTradeFlows     = (year)  => API.get(`/trade/flows?year=${year}`);
export const getBilateral      = (year)  => API.get(`/trade/bilateral?year=${year}`);
