From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Oct 2017 16:41:38 +0000
Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] i40e: Fix memory
 leak related filter programming status
In-Reply-To: <1507622471.1185.17.camel@cohaesio.com>
References: <20171004153903.13100.38029.stgit@localhost.localdomain>
 <1507622471.1185.17.camel@cohaesio.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAC1A0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anders K. Pedersen | Cohaesio
> Sent: Tuesday, October 10, 2017 1:01 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
> alexander.duyck at gmail.com
> Subject: Re: [Intel-wired-lan] [jkirsher/net-queue PATCH] i40e: Fix memory
> leak related filter programming status
> 
> On ons, 2017-10-04 at 08:44 -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@intel.com>
> >
> > It looks like we weren't correctly placing the pages from buffers that
> > had been used to return a filter programming status back on the ring.
> > As a result they were being overwritten and tracking of the pages was
> > lost.
> >
> > This change works to correct that by incorporating part of
> > i40e_put_rx_buffer into the programming status handler code. As a
> > result we should now be correctly placing the pages for those buffers
> > on the re-allocation list instead of letting them stay in place.
> >
> > Fixes: 0e626ff7ccbf ("i40e: Fix support for flow director programming
> > status")
> > Reported-by: Anders K. Pedersen <akp@cohaesio.com>
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> We rebooted the router that had memory leaks on 4.12 and 4.13 kernels with
> 4.13.5 plus this patch this morning, and the memory leak is gone, so
> 
> Tested-by: Anders K. Pedersen <akp@cohaesio.com>

I also tested it and no leaks so

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

