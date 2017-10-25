From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 25 Oct 2017 20:40:44 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: add array bounds check
In-Reply-To: <1508772111-4527-1-git-send-email-paul.greenwalt@intel.com>
References: <1508772111-4527-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAD65A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Paul Greenwalt
> Sent: Monday, October 23, 2017 8:22 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: add array bounds check
> 
> Add bounds check for index fcoe_i of rx_ring array.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


