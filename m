From: Williams, Mitch A <mitch.a.williams@intel.com>
Date: Wed, 21 Dec 2016 17:39:19 +0000
Subject: [Intel-wired-lan] [PATCH v3] ethtool: stop the line wrapping
 madness
In-Reply-To: <CAKgT0UfAg5aOfi07ZBiHqjCMhGKL9kh-fmUWQSP3L0vfHOTBqw@mail.gmail.com>
References: <20161221003528.4483-1-mitch.a.williams@intel.com>
 <CAKgT0UfAg5aOfi07ZBiHqjCMhGKL9kh-fmUWQSP3L0vfHOTBqw@mail.gmail.com>
Message-ID: <AAEA33E297BCAC4B9BB20A7C2DF0AB8D804AC48A@FMSMSX113.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Wednesday, December 21, 2016 8:11 AM
> To: Williams, Mitch A <mitch.a.williams@intel.com>
> Cc: intel-wired-lan <intel-wired-lan@lists.osuosl.org>;
> netanel at annapurnalabs.com; saeed at annapurnalabs.com; zorik at annapurnalabs.com;
> David Decotigny <decot@googlers.com>
> Subject: Re: [Intel-wired-lan] [PATCH v3] ethtool: stop the line wrapping
> madness
> 
> Why are you submitting this on intel-wired-lan instead of netdev?
> Seems like this might make more sense there.

I asked Jeff specifically about this, and he preferred that I submit this via intel-wired-lan.

> 
> On Tue, Dec 20, 2016 at 4:35 PM, Mitch Williams
> <mitch.a.williams@intel.com> wrote:
> > Folks, we have a hard limit of 80 characters per line in the kernel,
> > mostly due to Linus' insistence on printing out each release on greenbar
> > with his Decwriter. So why do we have function and macro names that are
> > over 30 characters long? Add a tab or two and a few parameters and boom!
> > you're wrapping lines.
> 
> Get rid of the sarcasm, it comes across as unprofessional.  There are
> those out there who don't grok it (myself included), and worse yet
> there are those who will interpret it as being some passive aggressive
> slight towards Linus.  Best to just leave it out and not have it in
> there as a reason for the patch to be rejected.  If you need to
> mention the 80 character limit feel free to quote chunks out of
> "Documentation/CodingStyle".

I disagree with you comprehensively. I have been sending out humorous commit messages for years and people (including Dave Miller) have come to expect this from me. Just because you don't get the joke doesn't mean it's unprofessional.

> 
> > This patch is a search-n-replace of the newly-added ethtool link
> > settings API with shorter names. In general, I replaced 'ksettings' with
> > 'ks' and elided some unnecessary verbiage. In nearly every instance I
> > unwrapped lines and made the code easier to read, especially on a VT102.
> >
> > In the case of the Amazon Ethernet driver, I found a bug where they were
> > setting bits in the the 'settings' field twice. Almost certainly this
> > was supposed to set bits in the 'advertising' field instead. So I fixed
> > it.
> >
> > Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> > v3: catch a few more drivers
> > v2: catch a few more drivers
> 
> You might be better off breaking this up into several patches.  I
> notice you are renaming three different ethtool interfaces used by the
> drivers.  It would be much easier to review this if you went through
> and renamed/reformatted one at a time instead of renaming several in a
> single patch.  Then reviewing it becomes much more mechanical as the
> entire patch should follow the same pattern in terms of whitespace and
> naming changes.

I also disagree with this, though I see your point. But splitting this would just make for a series of long cumbersome patches instead of just one. And reviewing is pretty simple - if I've screwed up, it just won't compile.

-Mitch

[snip]

