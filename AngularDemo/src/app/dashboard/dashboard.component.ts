import { Component, OnInit } from '@angular/core';

import { Hero } from '../hero/hero';
import { HeroService } from '../hero/hero.service';
import { MyHttp } from '../app.http';
import 'rxjs/add/operator/map';

@Component({
  selector: 'app-my-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {
    heroes: Hero[] = [];

    outputJson: String = '';
    constructor(private heroService: HeroService, private myHttp: MyHttp ) { }

    ngOnInit(): void {
        this.heroService.getHeroesHttp()
        .then(
            heroes => this.heroes = heroes.slice(0, 5));
    }
}
