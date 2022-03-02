From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 2 Mar 2022 09:54:42 +0000
Subject: [Intel-wired-lan] [PATCH net v1] ice: Fix curr_link_speed
 advertised speed
In-Reply-To: <20220222114304.126803-1-jedrzej.jagielski@intel.com>
References: <20220222114304.126803-1-jedrzej.jagielski@intel.com>
Message-ID: <BYAPR11MB336709F8B25883DE9E0134C9FC039@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jagielski, Jedrzej
> Sent: Tuesday, February 22, 2022 5:13 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Siwik, Grzegorz <grzegorz.siwik@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] ice: Fix curr_link_speed advertised
> speed
> 
> Change curr_link_speed advertised speed, due to link_info.link_speed is not
> equal phy.curr_user_speed_req.
> Without this patch it is impossible to set adverised speed to same as
> link_speed.
> 
> Testing Hints: Try to set advertised speed to 25G only with 25G default link
> (use ethtool -s 0x80000000)
> 
> Fixes: 48cb27f2fd18 ("ice: Implement handlers for ethtool PHY/link
> operations")
> Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
