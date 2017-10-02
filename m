From: Greg KH <greg@kroah.com>
Date: Mon, 2 Oct 2017 07:35:54 +0200
Subject: [Intel-wired-lan] [PATCH 00/18] use ARRAY_SIZE macro
In-Reply-To: <20171001205220.10b78086@blatinox-laptop.localdomain>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
 <20171001220131.GA11812@eros>
 <20171001205220.10b78086@blatinox-laptop.localdomain>
Message-ID: <20171002053554.GA28743@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Oct 01, 2017 at 08:52:20PM -0400, J?r?my Lefaure wrote:
> On Mon, 2 Oct 2017 09:01:31 +1100
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > > In order to reduce the size of the To: and Cc: lines, each patch of the
> > > series is sent only to the maintainers and lists concerned by the patch.
> > > This cover letter is sent to every list concerned by this series.  
> > 
> > Why don't you just send individual patches for each subsystem? I'm not a maintainer but I don't see
> > how any one person is going to be able to apply this whole series, it is making it hard for
> > maintainers if they have to pick patches out from among the series (if indeed any will bother
> > doing that).
> Yeah, maybe it would have been better to send individual patches.
> 
> From my point of view it's a series because the patches are related (I
> did a git format-patch from my local branch). But for the maintainers
> point of view, they are individual patches.

And the maintainers view is what matters here, if you wish to get your
patches reviewed and accepted...

thanks,

greg k-h
