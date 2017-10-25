From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 25 Oct 2017 19:42:09 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Fix TX map failure path
In-Reply-To: <20171019190736.2770-1-jean-philippe.brucker@arm.com>
References: <20171019190736.2770-1-jean-philippe.brucker@arm.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAD5FD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jean-Philippe Brucker
> Sent: Thursday, October 19, 2017 12:08 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] igb: Fix TX map failure path
> 
> When the driver cannot map a TX buffer, instead of rolling back gracefully
> and retrying later, we currently get a panic:
> 
> [  159.885994] igb 0000:00:00.0: TX DMA map failed [  159.886588] Unable to
> handle kernel paging request at virtual address ffff00000a08c7a8
>                ...
> [  159.897031] PC is at igb_xmit_frame_ring+0x9c8/0xcb8
> 
> Fix the erroneous test that leads to this situation.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


