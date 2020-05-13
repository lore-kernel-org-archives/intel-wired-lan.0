From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 13 May 2020 09:59:13 +0300
Subject: [Intel-wired-lan] [PATCH 2/2] igc: Fix IGC_MAX_RXNFC_RULES
In-Reply-To: <20200512173553.39460-2-andre.guedes@intel.com>
References: <20200512173553.39460-1-andre.guedes@intel.com>
 <20200512173553.39460-2-andre.guedes@intel.com>
Message-ID: <3cb071e1-28d4-c885-bc64-d5ab03cf9578@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/12/2020 20:35, Andre Guedes wrote:
> IGC supports a total of 32 rules. 16 MAC address based, 8 VLAN priority
> based, and 8 ethertype based. This patch fixes IGC_MAX_RXNFC_RULES
> accordingly.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 14f9edaaaf83..5dbc5a156626 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -457,7 +457,10 @@ struct igc_nfc_rule {
>   	u16 action;
>   };
>   
> -#define IGC_MAX_RXNFC_RULES		16
> +/* IGC supports a total of 32 NFC rules: 16 MAC address based,, 8 VLAN priority
> + * based, and 8 ethertype based.
> + */
> +#define IGC_MAX_RXNFC_RULES		32
>   
>   /* igc_desc_unused - calculate if we have unused descriptors */
>   static inline u16 igc_desc_unused(const struct igc_ring *ring)
> 
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
