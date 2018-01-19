import {Injectable} from '@angular/core';
import {Http} from '@angular/http';
import 'rxjs/add/operator/map';
import { log } from 'util';

@Injectable()
export class MyHttp {
  public restServer;
  public http;

  constructor(http: Http) {
    this.http = http;
    this.restServer = 'api';
  }

  public get(url, params?: Object, cb?: Function): any {
    console.log('开始请求');
    const vm = this;
    let searchParams = '';
    if (params) {
      for (const key in params) {
        searchParams += key + '=' + params[key];
      }
    }
    console.log(vm.restServer + url);
    vm.http.get(vm.restServer + url, {
        search: searchParams
      })
      .map(res => res.json())
      .subscribe(data => {
        console.log('请求结束', data);
        return cb(data);
      });
  }
}
