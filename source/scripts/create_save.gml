///create_save()

if (file_exists("save.sav"))
{
    file_delete("save.sav")
}


ini_open("save.sav")

ini_write_real("FNATB","currentNight",obj_game.night)
ini_write_real("FNATB","star",obj_star.star)

ini_close()
