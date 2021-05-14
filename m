From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Fri, 14 May 2021 16:18:25 +0200
Subject: [Intel-wired-lan] [PATCH v2 00/40] Use ASCII subset instead of
 UTF-8 alternate symbols
In-Reply-To: <8b8bc929-2f07-049d-f24c-cb1f1d85bbaa@gmail.com>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
 <d2fed242fbe200706b8d23a53512f0311d900297.camel@infradead.org>
 <20210514102118.1b71bec3@coco.lan>
 <61c286b7afd6c4acf71418feee4eecca2e6c80c8.camel@infradead.org>
 <8b8bc929-2f07-049d-f24c-cb1f1d85bbaa@gmail.com>
Message-ID: <20210514161825.4e4c0d3e@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Em Fri, 14 May 2021 12:08:36 +0100
Edward Cree <ecree.xilinx@gmail.com> escreveu:

> For anyone who doesn't know about it: X has this wonderful thing called
>  the Compose key[1].  For instance, type ?--- to get ?, or ?<" for ?.
> Much more mnemonic than Unicode codepoints; and you can extend it with
>  user-defined sequences in your ~/.XCompose file.

Good tip. I haven't use composite for years, as US-intl with dead keys is
enough for 99.999% of my needs. 

Btw, at least on Fedora with Mate, Composite is disabled by default. It has
to be enabled first using the same tool that allows changing the Keyboard
layout[1].

Yet, typing an EN DASH for example, would be "<composite>--.", with is 4
keystrokes instead of just two ('--'). It means twice the effort ;-)

[1] KDE, GNome, Mate, ... have different ways to enable it and to 
    select what key would be considered <composite>:

	https://dry.sailingissues.com/us-international-keyboard-layout.html
	https://help.ubuntu.com/community/ComposeKey

Thanks,
Mauro
