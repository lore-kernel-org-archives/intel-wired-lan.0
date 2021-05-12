From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Wed, 12 May 2021 17:17:41 +0200
Subject: [Intel-wired-lan] [PATCH v2 00/40] Use ASCII subset instead of
 UTF-8 alternate symbols
In-Reply-To: <YJvi1L2ss5Tfi+My@mit.edu>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
 <YJvi1L2ss5Tfi+My@mit.edu>
Message-ID: <20210512171741.2870bcbc@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Em Wed, 12 May 2021 10:14:44 -0400
"Theodore Ts'o" <tytso@mit.edu> escreveu:

> On Wed, May 12, 2021 at 02:50:04PM +0200, Mauro Carvalho Chehab wrote:
> > v2:
> > - removed EM/EN DASH conversion from this patchset;  
> 
> Are you still thinking about doing the
> 
> EN DASH --> "--"
> EM DASH --> "---"
> 
> conversion?  

Yes, but I intend to submit it on a separate patch series, probably after
having this one merged. Let's first cleanup the large part of the 
conversion-generated UTF-8 char noise ;-)

> That's not going to change what the documentation will
> look like in the HTML and PDF output forms, and I think it would make
> life easier for people are reading and editing the Documentation/*
> files in text form.

Agreed. I'm also considering to add a couple of cases of this char:

	- U+2026 ('?'): HORIZONTAL ELLIPSIS

As Sphinx also replaces "..." into HORIZONTAL ELLIPSIS.

-

Anyway, I'm opting to submitting those in separate because it seems
that at least some maintainers added EM/EN DASH intentionally.

So, it may generate case-per-case discussions.

Also, IMO, at least a couple of EN/EM DASH cases would be better served 
with a single hyphen.

Thanks,
Mauro
