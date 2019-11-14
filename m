From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 14 Nov 2019 21:29:14 +0000
Subject: [Intel-wired-lan] [PATCH net 08/13] ptp: Introduce strict
 checking of external time stamp options.
In-Reply-To: <20191114194410.GB19147@localhost>
References: <20191114184507.18937-9-richardcochran@gmail.com>
 <02874ECE860811409154E81DA85FBB589698F6E0@ORSMSX121.amr.corp.intel.com>
 <20191114194410.GB19147@localhost>
Message-ID: <02874ECE860811409154E81DA85FBB589698FABB@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Thursday, November 14, 2019 11:44 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; David Miller
> <davem@davemloft.net>; Brandon Streiff <brandon.streiff@ni.com>; Hall,
> Christopher S <christopher.s.hall@intel.com>; Eugenia Emantayev
> <eugenia@mellanox.com>; Felipe Balbi <felipe.balbi@linux.intel.com>; Feras
> Daoud <ferasda@mellanox.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com>; Stefan Sorensen
> <stefan.sorensen@spectralink.com>
> Subject: Re: [PATCH net 08/13] ptp: Introduce strict checking of external time
> stamp options.
> 
> On Thu, Nov 14, 2019 at 07:12:38PM +0000, Keller, Jacob E wrote:
> > So, this patch adds the flag *and* modifies the drivers to accept it, but not
> actually enable strict checking?
> >
> > I'd prefer if this flag got added, and the drivers were modified in separate
> patches to both allow the flag and to perform the strict check.. that feels like a
> cleaner patch boundary.
> >
> > That would ofcourse break the drivers that reject the strict command until
> they're fixed in follow-on commands.. hmm
> 
> You are right, but if anything I'd squash the following four driver
> patches into this one.  I left the series in little steps just to make
> review easier.  Strictly speaking, if you were to do a git bisect from
> the introduction of the "2" ioctls until here, you would find drivers'
> acceptance of the new flags changing.  But it is too late to fix that,
> and I doubt anyone will care.
> 
> IMHO it *is* important to have v5.4 with strict checking.
> 
> Thanks,
> Richard

Yes I agree. I think the series is good as is, and having this fixed before the ioctls have been in a full release makes sense.

Thanks,
Jake
