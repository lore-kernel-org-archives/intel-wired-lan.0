From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 5 Jan 2021 13:23:14 +0100
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Added Asym_Pause to
 supported link modes
In-Reply-To: <20210104150002.10916-1-mateusz.palczewski@intel.com>
References: <20210104150002.10916-1-mateusz.palczewski@intel.com>
Message-ID: <20210105122314.GC13327@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jan 04, 2021 at 03:00:02PM +0000, Mateusz Palczewski wrote:
> Add Asym_Pause to supported link modes (it is supported by HW).
> Lack of Asym_Pause in supported modes can cause several problems,
> i.e. it won't be possible to turn the autonegotiation on
> with asymmetric pause settings (i.e. Tx on, Rx off).
> 

If it's a fix, it needs a fixes tag.
Also, use imperative mood in your subject line.

> 
> Signed-off-by: Dawid Lukwinski <dawid.lukwinski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 2b6d887..45f5dc2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -1101,6 +1101,7 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
>  
>  	/* Set flow control settings */
>  	ethtool_link_ksettings_add_link_mode(ks, supported, Pause);
> +	ethtool_link_ksettings_add_link_mode(ks, supported, Asym_Pause);
>  
>  	switch (hw->fc.requested_mode) {
>  	case I40E_FC_FULL:
> -- 
> 2.17.1
> 
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
> Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
>  
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
