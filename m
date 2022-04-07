From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 7 Apr 2022 07:14:28 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: i40e_main: fix a missing check
 on list iterator
In-Reply-To: <20220327063606.7315-1-xiam0nd.tong@gmail.com>
References: <20220327063606.7315-1-xiam0nd.tong@gmail.com>
Message-ID: <BYAPR11MB33679D2463F0E8B3833CC64BFCE69@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Xiaomeng Tong
> Sent: Sunday, March 27, 2022 12:06 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Cc: pabeni at redhat.com; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; stable at vger.kernel.org; Xiaomeng Tong
> <xiam0nd.tong@gmail.com>; jeffrey.t.kirsher at intel.com;
> netdev at vger.kernel.org; kuba at kernel.org; davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH] i40e: i40e_main: fix a missing check on list
> iterator
> 
> The bug is here:
> 	ret = i40e_add_macvlan_filter(hw, ch->seid, vdev->dev_addr,
> &aq_err);
> 
> The list iterator 'ch' will point to a bogus position containing HEAD if the list is
> empty or no element is found. This case must be checked before any use of
> the iterator, otherwise it will lead to a invalid memory access.
> 
> To fix this bug, use a new variable 'iter' as the list iterator, while use the origin
> variable 'ch' as a dedicated pointer to point to the found element.
> 
> Cc: stable at vger.kernel.org
> Fixes: 1d8d80b4e4ff6 ("i40e: Add macvlan support on i40e")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 27 +++++++++++----------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
