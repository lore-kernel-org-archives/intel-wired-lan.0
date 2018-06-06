From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Jun 2018 16:22:24 +0000
Subject: [Intel-wired-lan] [net-queue PATCH 2/2] ixgbe: Fix bit
 definitions and add support for testing for ipsec support
In-Reply-To: <7a763f87-64a0-3406-8ac8-c41c0fe75aef@oracle.com>
References: <20180605150520.3359.94409.stgit@ahduyck-green-test.jf.intel.com>
 <20180605151113.3359.74309.stgit@ahduyck-green-test.jf.intel.com>
 <7a763f87-64a0-3406-8ac8-c41c0fe75aef@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C630E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Tuesday, June 5, 2018 9:14 AM
> To: Duyck, Alexander H <alexander.h.duyck@intel.com>; intel-wired-
> lan at osuosl.org
> Subject: Re: [Intel-wired-lan] [net-queue PATCH 2/2] ixgbe: Fix bit definitions
> and add support for testing for ipsec support
> 
> On 6/5/2018 8:11 AM, Alexander Duyck wrote:
> > This patch addresses two issues. First it adds the correct bit
> > definitions for the SECTXSTAT and SECRXSTAT registers. Then it makes
> > use of those definitions to test for if ipsec has been disabled on the
> > part and if so we do not enable it.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Fixes: 63a67fe229ea ("ixgbe: add ipsec offload add and remove SA")
> Reported-by: Andre Tomt <andre@tomt.net>
> Acked-by: Shannon Nelson <shannon.nelson@oracle.com>
> 
> 
> > ---
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c |   14 +++++++++++++-
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |    6 ++++--
> >   2 files changed, 17 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


