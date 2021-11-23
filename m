From: Lifshits, Vitaly <vitaly.lifshits@intel.com>
Date: Tue, 23 Nov 2021 17:22:05 +0200
Subject: [Intel-wired-lan] [PATCH 1/3] Revert "e1000e: Additional PHY
 power saving in S0ix"
In-Reply-To: <20211122161927.874291-1-kai.heng.feng@canonical.com>
References: <20211122161927.874291-1-kai.heng.feng@canonical.com>
Message-ID: <14e6c86d-0764-ceaf-4244-fcbf2c2dc23e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Kai,


We believe that simply reverting these patches is not a good idea. It 
will cause the driver to behave on a corporate system as if the CSME 
firmwareis not there. This can lead to an unpredictable behavior in the 
long run.


The issue exposed by these patches is currently under active debug. We 
would like to find the root cause and fix it in a way that will still 
enable S0ix power savings on both corporate and consumer systems.


On 11/22/2021 18:19, Kai-Heng Feng wrote:
> This reverts commit 3ad3e28cb203309fb29022dea41cd65df0583632.
>
> The s0ix series makes e1000e on TGL and ADL fails to work after s2idle
> resume.
>
> There doesn't seem to be any solution soon, so revert the whole series.
>
> Bugzilla:https://bugzilla.kernel.org/show_bug.cgi?id=214821
> Signed-off-by: Kai-Heng Feng<kai.heng.feng@canonical.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 44e2dc8328a22..e16b7c0d98089 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -6380,16 +6380,10 @@ static void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
>   		ew32(CTRL_EXT, mac_data);
>   
>   		/* DFT control: PHY bit: page769_20[0] = 1
> -		 * page769_20[7] - PHY PLL stop
> -		 * page769_20[8] - PHY go to the electrical idle
> -		 * page769_20[9] - PHY serdes disable
>   		 * Gate PPW via EXTCNF_CTRL - set 0x0F00[7] = 1
>   		 */
>   		e1e_rphy(hw, I82579_DFT_CTRL, &phy_data);
>   		phy_data |= BIT(0);
> -		phy_data |= BIT(7);
> -		phy_data |= BIT(8);
> -		phy_data |= BIT(9);
>   		e1e_wphy(hw, I82579_DFT_CTRL, phy_data);
>   
>   		mac_data = er32(EXTCNF_CTRL);
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20211123/ba326345/attachment.html>
