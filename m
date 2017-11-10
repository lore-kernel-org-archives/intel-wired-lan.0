From: Duyck, Alexander H <alexander.h.duyck@intel.com>
Date: Fri, 10 Nov 2017 17:37:36 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 1/5] ixgbe: Fix
 interaction between SR-IOV and macvlan offload
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAE695@ORSMSX104.amr.corp.intel.com>
References: <20171102232857.15146.21583.stgit@localhost.localdomain>
 <20171102233315.15146.95215.stgit@localhost.localdomain>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAE695@ORSMSX104.amr.corp.intel.com>
Message-ID: <1510335453.28435.8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2017-11-09 at 22:39 +0000, Bowers, AndrewX wrote:
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> > Behalf Of Alexander Duyck
> > Sent: Thursday, November 2, 2017 4:34 PM
> > To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 1/5] ixgbe: Fix
> > interaction between SR-IOV and macvlan offload
> > 
> > From: Alexander Duyck <alexander.h.duyck@intel.com>
> > 
> > When SR-IOV was enabled the macvlan offload was configuring several filters
> > with the wrong pool value. This would result in the macvlan interfaces not
> > being able to receive traffic that had to pass over the physical interface.
> > 
> > To fix it wrap the pool argument in the VMDQ_P macro which will add the
> > necessary offset to get to the actual VMDq pool
> > 
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

Actually I think I want to NAK this patch and the fm10k one that came
after it. I need to redo both of them anyway so I might as well just
re-submit the whole set.

- Alex
