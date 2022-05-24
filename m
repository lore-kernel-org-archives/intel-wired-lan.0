From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 24 May 2022 13:40:27 +0000
Subject: [Intel-wired-lan] [PATCH] intel/i40e: delete if NULL check
 before dev_kfree_skb
In-Reply-To: <20220511065451.655335-1-zhaojunkui2008@126.com>
References: <20220511065451.655335-1-zhaojunkui2008@126.com>
Message-ID: <BYAPR11MB33672B20A0116900DAFCB8AFFCD79@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Bernard Zhao
> Sent: Wednesday, May 11, 2022 12:25 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org
> Cc: bernard at vivo.com; Bernard Zhao <zhaojunkui2008@126.com>
> Subject: [Intel-wired-lan] [PATCH] intel/i40e: delete if NULL check before
> dev_kfree_skb
> 
> dev_kfree_skb check if the input parameter NULL and do the right thing,
> there is no need to check again.
> This change is to cleanup the code a bit.
> 
> Signed-off-by: Bernard Zhao <zhaojunkui2008@126.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
