From: Adam Borowski <kilobyte@angband.pl>
Date: Mon, 10 May 2021 23:57:13 +0200
Subject: [Intel-wired-lan] [PATCH 00/53] Get rid of UTF-8 chars that can
 be mapped as ASCII
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
Message-ID: <YJmsOYzPIsQ04Zxb@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, May 10, 2021 at 12:26:12PM +0200, Mauro Carvalho Chehab wrote:
> There are several UTF-8 characters at the Kernel's documentation.
[...]
> Other UTF-8 characters were added along the time, but they're easily
> replaceable by ASCII chars.
> 
> As Linux developers are all around the globe, and not everybody has UTF-8
> as their default charset

I'm not aware of a distribution that still allows selecting a non-UTF-8
charset in a normal flow in their installer.  And if they haven't purged
support for ancient encodings, that support is thoroughly bitrotten.
Thus, I disagree that this is a legitimate concern.

What _could_ be a legitimate reason is that someone is on a _terminal_
that can't display a wide enough set of glyphs.  Such terminals are:
 ? Linux console (because of vgacon limitations; patchsets to improve
   other cons haven't been mainlined)
 ? some Windows terminals (putty, old Windows console) that can't borrow
   glyphs from other fonts like fontconfig can

For the former, it's whatever your distribution ships in
/usr/share/consolefonts/ or an equivalent, which is based on historic
ISO-8859 and VT100 traditions.

For the latter, the near-guaranteed character set is WGL4.


Thus, at least two of your choices seem to disagree with the above:
[dropped]
> 	0xd7   => 'x',		# MULTIPLICATION SIGN
[retained]
> 	- U+2b0d ('?'): UP DOWN BLACK ARROW

? is present in ISO-8859, V100, WGL4; I've found no font in
/usr/share/consolefonts/ on my Debian unstable box that lacks this
character.

? is not found in any of the above.  You might want to at least
convert it to ? which is at least present in WGL4, and thus likely
to be supported in fonts heeding Windows/Mac/OpenType recommendations.
That still won't make it work on VT.


Meow!
-- 
??????? .--[ Makefile ]
??????? # beware of races
??????? all: pillage burn
??????? `----
