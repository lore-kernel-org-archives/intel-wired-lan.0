From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 21 Nov 2018 21:30:47 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix deletion of MAC filters
In-Reply-To: <20181121171537.36459-1-lihong.yang@intel.com>
References: <20181121171537.36459-1-lihong.yang@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32A92C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Lihong Yang
> Sent: Wednesday, November 21, 2018 9:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Fix deletion of MAC filters
> 
> In __i40e_del_filter function, the flag __I40E_MACVLAN_SYNC_PENDING for
> the PF state is wrongly set for the VSI. Deleting any of the MAC filters has
> caused the incorrect syncing for the PF. Fix it by setting this state flag to the
> intended PF.
> 
> Signed-off-by: Lihong Yang <lihong.yang@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


