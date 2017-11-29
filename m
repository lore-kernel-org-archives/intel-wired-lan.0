From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Nov 2017 17:04:58 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 07/16] ixgbe: Drop
 l2_accel_priv data pointer from ring struct
In-Reply-To: <20171122185652.29785.75613.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
 <20171122185652.29785.75613.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAFC7E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 07/16] ixgbe: Drop
> l2_accel_priv data pointer from ring struct
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The l2 acceleration private pointer isn't needed in the ring struct. It isn't really
> used anywhere other than to test and see if we are supporting an offloaded
> macvlan netdev, and it is much easier to test netdev for not being ixgbe
> based to verify that.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    1 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   23 +++++++++++++-------
> ---
>  2 files changed, 13 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


