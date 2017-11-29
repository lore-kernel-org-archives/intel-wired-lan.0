From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Nov 2017 17:07:24 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 09/16] ixgbe:
 Default to 1 pool always being allocated
In-Reply-To: <20171122185705.29785.4436.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
 <20171122185705.29785.4436.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAFC9E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, November 22, 2017 10:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 09/16] ixgbe: Default
> to 1 pool always being allocated
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> We might as well configure the limit to default to 1 pool always for the
> interface. This accounts for the fact that the PF counts as 1 pool if SR-IOV is
> enabled, and in general we are always running in 1 pool mode when RSS or
> DCB is enabled as well, though we don't need to actually evaulate any of the
> VMDq features in those cases.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |    1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    7 ++-----
>  2 files changed, 3 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


