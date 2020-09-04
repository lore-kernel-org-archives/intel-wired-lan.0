From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 4 Sep 2020 18:17:39 +0000
Subject: [Intel-wired-lan] [PATCH v2] i40e: fix return of uninitialized
 aq_ret in i40e_set_vsi_promisc
In-Reply-To: <20200813112638.12699-1-sassmann@kpanic.de>
References: <20200813112638.12699-1-sassmann@kpanic.de>
Message-ID: <DM6PR11MB289078074C929E1892B65CFEBC2D0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Stefan Assmann
> Sent: Thursday, August 13, 2020 4:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; sassmann at kpanic.de; kuba at kernel.org;
> davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH v2] i40e: fix return of uninitialized aq_ret in
> i40e_set_vsi_promisc
> 
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function
> ?i40e_set_vsi_promisc?:
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1176:14: error: ?aq_ret?
> may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   i40e_status aq_ret;
> 
> In case the code inside the if statement and the for loop does not get
> executed aq_ret will be uninitialized when the variable gets returned at
> the end of the function.
> 
> Avoid this by changing num_vlans from int to u16, so aq_ret always gets
> set. Making this change in additional places as num_vlans should never
> be negative.
> 
> Fixes: 37d318d7805f ("i40e: Remove scheduling while atomic possibility")
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
