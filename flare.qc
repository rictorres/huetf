//=-=-=-=-=
void () FlareGrenadeTouch =
{
	sound (self, 1, "weapons/bounce.wav", 1, 1);
	if ((pointcontents (self.origin) == -6))
	{
		dremove (self);
		return;
	}
	if ((other == world))
	{
		self.movetype = 0;
		self.velocity = '0 0 0';
	}
	if ((self.velocity == '0 0 0'))
	{
		self.avelocity = '0 0 0';
		self.touch = SUB_Null;
	}
};

void () FlareGrenadeThink =
{
	local float rnum;
	local float time_left;

	time_left = (self.health - time);
	if ((time_left > 33))
	{
		rnum = random ();
		if ((rnum < 0.5))
		{
			self.effects = 8;
		}
		else
		{
			self.effects = 0;
		}
		self.nextthink = ((time + 0.05) + (random () * 0.1));
	}
	else
	{
		if ((time_left > 31))
		{
			rnum = random ();
			if ((rnum < 0.5))
			{
				self.effects = 4;
			}
			else
			{
				self.effects = 8;
			}
			self.nextthink = ((time + 0.05) + (random () * 0.1));
		}
		else
		{
			if ((time_left > 15))
			{
				self.effects = 4;
				self.nextthink = (time + enter);
			}
			else
			{
				if ((time_left < 1))
				{
					RemoveFlare ();
				}
				else
				{
					self.effects = 8;
					self.nextthink = (time + time_left);
				}
			}
		}
	}
};

void () FlareGrenadeExplode =
{
	if ((self.weapon != 0))
	{
		increment_team_flares (self.weapon);
		if ((num_team_flares (self.weapon) > (num_max_flares / number_of_teams)))
		{
			RemoveOldFlare (self.weapon);
		}
	}
	else
	{
		num_world_flares = (num_world_flares + 1);
		if ((num_world_flares > num_max_flares))
		{
			RemoveOldFlare (0);
		}
	}
	self.skin = 1;
	self.health = (time + 40);
	self.nextthink = ((time + 0.05) + (random () * 0.1));
	self.think = FlareGrenadeThink;
};

void () RemoveFlare =
{
	self.effects = (self.effects - (self.effects & 4));
	dremove (self);
	num_world_flares = (num_world_flares - 1);
	decrement_team_flares (self.weapon);
};
