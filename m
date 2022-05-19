From: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Date: Thu, 19 May 2022 16:42:22 +0800
Subject: [Intel-wired-lan] [PATCH v2 1/1] e1000e: Enable GPT clock
 before sending message to CSME
In-Reply-To: <20220508070905.1878172-1-sasha.neftin@intel.com>
References: <20220508070905.1878172-1-sasha.neftin@intel.com>
Message-ID: <20220519084222.GA1624511@acelan-xps15-9560>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, May 08, 2022 at 10:09:05AM +0300, Sasha Neftin wrote:
> On corporate (CSME) ADL systems, the Ethernet Controller may stop working
> ("HW unit hang") after exiting from the s0ix state. The reason is that
> CSME misses the message sent by the host. Enabling the dynamic GPT clock
> solves this problem. This clock is cleared upon HW initialization.
> 
> Fixes: 3e55d231716e ("e1000e: Add handshake with the CSME to support S0ix")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=214821
> Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>

This commit fixed the hardware unit hang issue on my machine.

Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
> v2:
> Correct commit message and minor fix in comment.
>  drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index fa06f68c8c80..c64102b29862 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -6494,6 +6494,10 @@ static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
>  
>  	if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID &&
>  	    hw->mac.type >= e1000_pch_adp) {
> +		/* Keep the GPT clock enabled for CSME */
> +		mac_data = er32(FEXTNVM);
> +		mac_data |= BIT(3);
> +		ew32(FEXTNVM, mac_data);
>  		/* Request ME unconfigure the device from S0ix */
>  		mac_data = er32(H2ME);
>  		mac_data &= ~E1000_H2ME_START_DPG;
