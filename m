From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 2 Dec 2020 14:10:29 -0600
Subject: [Intel-wired-lan] [PATCH v2 1/5] e1000e: fix S0ix flow to allow
 S0i3.2 subset entry
In-Reply-To: <20201202161748.128938-2-mario.limonciello@dell.com>
Message-ID: <20201202201029.GA1464938@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Dec 02, 2020 at 10:17:44AM -0600, Mario Limonciello wrote:
> From: Vitaly Lifshits <vitaly.lifshits@intel.com>
> 
> Changed a configuration in the flows to align with
> architecture requirements to achieve S0i3.2 substate.

I guess this is really talking about requirements of a specific
CPU/SOC before it will enter S0i3.2?

> Also fixed a typo in the previous commit 632fbd5eb5b0
> ("e1000e: fix S0ix flows for cable connected case").

Not clear what the typo was, maybe these?

  > -	ew32(FEXTNVM12, mac_data);
  > +	ew32(FEXTNVM6, mac_data);

  > -	ew32(FEXTNVM12, mac_data);
  > +	ew32(FEXTNVM6, mac_data);

I would probably have put typo fixes in a separate patch, especially
since the cover letter mentions regressions related to 632fbd5eb5b0.
Maybe the commit log for the fix should mention that it's fixing a
regression, what the regression was, and include a Fixes: tag?  But
not my circus.

> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index b30f00891c03..128ab6898070 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -6475,13 +6475,13 @@ static void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
>  
>  	/* Ungate PGCB clock */
>  	mac_data = er32(FEXTNVM9);
> -	mac_data |= BIT(28);
> +	mac_data &= ~BIT(28);
>  	ew32(FEXTNVM9, mac_data);
>  
>  	/* Enable K1 off to enable mPHY Power Gating */
>  	mac_data = er32(FEXTNVM6);
>  	mac_data |= BIT(31);
> -	ew32(FEXTNVM12, mac_data);
> +	ew32(FEXTNVM6, mac_data);
>  
>  	/* Enable mPHY power gating for any link and speed */
>  	mac_data = er32(FEXTNVM8);
> @@ -6525,11 +6525,11 @@ static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
>  	/* Disable K1 off */
>  	mac_data = er32(FEXTNVM6);
>  	mac_data &= ~BIT(31);
> -	ew32(FEXTNVM12, mac_data);
> +	ew32(FEXTNVM6, mac_data);
>  
>  	/* Disable Ungate PGCB clock */
>  	mac_data = er32(FEXTNVM9);
> -	mac_data &= ~BIT(28);
> +	mac_data |= BIT(28);
>  	ew32(FEXTNVM9, mac_data);
>  
>  	/* Cancel not waking from dynamic
> -- 
> 2.25.1
> 
