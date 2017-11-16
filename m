From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Nov 2017 22:21:33 +0000
Subject: [Intel-wired-lan] [next PATCH S82-V4 5/9] i40e: track id can be
 0
In-Reply-To: <20171114120052.86665-5-alice.michael@intel.com>
References: <20171114120052.86665-1-alice.michael@intel.com>
 <20171114120052.86665-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAEECC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, November 14, 2017 4:01 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Wu, Jingjing <jingjing.wu@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S82-V4 5/9] i40e: track id can be 0
> 
> From: Jingjing Wu <jingjing.wu@intel.com>
> 
> track_id == 0 is valid for ?read only? profiles when profile does not have any
> ?write? commands.
> 
> Signed-off-by: Jingjing Wu <jingjing.wu@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c   | 5 -----
>  drivers/net/ethernet/intel/i40evf/i40e_common.c | 5 -----
>  2 files changed, 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


