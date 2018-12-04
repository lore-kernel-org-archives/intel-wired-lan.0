From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 4 Dec 2018 16:57:34 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: fix mac filter delete when
 setting mac address
In-Reply-To: <20181204141852.13893-1-sassmann@kpanic.de>
References: <20181204141852.13893-1-sassmann@kpanic.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32C5F6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Stefan Assmann
> Sent: Tuesday, December 4, 2018 6:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH] i40e: fix mac filter delete when setting
> mac address
> 
> A previous commit moved the ether_addr_copy() in i40e_set_mac() before
> the mac filter del/add to avoid a race. However it wasn't taken into account
> that this alters the mac address being handed to i40e_del_mac_filter().
> 
> Also changed i40e_add_mac_filter() to operate on netdev->dev_addr,
> hopefully that makes the code easier to read.
> 
> Fixes: 458867b2ca0c ("i40e: don't remove netdev->dev_addr when syncing
> uc list")
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


