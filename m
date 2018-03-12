From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Mar 2018 19:29:52 +0000
Subject: [Intel-wired-lan] [S87 v5 2/7] i40e: Cleanup
 i40e_vlan_rx_register
In-Reply-To: <20180308225211.12254-2-jeffrey.t.kirsher@intel.com>
References: <20180308225211.12254-1-jeffrey.t.kirsher@intel.com>
 <20180308225211.12254-2-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94BDFB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, March 8, 2018 2:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [S87 v5 2/7] i40e: Cleanup i40e_vlan_rx_register
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We used to use the function i40e_vlan_rx_register as a way to hook into the
> now defunct .ndo_vlan_rx_register netdev hook. This was removed but we
> kept the function around because we still used it internally to control
> enabling or disabling of VLAN stripping.
> 
> As pointed out in upstream review, VLAN stripping is only used in a single
> location and the previous function is quite small, just inline it into
> i40e_restore_vlan() rather than carrying the function separately.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


