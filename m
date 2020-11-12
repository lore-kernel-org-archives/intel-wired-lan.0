From: Luis Chamberlain <mcgrof@kernel.org>
Date: Thu, 12 Nov 2020 22:38:37 +0000
Subject: [Intel-wired-lan] [4.14] Security fixes (blktrace, i40e)
In-Reply-To: <20201108091214.GB44749@kroah.com>
References: <c21d1ef1ddb071eed868a96649b4edf0b61b4247.camel@codethink.co.uk>
 <20201107152827.GA90705@kroah.com>
 <CAB=NE6U=kTw_R+OkqLf0iT0Bwti8w=7RWjWgeQmVQssbZ4OL3w@mail.gmail.com>
 <20201108091214.GB44749@kroah.com>
Message-ID: <20201112223837.GH4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Nov 08, 2020 at 10:12:14AM +0100, Greg Kroah-Hartman wrote:
> On Sun, Nov 08, 2020 at 03:04:14AM -0600, Luis Chamberlain wrote:
> > I'd like some more time for this, to review on older kernels. Don't think
> > it's the best yet
> 
> What is "this" and what is "the best yet"?  Which patch(s) here are you
> referring to in your context-less top-post?  :)

Sorry, I had to send the email as I did as I was not able to access a
computer to properly reply on time (local hurricane cut power off and
internet for a while), and in proper form, and so I figured it would be
more prudent to request to *yield* merging until I do proper review.

Given I am replying to patches which I authored I figured you could
at least infer the email was about blktrace... so you are really
exagerating contextless comment here.

Anyway, you can carry on with the fix for blktrace to be merged,
the concerne would be if you decide to backport the other important
fix "block: revert back to synchronous request_queue removal".

That is, do not merge that loosely, even if you don't see any issues.
This requires a bit more work to backport.

  Luis
