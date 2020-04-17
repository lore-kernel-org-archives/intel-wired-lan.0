From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 17 Apr 2020 12:31:11 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e: Fixed issue with LSC pending.
In-Reply-To: <20200417110627.3589435-1-andrew@daynix.com>
References: <20200417110627.3589435-1-andrew@daynix.com>
Message-ID: <CAKgT0UfSFWu9VRzMY5PTwgzAgaeMx711Lip2hn=jbpyx-pn0uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Apr 17, 2020 at 3:39 AM <andrew@daynix.com> wrote:
>
> From: Andrew Melnychenko <andrew@daynix.com>
>
> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1707441
> The issue was detected with QEMU and doesn't reproduce on Windows guest.
> CTRL_EXT.IAME is disabled by
> rev 0a8047ac68e50e4ccbadcfc6b6b070805b976885:
> "to avoid disruption from potential programs that access the registers
> directly."
> So let's leave it like that and add interrupt pending clearance
> using write to ICR. It fixes the issue when removed cable can't be detected
> by the driver.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 177c6da80c57..064bb4a47131 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -1898,6 +1898,9 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
>         struct e1000_hw *hw = &adapter->hw;
>         u32 icr = er32(ICR);
>
> +       if (!(er32(CTRL_EXT) & E1000_CTRL_EXT_IAME))
> +               ew32(ICR, icr & ~E1000_ICR_INT_ASSERTED);
> +
>         if (icr & adapter->eiac_mask)
>                 ew32(ICS, (icr & adapter->eiac_mask));
>

So this would likely cause more issues then it helps. Specifically,
clearing the ICR should happen with any read of it as long as at least
one bit in the current mask is set, and the write doesn't make any
sense for actual hardware as the INT_ASSERTED bit is not clear on
write. It is cleared when the register is cleared.

I am pretty sure this is a bug in the QEMU side of the implementation,
specifically in e1000e_mac_icr_read
(https://lxr.missinglinkelectronics.com/qemu+v4.0.0/hw/net/e1000e_core.c#L2608).
If you look at section 13.3.27 of the 8257X developers manual
(https://lxr.missinglinkelectronics.com/qemu+v4.0.0/hw/net/e1000e_core.c#L2608)
it has a lengthy explanation about the ICR register in the "Note:"
section where it essentially explains that as long as any bit in the
IMS is set that corresponds to the ICR register value, and the
INT_ASSERTED bit is set then the entire ICR is cleared on read. The
IAME bit triggers something similar but it is based on the IAM
register which is why it worked prior to this patch.

The fix would likely to be to add a bit to QEMU to allow for clearing
the ICR register, or at least any bits from it that are set in the IMS
when it is read.
