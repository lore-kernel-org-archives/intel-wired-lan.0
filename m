From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Apr 2018 22:17:01 +0000
Subject: [Intel-wired-lan] [iwl next-queue PATCH 09/10] ixgbe: Drop
 real_adapter from l2 fwd acceleration structure
In-Reply-To: <20180403211640.7880.19722.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
 <20180403211640.7880.19722.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A95AF4F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, April 3, 2018 2:17 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [iwl next-queue PATCH 09/10] ixgbe: Drop
> real_adapter from l2 fwd acceleration structure
> 
> This patch drops the real_adapter member from the fwd_adapter structure.
> The general idea behind the change is that the real_adapter is carrying
> unnecessary data since we could always just grab the adapter structure from
> netdev_priv(macvlan->lowerdev) if we really needed to get at it.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    1 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   28 ++++++++++++++------
> -----
>  2 files changed, 16 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


