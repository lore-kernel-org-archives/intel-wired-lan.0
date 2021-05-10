From: Matthew Wilcox <willy@infradead.org>
Date: Mon, 10 May 2021 14:59:08 +0100
Subject: [Intel-wired-lan] [PATCH 00/53] Get rid of UTF-8 chars that can
 be mapped as ASCII
In-Reply-To: <df6b4567-030c-a480-c5a6-fe579830e8c0@gmail.com>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <2ae366fdff4bd5910a2270823e8da70521c859af.camel@infradead.org>
 <20210510135518.305cc03d@coco.lan>
 <df6b4567-030c-a480-c5a6-fe579830e8c0@gmail.com>
Message-ID: <YJk8LMFViV7Z3Uu7@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, May 10, 2021 at 02:16:16PM +0100, Edward Cree wrote:
> On 10/05/2021 12:55, Mauro Carvalho Chehab wrote:
> > The main point on this series is to replace just the occurrences
> > where ASCII represents the symbol equally well
> 
> > 	- U+2014 ('?'): EM DASH
> Em dash is not the same thing as hyphen-minus, and the latter does not
>  serve 'equally well'.  People use em dashes because ? even in
>  monospace fonts ? they make text easier to read and comprehend, when
>  used correctly.
> I accept that some of the other distinctions ? like en dashes ? are
>  needlessly pedantic (though I don't doubt there is someone out there
>  who will gladly defend them with the same fervour with which I argue
>  for the em dash) and I wouldn't take the trouble to use them myself;
>  but I think there is a reasonable assumption that when someone goes
>  to the effort of using a Unicode punctuation mark that is semantic
>  (rather than merely typographical), they probably had a reason for
>  doing so.

I think you're overestimating the amount of care and typographical
knowledge that your average kernel developer has.  Most of these
UTF-8 characters come from latex conversions and really aren't
necessary (and are being used incorrectly).

You seem quite knowedgeable about the various differences.  Perhaps
you'd be willing to write a document for Documentation/doc-guide/
that provides guidance for when to use which kinds of horizontal
line?  https://www.punctuationmatters.com/hyphen-dash-n-dash-and-m-dash/
talks about it in the context of publications, but I think we need
something more suited to our needs for kernel documentation.
