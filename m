From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 3 Dec 2021 14:45:52 +0000
Subject: [Intel-wired-lan] [PATCH net-next 8/9] ixgbe: switch to
 napi_build_skb()
In-Reply-To: <20211123171840.157471-9-alexandr.lobakin@intel.com>
References: <20211123171840.157471-1-alexandr.lobakin@intel.com>
 <20211123171840.157471-9-alexandr.lobakin@intel.com>
Message-ID: <BYAPR11MB33679BDF8869BEC763EFE25FFC6A9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Lobakin
> Sent: Tuesday, November 23, 2021 10:49 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; linux-kernel at vger.kernel.org; Jakub Kicinski
> <kuba@kernel.org>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net-next 8/9] ixgbe: switch to napi_build_skb()
> 
> napi_build_skb() reuses per-cpu NAPI skbuff_head cache in order to save some
> cycles on freeing/allocating skbuff_heads on every new Rx or completed Tx.
> ixgbe driver runs Tx completion polling cycle right before the Rx one and uses
> napi_consume_skb() to feed the cache with skbuff_heads of completed entries,
> so it's never empty and always warm at that moment. Switch to the
> napi_build_skb() to relax mm pressure on heavy Rx.
> 
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
