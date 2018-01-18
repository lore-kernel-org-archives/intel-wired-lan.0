From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 18 Jan 2018 13:59:19 +0200
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
In-Reply-To: <20180118065054.29844-1-bpoirier@suse.com>
References: <20180118065054.29844-1-bpoirier@suse.com>
Message-ID: <cef5fe27-5948-0960-4948-1af3a212892e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/18/2018 08:50, Benjamin Poirier wrote:
> It was reported that emulated e1000e devices in vmware esxi 6.5 Build
> 7526125 do not link up after commit 4aea7a5c5e94 ("e1000e: Avoid receiver
> overrun interrupt bursts", v4.15-rc1). Some tracing shows that after
> e1000e_trigger_lsc() is called, ICR reads out as 0x0 in e1000_msix_other()
> on emulated e1000e devices. In comparison, on real e1000e 82574 hardware,
> icr=0x80000004 (_INT_ASSERTED | _OTHER) in the same situation.
>
> Some experimentation showed that this flaw in vmware e1000e emulation can
> be worked around by not setting Other in EIAC. This is how it was before
> 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1).
>
> Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>
> Jeff, I'm sending as RFC since it looks like a problem that should be fixed
> in vmware. If you'd like to have the workaround in e1000e, I'll submit.
>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 9f18d39bdc8f..625a4c9a86a4 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -1918,6 +1918,8 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
>   	bool enable = true;
>   
>   	icr = er32(ICR);
> +	ew32(ICR, E1000_ICR_OTHER);
> +
>   	if (icr & E1000_ICR_RXO) {
>   		ew32(ICR, E1000_ICR_RXO);
>   		enable = false;
> @@ -2040,7 +2042,6 @@ static void e1000_configure_msix(struct e1000_adapter *adapter)
>   		       hw->hw_addr + E1000_EITR_82574(vector));
>   	else
>   		writel(1, hw->hw_addr + E1000_EITR_82574(vector));
> -	adapter->eiac_mask |= E1000_IMS_OTHER;
>   
>   	/* Cause Tx interrupts on every write back */
>   	ivar |= BIT(31);
> @@ -2265,7 +2266,7 @@ static void e1000_irq_enable(struct e1000_adapter *adapter)
>   
>   	if (adapter->msix_entries) {
>   		ew32(EIAC_82574, adapter->eiac_mask & E1000_EIAC_MASK_82574);
> -		ew32(IMS, adapter->eiac_mask | E1000_IMS_LSC);
> +		ew32(IMS, adapter->eiac_mask | E1000_IMS_OTHER | E1000_IMS_LSC);
>   	} else if (hw->mac.type >= e1000_pch_lpt) {
>   		ew32(IMS, IMS_ENABLE_MASK | E1000_IMS_ECCER);
>   	} else {

Hello Benjamin,

Alexander Duyck has submitted follow patch 
https://patchwork.ozlabs.org/patch/862613/ addressed to 
"[ESXi][RHEL7.5]e1000 and e1000e NIC link can not up on VMWare 
ESXi"problem. Looks Red Hat happy with this solution. Let's them finish 
their tests and then decide about next step.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180118/4bd6ae00/attachment.html>
