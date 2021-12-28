From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Tue, 28 Dec 2021 00:07:27 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/9] e1000: switch to
 napi_build_skb()
In-Reply-To: <20211123171840.157471-3-alexandr.lobakin@intel.com>
References: <20211123171840.157471-1-alexandr.lobakin@intel.com>
 <20211123171840.157471-3-alexandr.lobakin@intel.com>
Message-ID: <DM6PR11MB4218120DF7ABE8B9054023D982439@DM6PR11MB4218.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Lobakin
> Sent: Tuesday, November 23, 2021 9:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; linux-kernel at vger.kernel.org; Jakub Kicinski
> <kuba@kernel.org>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net-next 2/9] e1000: switch to
> napi_build_skb()
> 
> napi_build_skb() reuses per-cpu NAPI skbuff_head cache in order to save
> some cycles on freeing/allocating skbuff_heads on every new Rx or
> completed Tx element.
> e1000 driver runs Tx completion polling cycle right before the Rx one. Now
> that e1000 uses napi_consume_skb() to put skbuff_heads of completed
> entries into the cache, it will never empty and always warm at that moment.
> Switch to the napi_build_skb() to relax mm pressure on heavy Rx and
> increase throughput.
> 
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


