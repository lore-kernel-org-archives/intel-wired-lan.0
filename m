From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 10 May 2022 09:04:21 +0200
Subject: [Intel-wired-lan] [PATCH] igc: Correct the launchtime offset
In-Reply-To: <20220509010847.17492-1-muhammad.husaini.zulkifli@intel.com>
References: <20220509010847.17492-1-muhammad.husaini.zulkifli@intel.com>
Message-ID: <d9807c38-81a1-a1d9-cc77-802c2a5755cb@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Muhammad,


Thank you for your patch.

Am 09.05.22 um 03:08 schrieb Muhammad Husaini Zulkifli:
> The launchtime offset can be corrected according to sections 7.5.2.6
> and 12.3.2 of the datasheet.

?can? or ?should??

Sorry, what is the name of the datasheet?

What problems does it fix, and how can they be reproduced?

> Based on the preliminary data, this correction is roughly 1500ns.
> In the future, proper measurements must be taken, and corrections must take
> into account the various link speeds.

Nit: Please do not wrap lines just because a sentence ends. If these are 
paragraphs, then please separate those by exactly one blank line.

> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_regs.h |  1 +
>   drivers/net/ethernet/intel/igc/igc_tsn.c  | 14 ++++++++++++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
> index e197a33d93a0..928d22b1ca22 100644
> --- a/drivers/net/ethernet/intel/igc/igc_regs.h
> +++ b/drivers/net/ethernet/intel/igc/igc_regs.h
> @@ -231,6 +231,7 @@
>   #define IGC_BASET_H		0x3318
>   #define IGC_QBVCYCLET		0x331C
>   #define IGC_QBVCYCLET_S		0x3320
> +#define IGC_GTXOFFSET		0x3310

Sort these by the value?

>   
>   #define IGC_STQT(_n)		(0x3324 + 0x4 * (_n))
>   #define IGC_ENDQT(_n)		(0x3334 + 0x4 * (_n))
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index 0fce22de2ab8..3d4d0ab011e3 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -84,12 +84,26 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
>   	struct igc_hw *hw = &adapter->hw;
>   	u32 tqavctrl, baset_l, baset_h;
>   	u32 sec, nsec, cycle;
> +	u16 tx_offset;

Please append the unit to the variable name.

Why specify the size, and not just use `unsigned int` [1]? (`__writel()` 
also uses `unsigned int` in the end?

>   	ktime_t base_time, systim;
>   	int i;
>   
>   	cycle = adapter->cycle_time;
>   	base_time = adapter->base_time;
>   
> +	switch (adapter->link_speed) {
> +	/* TODO: This code use same transmit offset across all link speed as for now. */
> +	case SPEED_10:
> +	case SPEED_100:
> +	case SPEED_1000:
> +	case SPEED_2500:
> +		tx_offset = 1500;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	wr32(IGC_GTXOFFSET, tx_offset);
>   	wr32(IGC_TSAUXC, 0);
>   	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
>   	wr32(IGC_TXPBS, IGC_TXPBSIZE_TSN);


Kind regards,

Paul


[1]: https://notabs.org/coding/smallIntsBigPenalty.htm
