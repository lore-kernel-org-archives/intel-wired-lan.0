From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 26 Oct 2021 11:47:55 +0300
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Add a delay to let ME
 unconfigure s0ix when DPG_EXIT_DONE is already flagged
In-Reply-To: <20211026065112.1366205-1-kai.heng.feng@canonical.com>
References: <20211026065112.1366205-1-kai.heng.feng@canonical.com>
Message-ID: <04ed8307-ab1f-59d6-4454-c759ce4a453b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/26/2021 09:51, Kai-Heng Feng wrote:
> On some ADL platforms, DPG_EXIT_DONE is always flagged so e1000e resume
> polling logic doesn't wait until ME really unconfigures s0ix.
> 
> So check DPG_EXIT_DONE before issuing EXIT_DPG, and if it's already
> flagged, wait for 1 second to let ME unconfigure s0ix.
> 
> Fixes: 3e55d231716e ("e1000e: Add handshake with the CSME to support S0ix")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=214821
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>   Add missing "Fixes:" tag
> 
>   drivers/net/ethernet/intel/e1000e/netdev.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 44e2dc8328a22..cd81ba00a6bc9 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -6493,14 +6493,21 @@ static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
>   	u32 mac_data;
>   	u16 phy_data;
>   	u32 i = 0;
> +	bool dpg_exit_done;
>   
>   	if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID) {
> +		dpg_exit_done = er32(EXFWSM) & E1000_EXFWSM_DPG_EXIT_DONE;
>   		/* Request ME unconfigure the device from S0ix */
>   		mac_data = er32(H2ME);
>   		mac_data &= ~E1000_H2ME_START_DPG;
>   		mac_data |= E1000_H2ME_EXIT_DPG;
>   		ew32(H2ME, mac_data);
>   
> +		if (dpg_exit_done) {
> +			e_warn("DPG_EXIT_DONE is already flagged. This is a firmware bug\n");
> +			msleep(1000);
> +		}
Thanks for working on the enablement.
The delay approach is fragile. We need to work with CSME folks to 
understand why _DPG_EXIT_DONE indication is wrong on some ADL platforms.
Could you provide CSME/BIOS version? dmidecode -t 0 and cat 
/sys/class/mei/mei0/fw_ver
>   		/* Poll up to 2.5 seconds for ME to unconfigure DPG.
>   		 * If this takes more than 1 second, show a warning indicating a
>   		 * firmware bug
>
