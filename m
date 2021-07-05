From: Dave Airlie <airlied@gmail.com>
Date: Mon, 5 Jul 2021 17:47:00 +1000
Subject: [Intel-wired-lan] [PATCH 1/2] igc: don't rd/wr iomem when PCI
 is removed
In-Reply-To: <20210702045120.22855-1-aaron.ma@canonical.com>
References: <20210702045120.22855-1-aaron.ma@canonical.com>
Message-ID: <CAPM=9twzx0aa5Dq-L5oOSk+w8z7audCq_biXwtFVh3QVY1VceA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2 Jul 2021 at 14:53, Aaron Ma <aaron.ma@canonical.com> wrote:
>
> Check PCI state when rd/wr iomem.
> Implement wr32 function as rd32 too.
>
> When unplug TBT dock with i225, rd/wr PCI iomem will cause error log:
> Trace:
> BUG: unable to handle page fault for address: 000000000000b604
> Oops: 0000 [#1] SMP NOPTI
> RIP: 0010:igc_rd32+0x1c/0x90 [igc]
> Call Trace:
> igc_ptp_suspend+0x6c/0xa0 [igc]
> igc_ptp_stop+0x12/0x50 [igc]
> igc_remove+0x7f/0x1c0 [igc]
> pci_device_remove+0x3e/0xb0
> __device_release_driver+0x181/0x240
>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---

Drive-by, but won't this add a lot of overhead on every register
access? has this been benchmarked with lots of small network transfers
or anything?

Dave.


>  drivers/net/ethernet/intel/igc/igc_main.c | 16 ++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_regs.h |  7 ++-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index f1adf154ec4a..606b72cb6193 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -5292,6 +5292,10 @@ u32 igc_rd32(struct igc_hw *hw, u32 reg)
>         u8 __iomem *hw_addr = READ_ONCE(hw->hw_addr);
>         u32 value = 0;
>
> +       if (igc->pdev &&
> +               igc->pdev->error_state == pci_channel_io_perm_failure)
> +               return 0;
> +
>         value = readl(&hw_addr[reg]);
>
>         /* reads should not return all F's */
> @@ -5308,6 +5312,18 @@ u32 igc_rd32(struct igc_hw *hw, u32 reg)
>         return value;
>  }
>
> +void igc_wr32(struct igc_hw *hw, u32 reg, u32 val)
> +{
> +       struct igc_adapter *igc = container_of(hw, struct igc_adapter, hw);
> +       u8 __iomem *hw_addr = READ_ONCE(hw->hw_addr);
> +
> +       if (igc->pdev &&
> +               igc->pdev->error_state == pci_channel_io_perm_failure)
> +               return;
> +
> +       writel((val), &hw_addr[(reg)]);
> +}
> +
>  int igc_set_spd_dplx(struct igc_adapter *adapter, u32 spd, u8 dplx)
>  {
>         struct igc_mac_info *mac = &adapter->hw.mac;
> diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
> index cc174853554b..eb4be87d0e8b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_regs.h
> +++ b/drivers/net/ethernet/intel/igc/igc_regs.h
> @@ -260,13 +260,10 @@ struct igc_hw;
>  u32 igc_rd32(struct igc_hw *hw, u32 reg);
>
>  /* write operations, indexed using DWORDS */
> -#define wr32(reg, val) \
> -do { \
> -       u8 __iomem *hw_addr = READ_ONCE((hw)->hw_addr); \
> -       writel((val), &hw_addr[(reg)]); \
> -} while (0)
> +void igc_wr32(struct igc_hw *hw, u32 reg, u32 val);
>
>  #define rd32(reg) (igc_rd32(hw, reg))
> +#define wr32(reg, val) (igc_wr32(hw, reg, val))
>
>  #define wrfl() ((void)rd32(IGC_STATUS))
>
> --
> 2.30.2
>
