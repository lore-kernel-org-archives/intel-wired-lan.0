From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Mon, 17 May 2021 13:24:46 +0200
Subject: [Intel-wired-lan] [PATCH v3 00/16] Replace some bad characters
 on documents
In-Reply-To: <30cd6dd9d1049d56b629c92a5f385b84c026b445.camel@infradead.org>
References: <cover.1621159997.git.mchehab+huawei@kernel.org>
 <30cd6dd9d1049d56b629c92a5f385b84c026b445.camel@infradead.org>
Message-ID: <20210517132446.7edba98f@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Em Mon, 17 May 2021 11:48:04 +0100
David Woodhouse <dwmw2@infradead.org> escreveu:

> On Sun, 2021-05-16 at 12:18 +0200, Mauro Carvalho Chehab wrote:
> > The conversion tools used during DocBook/LaTeX/html/Markdown->ReST 
> > conversion and some cut-and-pasted text contain some characters that
> > aren't easily reachable on standard keyboards and/or could cause 
> > troubles when parsed by the documentation build system.  
> 
> Better.
> 
> But you still don't say *why* it matters whether given characters are
> trivial to reach with standard keyboard layouts, or specify *what*
> 'troubles' the offending characters cause.

See the patches in the series. The reason for each particular case
is there on each patch, like on this one:

	[PATCH v3 13/16] docs: sound: kernel-api: writing-an-alsa-driver.rst: replace some characters

	The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
	conversion and some cut-and-pasted text contain some characters that
	aren't easily reachable on standard keyboards and/or could cause
	troubles when parsed by the documentation build system.
	 
	Replace the occurences of the following characters:
	
		- U+00a0 ('?'): NO-BREAK SPACE
		  as it can cause lines being truncated on PDF output

	Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


Thanks,
Mauro
