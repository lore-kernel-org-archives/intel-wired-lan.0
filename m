From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 31 Oct 2018 22:08:52 +0000
Subject: [Intel-wired-lan] [RFC PATCH 4/4] ixgbe: add support for
 extended PHC gettime
In-Reply-To: <20181031211632.f7imvzvrsn6pbwgb@localhost>
References: <20181026162742.631-1-mlichvar@redhat.com>
 <20181026162742.631-5-mlichvar@redhat.com>
 <02874ECE860811409154E81DA85FBB5884CE4B8C@ORSMSX115.amr.corp.intel.com>
 <20181029133109.GD31668@localhost>
 <20181031144003.qs235wjmiuwaprps@localhost>
 <20181031144935.GR31668@localhost>
 <20181031211632.f7imvzvrsn6pbwgb@localhost>
Message-ID: <02874ECE860811409154E81DA85FBB5884D121B2@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Richard Cochran [mailto:richardcochran at gmail.com]
> Sent: Wednesday, October 31, 2018 2:17 PM
> To: Miroslav Lichvar <mlichvar@redhat.com>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; netdev at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [RFC PATCH 4/4] ixgbe: add support for extended PHC gettime
> 
> On Wed, Oct 31, 2018 at 03:49:35PM +0100, Miroslav Lichvar wrote:
> >
> > How about separating the PHC timestamp from the ptp_system_timestamp
> > structure and use NULL to indicate we don't want to read the system
> > clock? A gettimex64(ptp, ts, NULL) call would be equal to
> > gettime64(ptp, ts).
> 
> Doesn't sound too bad to me.
> 
> Thanks,
> Richard

Yep, this seems fine to me as well.

Regards,
Jake
