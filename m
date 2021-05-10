From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Mon, 10 May 2021 13:19:50 +0200
Subject: [Intel-wired-lan] [PATCH 00/53] Get rid of UTF-8 chars that can
 be mapped as ASCII
In-Reply-To: <c4479ced-f4d8-1a1e-ee54-9abc55344187@leemhuis.info>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <c4479ced-f4d8-1a1e-ee54-9abc55344187@leemhuis.info>
Message-ID: <20210510131950.063f0608@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Em Mon, 10 May 2021 12:52:44 +0200
Thorsten Leemhuis <linux@leemhuis.info> escreveu:

> On 10.05.21 12:26, Mauro Carvalho Chehab wrote:
> >
> > As Linux developers are all around the globe, and not everybody has UTF-8
> > as their default charset, better to use UTF-8 only on cases where it is really
> > needed.
> > [?]
> > The remaining patches on series address such cases on *.rst files and 
> > inside the Documentation/ABI, using this perl map table in order to do the
> > charset conversion:
> > 
> > my %char_map = (
> > [?]
> > 	0x2013 => '-',		# EN DASH
> > 	0x2014 => '-',		# EM DASH  


> I might be performing bike shedding here, but wouldn't it be better to
> replace those two with "--", as explained in
> https://en.wikipedia.org/wiki/Dash#Approximating_the_em_dash_with_two_or_three_hyphens
> 
> For EM DASH there seems to be even "---", but I'd say that is a bit too
> much.

Yeah, we can do, instead:

 	0x2013 => '--',		# EN DASH
 	0x2014 => '---',	# EM DASH  

I was actually in doubt about those ;-)

Btw, when producing HTML documentation,  Sphinx should convert:
	-- into EN DASH
and:
	--- into EM DASH

So, the resulting html will be identical.

> Or do you fear the extra work as some lines then might break the
> 80-character limit then?

No, I suspect that the line size won't be an issue. Some care should
taken when EN DASH and EM DASH are used inside tables.

Thanks,
Mauro
