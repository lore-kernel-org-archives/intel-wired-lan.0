From: Thorsten Leemhuis <linux@leemhuis.info>
Date: Mon, 10 May 2021 12:52:44 +0200
Subject: [Intel-wired-lan] [PATCH 00/53] Get rid of UTF-8 chars that can
 be mapped as ASCII
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
Message-ID: <c4479ced-f4d8-1a1e-ee54-9abc55344187@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 10.05.21 12:26, Mauro Carvalho Chehab wrote:
>
> As Linux developers are all around the globe, and not everybody has UTF-8
> as their default charset, better to use UTF-8 only on cases where it is really
> needed.
> [?]
> The remaining patches on series address such cases on *.rst files and 
> inside the Documentation/ABI, using this perl map table in order to do the
> charset conversion:
> 
> my %char_map = (
> [?]
> 	0x2013 => '-',		# EN DASH
> 	0x2014 => '-',		# EM DASH

I might be performing bike shedding here, but wouldn't it be better to
replace those two with "--", as explained in
https://en.wikipedia.org/wiki/Dash#Approximating_the_em_dash_with_two_or_three_hyphens

For EM DASH there seems to be even "---", but I'd say that is a bit too
much.

Or do you fear the extra work as some lines then might break the
80-character limit then?

Ciao, Thorsten
