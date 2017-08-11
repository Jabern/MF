
LoadStones(filename[])
{
	new
		File:file,
		line[256],
		linenumber = 1,
		count,

		funcname[32],
		funcargs[128],

		class,
		Float:x,
		Float:y,
		Float:z;

	if(!fexist(filename))
	{
		printf("[MINING ERROR] file: \"%s\" NOT FOUND", filename);
		return 0;
	}

	file = fopen(filename, io_read);

	if(!file)
	{
		printf("[MINING ERROR] \"%s\" NOT LOADED", filename);
		return 0;
	}

	while(fread(file, line))
	{
		if(line[0] < 65)
		{
			linenumber++;
			continue;
		}

		if(sscanf(line, "p<(>s[32]p<)>s[128]{s[96]}", funcname, funcargs))
		{
			linenumber++;
			continue;
		}

		if(!strcmp(funcname, "CreateStone"))
		{
			if(sscanf(funcargs, "p<,>dfff", class, x, y, z))
			{
				printf("[MINING ERROR] [LOADING] Malformed parameters on line %d", linenumber);
				linenumber++;
				continue;
			}

			CreateStone(class, x, y, z);
			count++;
			linenumber++;
		}
	}

	printf("[MINING] Loaded %d stone from '%s'.", count, filename);

	return 1;
}