From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Sun, 10 Sep 2017 09:56:52 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: changed some expensive calls
 of udelay to usleep_range
In-Reply-To: <1504643244-9233-1-git-send-email-Michael.Kardonik@nxp.com>
References: <1504643244-9233-1-git-send-email-Michael.Kardonik@nxp.com>
Message-ID: <f1f885ed-5a2e-5ac0-c322-0eb387c7b749@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/5/2017 23:27, Kardonik Michael wrote:
> Calls to udelay are not preemtable by userspace so userspace
> applications experience a large (~200us) latency when running on core0.
> Instead usleep_range can be used to be more friendly to userspace
> since it is preemtable. This is due to udelay using busy-wait loops
> while usleep_rang uses hrtimers instead. It is recommended to use
> udelay when the delay is <10us since@that precision overhead of
> usleep_range hrtimer setup causes issues. However, the replaced calls
> are for 50us and 100us so this should not be not an issue.
> There is no open bug that this patch is fixing, but we see a good
> boost in zero loss performance of specific user space application
> (dpdk l3fwd) when this patch is applied: we get from 32% of 10Gb line
> to 49%.
>
> Signed-off-by: Matthew Tan <matthew.tan_1@nxp.com>
> Signed-off-by: Michael Kardonik <michael.kardonik@nxp.com>
>
> ---
>   drivers/net/ethernet/intel/e1000e/phy.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
> index de13aea..e318fdc 100644
> --- a/drivers/net/ethernet/intel/e1000e/phy.c
> +++ b/drivers/net/ethernet/intel/e1000e/phy.c
> @@ -158,7 +158,7 @@ s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
>   	 * the lower time out
>   	 */
>   	for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
> -		udelay(50);
> +		usleep_range(50, 60);
>   		mdic = er32(MDIC);
>   		if (mdic & E1000_MDIC_READY)
>   			break;
> @@ -183,7 +183,7 @@ s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
>   	 * reading duplicate data in the next MDIC transaction.
>   	 */
>   	if (hw->mac.type == e1000_pch2lan)
> -		udelay(100);
> +		usleep_range(100, 110);
>   
>   	return 0;
>   }
> @@ -222,7 +222,7 @@ s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
>   	 * the lower time out
>   	 */
>   	for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
> -		udelay(50);
> +		usleep_range(50, 60);
>   		mdic = er32(MDIC);
>   		if (mdic & E1000_MDIC_READY)
>   			break;
> @@ -246,7 +246,7 @@ s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
>   	 * reading duplicate data in the next MDIC transaction.
>   	 */
>   	if (hw->mac.type == e1000_pch2lan)
> -		udelay(100);
> +		usleep_range(100, 110);
>   
>   	return 0;
>   }

I see you submit another patch, same 
as_http://patchwork.ozlabs.org/patch/805153/ 
<http://patchwork.ozlabs.org/patch/805153/>_just changes a minimum of 
range.  Another point that I would like clarify, e1000e driver serve 1G 
client products. How it improve performance of 10Gb line? (you mentioned 
above). This is impossible. Please, explain. Also, as I wrote in 
previous patch comments, I would like see open bug for this problem.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170910/719800ba/attachment.html>
