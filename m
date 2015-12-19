From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 19 Dec 2015 03:17:33 +0000
Subject: [Intel-wired-lan] [next PATCH] igb/igbvf: don't give up
In-Reply-To: <AAEA33E297BCAC4B9BB20A7C2DF0AB8D7848200E@FMSMSX113.amr.corp.intel.com>
References: <1449881138-19985-1-git-send-email-mitch.a.williams@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81E30D1D@ORSMSX101.amr.corp.intel.com>
 <8FF04C88-EEDB-4234-A368-CED5C387348B@intel.com>,
 <AAEA33E297BCAC4B9BB20A7C2DF0AB8D7848200E@FMSMSX113.amr.corp.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E3131A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Williams, Mitch A
> Sent: Friday, December 18, 2015 8:42 AM
> To: Rustad, Mark D; Brown, Aaron F
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: RE: [Intel-wired-lan] [next PATCH] igb/igbvf: don't give up
> 
> Yes, these are called from interrupt context. So they can't sleep, no matter how tired they get.
> -Mitch

No matter HOW tired, bummer!  Cause for me, sometimes I just can't stay awake another millisecond :)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

> > -----Original Message-----
> > From: Rustad, Mark D
> > Sent: Thursday, December 17, 2015 5:57 PM
> > To: Brown, Aaron F
> > Cc: Williams, Mitch A; intel-wired-lan at lists.osuosl.org
> > Subject: Re: [Intel-wired-lan] [next PATCH] igb/igbvf: don't give up
> >
> > Aaron F <aaron.f.brown@intel.com> wrote:
> >
> > > Is there any reason not to use usleep_range here?
> >
> > Can the routines ever be called from any atomic context, such as an
> > interrupt or while a lock is held? If so, you can't use any form of sleep.
> >
> > --
> > Mark Rustad, Networking Division, Intel Corporation
