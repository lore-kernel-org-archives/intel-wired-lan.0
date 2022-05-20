From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 20 May 2022 09:19:37 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 06/11] igc: Add support
 for receiving errored frames
In-Reply-To: <20220520011538.1098888-7-vinicius.gomes@intel.com>
References: <20220520011538.1098888-1-vinicius.gomes@intel.com>
 <20220520011538.1098888-7-vinicius.gomes@intel.com>
Message-ID: <20220520091936.x5ci5nkkp2lm7k6l@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, May 19, 2022 at 06:15:33PM -0700, Vinicius Costa Gomes wrote:
> While developing features that require sending potencially ill formed
> frames, it is useful being able to receive them on the other side.
> 
> The driver already had all the pieces in place to support that, all
> that was missing was put the flag in the list of supported features.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---

Is this required to run the verification state machine in software, or
just for debugging?

>  drivers/net/ethernet/intel/igc/igc_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index bcbf35b32ef3..5dd7140bac82 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6318,6 +6318,7 @@ static int igc_probe(struct pci_dev *pdev,
>  
>  	/* copy netdev features into list of user selectable features */
>  	netdev->hw_features |= NETIF_F_NTUPLE;
> +	netdev->hw_features |= NETIF_F_RXALL;
>  	netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_TX;
>  	netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
>  	netdev->hw_features |= netdev->features;
> -- 
> 2.35.3
>
