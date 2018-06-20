From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jun 2018 17:19:02 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 3/7] ixgbe: Add
 code to populate and use macvlan tc to Tx queue map
In-Reply-To: <20180612151841.86792.33581.stgit@ahduyck-green-test.jf.intel.com>
References: <20180612151322.86792.97587.stgit@ahduyck-green-test.jf.intel.com>
 <20180612151841.86792.33581.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C80E9@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 3/7] ixgbe: Add
> code to populate and use macvlan tc to Tx queue map
> 
> This patch makes it so that we use the tc_to_txq mapping in the macvlan
> device in order to select the Tx queue for outgoing packets.
> 
> The idea here is to try and move away from using ixgbe_select_queue and to
> come up with a generic way to make this work for devices going forward. By
> encoding this information in the netdev this can become something that can
> be used generically as a solution for similar setups going forward.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   44
> ++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


