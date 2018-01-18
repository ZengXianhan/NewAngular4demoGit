using HeroWebApi.Models;
using HeroWebApi.Respond;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Web.Http.Results;

namespace HeroWebApi.Controllers
{
    public class HeroController : ApiController
    {
        //private pubsEntities db;

        [HttpGet]
        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [Route("api/GetAllHeroes")]
        public JsonResult<HeroRespond> GetAllHeroes()
        {
            HeroRespond heroRespond = new HeroRespond();
            using (var db = new pubsEntities())
            {
                try
                {
                    var heroes = db.heroes.ToList();
                    List<hero> heroList = heroes.ToList();
                    if (heroList.Count() > 0)
                    {
                        heroRespond.Massage = "Success";
                        heroRespond.Status = "200";
                        heroRespond.Heroes = heroList;
                    }
                    else
                    {
                        heroRespond.Massage = "Fail";
                        heroRespond.Status = "-1";
                        heroRespond.Heroes = null;
                    }
                }
                catch (Exception e)
                {
                    heroRespond.Massage = "Error: " + e.Message;
                    heroRespond.Status = "-404";
                    heroRespond.Heroes = null;
                }   
                return Json(heroRespond);
            }
        }
    }
}
