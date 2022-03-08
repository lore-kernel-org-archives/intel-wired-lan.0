From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 8 Mar 2022 10:31:41 +0100
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix BUG: scheduling while
 atomic: kworker/u64:0/9/0x00000002
In-Reply-To: <20220308092422.2971655-1-sasha.neftin@intel.com>
References: <20220308092422.2971655-1-sasha.neftin@intel.com>
Message-ID: <YicifXBo5S6pSXAj@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 08, 2022 at 11:24:22AM +0200, Sasha Neftin wrote:
> Replace usleep_range() method with udelay() method to allow atomic contects

s/contects/contexts

> in low-level MDIO access functions.
> 
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2014971

I don't have access to that bugzilla, so can I ask to include the splat in
the commit message itself?

> Fixes: 5586838fe9ce ("igc: Add code for PHY support")
> Reported-by: Corinna Vinschen <vinschen@redhat.com>
> Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_phy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
> index 40dbf4b43234..6961f65d36b9 100644
> --- a/drivers/net/ethernet/intel/igc/igc_phy.c
> +++ b/drivers/net/ethernet/intel/igc/igc_phy.c
> @@ -581,7 +581,7 @@ static s32 igc_read_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 *data)
>  	 * the lower time out
>  	 */
>  	for (i = 0; i < IGC_GEN_POLL_TIMEOUT; i++) {
> -		usleep_range(500, 1000);
> +		udelay(50);
>  		mdic = rd32(IGC_MDIC);
>  		if (mdic & IGC_MDIC_READY)
>  			break;
> @@ -638,7 +638,7 @@ static s32 igc_write_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 data)
>  	 * the lower time out
>  	 */
>  	for (i = 0; i < IGC_GEN_POLL_TIMEOUT; i++) {
> -		usleep_range(500, 1000);
> +		udelay(50);
>  		mdic = rd32(IGC_MDIC);
>  		if (mdic & IGC_MDIC_READY)
>  			break;
> -- 
> 2.30.2
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
