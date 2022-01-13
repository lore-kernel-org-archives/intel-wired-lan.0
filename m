From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 13 Jan 2022 18:12:11 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: fix an error code in
 ice_cfg_phy_fec()
In-Reply-To: <20220107080206.GI22086@kili>
References: <20220107080206.GI22086@kili>
Message-ID: <BYAPR11MB336762F8D52112D0A24DA039FC539@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Dan Carpenter
> Sent: Friday, January 7, 2022 1:32 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Cc: Swanson, Evan <evan.swanson@intel.com>; netdev at vger.kernel.org;
> kernel-janitors at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Jakub
> Kicinski <kuba@kernel.org>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net] ice: fix an error code in
> ice_cfg_phy_fec()
> 
> Propagate the error code from ice_get_link_default_override() instead of
> returning success.
> 
> Fixes: ea78ce4dab05 ("ice: add link lenient and default override support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> From static analysis.  Not tested!
> 
>  drivers/net/ethernet/intel/ice/ice_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
