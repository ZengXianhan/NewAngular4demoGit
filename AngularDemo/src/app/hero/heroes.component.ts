import { Component } from '@angular/core';
import { OnInit } from '@angular/core';
import { HeroService } from './hero.service';
import { Hero } from './hero';
import { Router } from '@angular/router';

@Component({
    selector: 'app-my-heroes',
    styleUrls: ['./heroes.component.css'],
    templateUrl: './heroes.component.html'
})
export class HeroesComponent implements OnInit {
    title = 'Tour of Heroes';
    heroes: Hero[];
    selectedHero: Hero;
    onSelect(hero: Hero): void {
        this.selectedHero = hero;
    }

    constructor(private router: Router, private heroService: HeroService) {
        this.getHeroes();
    }

    getHeroes(): void {
        this.heroService.getHeroesHttp().then(heroes => this.heroes = heroes);
    }
    ngOnInit(): void {
        this.getHeroes();
    }
    gotoDetail(): void {
      this.router.navigate(['/HeroDetail', this.selectedHero.ID]);
    }
}
