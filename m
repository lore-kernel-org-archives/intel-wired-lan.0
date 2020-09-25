From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 25 Sep 2020 07:16:38 +0200
Subject: [Intel-wired-lan] [PATCH v3] e1000e: Increase iteration on
 polling MDIC ready bit
In-Reply-To: <20200924164542.19906-1-kai.heng.feng@canonical.com>
References: <20200924150958.18016-1-kai.heng.feng@canonical.com>
 <20200924164542.19906-1-kai.heng.feng@canonical.com>
Message-ID: <1497f846-40d2-ddc8-60be-ffd117ffc0b7@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Kai-Heng,


Thank you for patch version 3.

Am 24.09.20 um 18:45 schrieb Kai-Heng Feng:
> We are seeing the following error after S3 resume:
> [  704.746874] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
> [  704.844232] e1000e 0000:00:1f.6 eno1: MDI Write did not complete
> [  704.902817] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
> [  704.903075] e1000e 0000:00:1f.6 eno1: reading PHY page 769 (or 0x6020 shifted) reg 0x17
> [  704.903281] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
> [  704.903486] e1000e 0000:00:1f.6 eno1: writing PHY page 769 (or 0x6020 shifted) reg 0x17
> [  704.943155] e1000e 0000:00:1f.6 eno1: MDI Error
> ...
> [  705.108161] e1000e 0000:00:1f.6 eno1: Hardware Error
> 
> As Andrew Lunn pointed out, MDIO has nothing to do with phy, and indeed
> increase polling iteration can resolve the issue.
> 
> The root cause is quite likely Intel ME, since it's a blackbox to the
> kernel so the only approach we can take is to be patient and wait
> longer.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
>   - Moving delay to end of loop doesn't save anytime, move it back.
>   - Point out this is quitely likely caused by Intel ME.

quietly

You seem to have missed my comments regarding patch version 3. It?d be 
great if you improved the commit message with my suggestions.

Without knowing what hardware this happened on, nobody, even later 
getting the hardware, can reproduce the your results. If you say the ME 
is involved, please also document the ME firmware version, which is used 
here.

> v2:
>   - Increase polling iteration instead of powering down the phy.
> 
>   drivers/net/ethernet/intel/e1000e/phy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
> index e11c877595fb..e6d4acd90937 100644
> --- a/drivers/net/ethernet/intel/e1000e/phy.c
> +++ b/drivers/net/ethernet/intel/e1000e/phy.c
> @@ -203,7 +203,7 @@ s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
>   	 * Increasing the time out as testing showed failures with
>   	 * the lower time out
>   	 */
> -	for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
> +	for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 10); i++) {
>   		udelay(50);
>   		mdic = er32(MDIC);
>   		if (mdic & E1000_MDIC_READY)

In the PCI subsystem, a warning is shown, when something takes more then 
100 ms. As you increase it to over 320 ms, a warning should be printed 
to talk to the firmware folks, when it passes 100 ms.


Kind regards,

Paul
