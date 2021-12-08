From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Wed, 8 Dec 2021 10:15:30 +0200
Subject: [Intel-wired-lan] [PATCH net-next 7/9] igc: switch to
 napi_build_skb()
In-Reply-To: <20211123171840.157471-8-alexandr.lobakin@intel.com>
References: <20211123171840.157471-1-alexandr.lobakin@intel.com>
 <20211123171840.157471-8-alexandr.lobakin@intel.com>
Message-ID: <2eb0a775-2035-f806-b391-d3ce8d3e53a2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/23/2021 19:18, Alexander Lobakin wrote:
> napi_build_skb() reuses per-cpu NAPI skbuff_head cache in order
> to save some cycles on freeing/allocating skbuff_heads on every
> new Rx or completed Tx.
> igc driver runs Tx completion polling cycle right before the Rx
> one and uses napi_consume_skb() to feed the cache with skbuff_heads
> of completed entries, so it's never empty and always warm at that
> moment. Switch to the napi_build_skb() to relax mm pressure on
> heavy Rx.
> 
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>

