From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jun 2018 17:19:38 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 4/7] net: Add
 support for subordinate traffic classes to netdev_pick_tx
In-Reply-To: <20180612151846.86792.83754.stgit@ahduyck-green-test.jf.intel.com>
References: <20180612151322.86792.97587.stgit@ahduyck-green-test.jf.intel.com>
 <20180612151846.86792.83754.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C80F9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, June 12, 2018 8:19 AM
> To: intel-wired-lan at osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 4/7] net: Add
> support for subordinate traffic classes to netdev_pick_tx
> 
> This change makes it so that we can support the concept of subordinate
> device traffic classes to the core networking code. In doing this we can start
> pulling out the driver specific bits needed to support selecting a queue based
> on an upper device.
> 
> The solution at is currently stands is only partially implemented. I have the
> start of some XPS bits in here, but I would still need to allow for configuration
> of the XPS maps on the queues reserved for the subordinate devices. For
> now I am using the reference to the sb_dev XPS map as just a way to skip the
> lookup of the lower device XPS map for now as that would result in the
> wrong queue being picked.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   19 +++-----
>  drivers/net/macvlan.c                         |   10 +---
>  include/linux/netdevice.h                     |    4 +-
>  net/core/dev.c                                |   57 +++++++++++++++----------
>  4 files changed, 45 insertions(+), 45 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


