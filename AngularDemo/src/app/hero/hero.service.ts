import { Injectable } from '@angular/core';
import { Headers, Http } from '@angular/http';

import { Hero } from './hero';
import { HEROES } from './mock-heroes';
import { MyHttp } from '../app.http';

@Injectable()
export class HeroService {

    private heroesUrl = 'http://localhost:58949/api/GetAllHeroes';
    private JsonHeroes;

    constructor(private http: Http, private myHttp: MyHttp) { }

    getHeroes(): Promise<Hero[]> {
        return Promise.resolve(HEROES);
    }

    getHeroesSlowly(): Promise<Hero[]> {
        return new Promise(resolve => {
            // Simulate server latency with 2 second delay
            setTimeout(() => resolve(this.getHeroes()), 1000);
        });
    }
    getHeroesHttp(): Promise<Hero[]> {
        const url = `${this.heroesUrl}`;
        console.log('request URL');
        return this.http.get(url)
        .map(data => data.json())
            .toPromise()
            .then(res => {
                console.log('response', res);
                return res['Heroes'] as Hero[];
            })
            .catch(res => res);
    }

    private handleError(error: any): Promise<any> {
        console.error('An error occurred', error); // for demo purposes only
        return Promise.reject(error.message || error);
    }

    getHero(id: number): Promise<Hero> {
        return this.getHeroesHttp()
            .then(heroes => heroes.find(hero => hero.ID === id));
    }

}



