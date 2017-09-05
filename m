From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Sep 2017 18:45:48 +0000
Subject: [Intel-wired-lan] [next PATCH S79-V2 09/13] i40e: Properly
 maintain	flow director filters list
In-Reply-To: <20170829093242.41026-9-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
 <20170829093242.41026-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA9943@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 29, 2017 2:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Sadowski, Filip <filip.sadowski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S79-V2 09/13] i40e: Properly maintain
> flow director filters list
> 
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> When there is no space for more flow director filters and user requested to
> add a new one it is rejected by firmware and automatically removed from
> the filter list maintained by driver. This behaviour is correct. Afterwards
> existing filter can be removed making free slot for the new one. This
> however causes the newly added filter to be accepted by firmware but
> removed from driver filter list resulting in not showing after issuing 'ethtool -
> n <dev_name>'.
> 
> This happended due to not clearing the variable pf->fd_inv which stores filter
> number to be removed from the list when firmware refused to add the
> requested filter. It caused the filter with this specific ID to be constantly
> removed once it was added to the list although it has been accepted by
> firmware and effectively applied to the NIC.
> It was fixed by clearing pf->fd_inv variable after removal of the filter from
> the list when it was rejected by firmware.
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


