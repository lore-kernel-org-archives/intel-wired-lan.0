From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 13 Sep 2021 07:28:15 +0000
Subject: [Intel-wired-lan] [PATCH net-nex6] ice: Fix newline at the end
 of NL_SET_ERR_MSG_MOD
In-Reply-To: <20210826082333.12293-1-wojciech.drewek@intel.com>
References: <20210826082333.12293-1-wojciech.drewek@intel.com>
Message-ID: <BYAPR11MB33676A44E99223F4C851DE5EFCD99@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Wojciech Drewek
> Sent: Thursday, August 26, 2021 1:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-nex6] ice: Fix newline at the end of
> NL_SET_ERR_MSG_MOD
> 
> Newline character is not needed at the end of NL_SET_ERR_MSG_MOD.
> 
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
