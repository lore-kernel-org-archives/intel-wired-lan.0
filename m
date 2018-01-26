From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 26 Jan 2018 13:01:11 -0800
Subject: [Intel-wired-lan] [PATCH 3/3] Revert "e1000e: Do not read ICR
 in Other interrupt"
In-Reply-To: <20180126091236.13044-4-bpoirier@suse.com>
References: <20180126091236.13044-1-bpoirier@suse.com>
 <20180126091236.13044-4-bpoirier@suse.com>
Message-ID: <CAKgT0Ue+JNL91jr08Ks3+Oj21fNApwuQH=bDEs2o3BKPigpyEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 26, 2018 at 1:12 AM, Benjamin Poirier <bpoirier@suse.com> wrote:
> This reverts commit 16ecba59bc333d6282ee057fb02339f77a880beb.
>
> It was reported that emulated e1000e devices in vmware esxi 6.5 Build
> 7526125 do not link up after commit 4aea7a5c5e94 ("e1000e: Avoid receiver
> overrun interrupt bursts"). Some tracing shows that after
> e1000e_trigger_lsc() is called, ICR reads out as 0x0 in e1000_msix_other()
> on emulated e1000e devices. In comparison, on real e1000e 82574 hardware,
> icr=0x80000004 (_INT_ASSERTED | _LSC) in the same situation.
>
> Some experimentation showed that this flaw in vmware e1000e emulation can
> be worked around by not setting Other in EIAC. This is how it was before
> commit 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt").
>
> Since the ICR read in the Other interrupt handler has already been
> restored, this patch effectively reverts the remainder of commit
> 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt").
>
> Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index ed103b9a8d3a..fffc1f0e3895 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -1916,6 +1916,13 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
>         struct e1000_hw *hw = &adapter->hw;
>         u32 icr = er32(ICR);
>
> +       /* Certain events (such as RXO) which trigger Other do not set
> +        * INT_ASSERTED. In that case, read to clear of icr does not take
> +        * place.
> +        */
> +       if (!(icr & E1000_ICR_INT_ASSERTED))
> +               ew32(ICR, E1000_ICR_OTHER);
> +

This piece doesn't make sense to me. Why are we clearing OTHER if
ICR_INT_ASSERTED is not set? The original code that was removed was in
commit 4d432f67ff00 "e1000e: Remove unreachable code" was setting IMS
and returning, not clearing the ICR register. I would argue that the
code is probably unreachable and if we just have the checks for OTHER
and LSC then we should be taking care of all of this in the task
anyway. All this code the code in the original was doing was
re-enabling the interrupt via IMS so we probably don't need this bit
as long as we are clearing OTHER and LSC when they are set so that we
can get future interrupts.

>         if (icr & adapter->eiac_mask)
>                 ew32(ICS, (icr & adapter->eiac_mask));
>
> @@ -2033,7 +2040,6 @@ static void e1000_configure_msix(struct e1000_adapter *adapter)
>                        hw->hw_addr + E1000_EITR_82574(vector));
>         else
>                 writel(1, hw->hw_addr + E1000_EITR_82574(vector));
> -       adapter->eiac_mask |= E1000_IMS_OTHER;
>
>         /* Cause Tx interrupts on every write back */
>         ivar |= BIT(31);
> @@ -2258,7 +2264,7 @@ static void e1000_irq_enable(struct e1000_adapter *adapter)
>
>         if (adapter->msix_entries) {
>                 ew32(EIAC_82574, adapter->eiac_mask & E1000_EIAC_MASK_82574);
> -               ew32(IMS, adapter->eiac_mask | E1000_IMS_LSC);
> +               ew32(IMS, adapter->eiac_mask | E1000_IMS_OTHER | E1000_IMS_LSC);
>         } else if (hw->mac.type >= e1000_pch_lpt) {
>                 ew32(IMS, IMS_ENABLE_MASK | E1000_IMS_ECCER);
>         } else {
> --
> 2.15.1
>
