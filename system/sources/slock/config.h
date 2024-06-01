/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nogroup";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#000030",   /* during input */
	[FAILED] = "#300000",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* should [command] be run only once? */
int run_once = 1;

/* length of time (seconds) until [command] is executed */
int time_offset = 10;

/* command to be run after [timeoffset] seconds has passed */
const char *timeout_command = NULL;

/* default message */
static const char * message = ":)";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
static const char * font_name = "9x15";
