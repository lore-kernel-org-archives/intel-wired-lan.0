From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 20 May 2022 09:33:29 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 05/11] igc: Optimze TX
 buffer sizes for TSN
In-Reply-To: <20220520011538.1098888-6-vinicius.gomes@intel.com>
References: <20220520011538.1098888-1-vinicius.gomes@intel.com>
 <20220520011538.1098888-6-vinicius.gomes@intel.com>
Message-ID: <20220520093329.luygziggncwxghle@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, May 19, 2022 at 06:15:32PM -0700, Vinicius Costa Gomes wrote:
> There are 64KB buffer space shared for TX and RX (including the BMC).
> We were only reserving 22KB for TX, increase each TX buffer (per
> queue) by 2KB, the total is now 30KB for TX.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---

Typo in title: optimize

>  drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index f609b2dbbc28..62fff53254dd 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -395,7 +395,7 @@
>  #define I225_TXPBSIZE_DEFAULT	0x04000014 /* TXPBSIZE default */
>  #define IGC_RXPBS_CFG_TS_EN	0x80000000 /* Timestamp in Rx buffer */
>  
> -#define IGC_TXPBSIZE_TSN	0x04145145 /* 5k bytes buffer for each queue */
> +#define IGC_TXPBSIZE_TSN	0x041c71c7 /* 7KB buffer for each queue + 2KB for BMC */
>  #define IGC_RXPBSIZE_TSN	0x0000f08f /* 15KB for EXP + 15KB for BE + 2KB for BMC */
>  #define IGC_RXPBSIZE_SIZE_MASK	0x0001FFFF
>  
> -- 
> 2.35.3
>
