From: David Woodhouse <dwmw2@infradead.org>
Date: Wed, 12 May 2021 18:07:04 +0100
Subject: [Intel-wired-lan] [PATCH v2 00/40] Use ASCII subset instead of
 UTF-8 alternate symbols
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
Message-ID: <d2fed242fbe200706b8d23a53512f0311d900297.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Your title 'Use ASCII subset' is now at least a bit *closer* to
describing what the patches are actually doing, but it's still a bit
misleading because you're only doing it for *some* characters.

And the wording is still indicative of a fundamentally *misguided*
motivation for doing any of this. Your commit comments should be about
fixing a specific thing, nothing to do with "use ASCII subset", which
is pointless in itself.

On Wed, 2021-05-12 at 14:50 +0200, Mauro Carvalho Chehab wrote:
> Such conversion tools - plus some text editor like LibreOffice  or similar  - have
> a set of rules that turns some typed ASCII characters into UTF-8 alternatives,
> for instance converting commas into curly commas and adding non-breakable
> spaces. All of those are meant to produce better results when the text is
> displayed in HTML or PDF formats.

And don't we render our documentation into HTML or PDF formats? Are
some of those non-breaking spaces not actually *useful* for their
intended purpose?

> While it is perfectly fine to use UTF-8 characters in Linux, and specially at
> the documentation,  it is better to  stick to the ASCII subset  on such
> particular case,  due to a couple of reasons:
> 
> 1. it makes life easier for tools like grep;

Barely, as noted, because of things like line feeds.

> 2. they easier to edit with the some commonly used text/source
>    code editors.

That is nonsense. Any but the most broken and/or anachronistic
environments and editors will be just fine.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5174 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210512/d153f14f/attachment-0001.bin>
