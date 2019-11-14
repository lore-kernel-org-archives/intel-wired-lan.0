From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 14 Nov 2019 21:28:10 +0000
Subject: [Intel-wired-lan] [PATCH net 01/13] ptp: Validate requests to
 enable time stamping of external signals.
In-Reply-To: <20191114193806.GA19147@localhost>
References: <20191114184507.18937-2-richardcochran@gmail.com>
 <02874ECE860811409154E81DA85FBB589698F67E@ORSMSX121.amr.corp.intel.com>
 <20191114193806.GA19147@localhost>
Message-ID: <02874ECE860811409154E81DA85FBB589698FA96@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: netdev-owner at vger.kernel.org <netdev-owner@vger.kernel.org> On
> Behalf Of Richard Cochran
> Sent: Thursday, November 14, 2019 11:38 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; David Miller
> <davem@davemloft.net>; Brandon Streiff <brandon.streiff@ni.com>; Hall,
> Christopher S <christopher.s.hall@intel.com>; Eugenia Emantayev
> <eugenia@mellanox.com>; Felipe Balbi <felipe.balbi@linux.intel.com>; Feras
> Daoud <ferasda@mellanox.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com>; Stefan Sorensen
> <stefan.sorensen@spectralink.com>
> Subject: Re: [PATCH net 01/13] ptp: Validate requests to enable time stamping of
> external signals.
> 
> On Thu, Nov 14, 2019 at 07:06:58PM +0000, Keller, Jacob E wrote:
> > Just to confirm, these new ioctls haven't been around long enough to be
> concerned about this change?
> 
> The "2" ioctls are about to appear in v5.4, and so I want to get the
> flag checking in before the release if possible.
> 
> Thanks,
> Richard

Yes agreed, we should land these fixes before 5.4 if we can, in order to ensure that the new ioctls always behaved the same way since their first major release introduction.

Regards,
Jake
