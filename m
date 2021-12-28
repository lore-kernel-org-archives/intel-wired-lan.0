From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Tue, 28 Dec 2021 00:06:37 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/9] e1000: switch to
 napi_consume_skb()
In-Reply-To: <20211123171840.157471-2-alexandr.lobakin@intel.com>
References: <20211123171840.157471-1-alexandr.lobakin@intel.com>
 <20211123171840.157471-2-alexandr.lobakin@intel.com>
Message-ID: <DM6PR11MB4218AFE1E9E4DD604693DFBC82439@DM6PR11MB4218.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next 1/9] e1000: switch to
> napi_consume_skb()
> 
> In order to take the best from per-cpu NAPI skbuff_head caches and CPU
> cycles, let's switch from dev_kfree_skb_any(), which passes skb back to the
> mm layer, to napi_consume_skb(), which feeds those caches on non-zero
> budget instead (falls back to the former on 0).
> Do the replacement in e1000_unmap_and_free_tx_resource(). There are
> 4 call sites of this function throughout the driver:
>  * e1000_clean_tx_ring(). Slowpath, process context, cleans the
>    whole Tx ring on ifdown. Use budget of 0 here;
>  * e1000_tx_map(). Hotpath, net Tx softirq, unmaps the buffers in
>    case of error. Use 0 as well;
>  * e1000_clean_tx_irq(). Hotpath, NAPI Tx completion polling cycle.
>    As the driver doesn't count completed Tx entries towards the NAPI
>    budget, just use the poll budget of 64 to utilize caches.
> 
> Apart from being a preparation for switching to napi_build_skb(), this is
> useful on its own as well, as napi_consume_skb() flushes skb caches by
> batches of 32 instead of one-at-a-time.
> 
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


