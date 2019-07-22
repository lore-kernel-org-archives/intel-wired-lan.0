From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 22 Jul 2019 19:18:35 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: add check on
 i40e_configure_tx_ring() return value
In-Reply-To: <20190722115559.12041-1-huhai@kylinos.cn>
References: <20190722115559.12041-1-huhai@kylinos.cn>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40C555@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of huhai
> Sent: Monday, July 22, 2019 4:56 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net
> Cc: intel-wired-lan at lists.osuosl.org; huhai <huhai@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH] i40e: add check on
> i40e_configure_tx_ring() return value
> 
> When i40e_configure_tx_ring(vsi->tx_rings[i]) returns an error, we should
> exit from i40e_vsi_configure_tx and return the error, instead of continuing
> to check whether xdp is enable, and configure the xdp transmit ring.
> 
> Signed-off-by: huhai <huhai@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


