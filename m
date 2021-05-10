From: Edward Cree <ecree.xilinx@gmail.com>
Date: Mon, 10 May 2021 14:16:16 +0100
Subject: [Intel-wired-lan] [PATCH 00/53] Get rid of UTF-8 chars that can
 be mapped as ASCII
In-Reply-To: <20210510135518.305cc03d@coco.lan>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <2ae366fdff4bd5910a2270823e8da70521c859af.camel@infradead.org>
 <20210510135518.305cc03d@coco.lan>
Message-ID: <df6b4567-030c-a480-c5a6-fe579830e8c0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/05/2021 12:55, Mauro Carvalho Chehab wrote:
> The main point on this series is to replace just the occurrences
> where ASCII represents the symbol equally well

> 	- U+2014 ('?'): EM DASH
Em dash is not the same thing as hyphen-minus, and the latter does not
 serve 'equally well'.  People use em dashes because ? even in
 monospace fonts ? they make text easier to read and comprehend, when
 used correctly.
I accept that some of the other distinctions ? like en dashes ? are
 needlessly pedantic (though I don't doubt there is someone out there
 who will gladly defend them with the same fervour with which I argue
 for the em dash) and I wouldn't take the trouble to use them myself;
 but I think there is a reasonable assumption that when someone goes
 to the effort of using a Unicode punctuation mark that is semantic
 (rather than merely typographical), they probably had a reason for
 doing so.

> 	- U+2018 ('?'): LEFT SINGLE QUOTATION MARK
> 	- U+2019 ('?'): RIGHT SINGLE QUOTATION MARK
> 	- U+201c ('?'): LEFT DOUBLE QUOTATION MARK
> 	- U+201d ('?'): RIGHT DOUBLE QUOTATION MARK
(These are purely typographic, I have no problem with dumping them.)

> 	- U+00d7 ('?'): MULTIPLICATION SIGN
Presumably this is appearing in mathematical formulae, in which case
 changing it to 'x' loses semantic information.

> Using the above symbols will just trick tools like grep for no good
> reason.
NBSP, sure.  That one's probably an artefact of some document format
 conversion somewhere along the line, anyway.
But what kinds of things with ? or ? in are going to be grept for?

If there are em dashes lying around that semantically _should_ be
 hyphen-minus (one of your patches I've seen, for instance, fixes an
 *en* dash moonlighting as the option character in an `ethtool`
 command line), then sure, convert them.
But any time someone is using a Unicode character to *express
 semantics*, even if you happen to think the semantic distinction
 involved is a pedantic or unimportant one, I think you need an
 explicit grep case to justify ASCIIfying it.

-ed
