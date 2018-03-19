From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 19 Mar 2018 18:44:19 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix read-modify-write in x550
 phy setup
In-Reply-To: <1521116527-49781-1-git-send-email-paul.greenwalt@intel.com>
References: <1521116527-49781-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94C961@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Paul Greenwalt
> Sent: Thursday, March 15, 2018 5:22 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix read-modify-write in x550 phy
> setup
> 
> Replaced an assignment operation with an OR operation.
> 
> The variable assignment was overwriting the value read from the PHY
> register. The OR operation sets only the intended register bits.
> 
> The bits that were being overwritten are reserved, so the assignment had no
> functional impact.
> 
> Reported by: Shannon Nelson <shannon.nelson@oracle.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


