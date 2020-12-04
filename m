From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 4 Dec 2020 13:25:50 -0800
Subject: [Intel-wired-lan] [PATCH v3 2/7] e1000e: Move all S0ix related
 code into its own source file
In-Reply-To: <20201204200920.133780-3-mario.limonciello@dell.com>
References: <20201204200920.133780-1-mario.limonciello@dell.com>
 <20201204200920.133780-3-mario.limonciello@dell.com>
Message-ID: <CAKgT0Ucz5zDp3fEJFpt1x1e+OcLCxOZVyo5KK5sM_LktbLQH3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Dec 4, 2020 at 12:09 PM Mario Limonciello
<mario.limonciello@dell.com> wrote:
>
> Introduce a flag to indicate the device should be using the S0ix
> flows and use this flag to run those functions.
>
> Splitting the code to it's own file will make future heuristics
> more self contained.
>
> Tested-by: Yijun Shen <yijun.shen@dell.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

One minor issue pointed out below.

> ---
>  drivers/net/ethernet/intel/e1000e/Makefile |   2 +-
>  drivers/net/ethernet/intel/e1000e/e1000.h  |   4 +
>  drivers/net/ethernet/intel/e1000e/netdev.c | 272 +-------------------
>  drivers/net/ethernet/intel/e1000e/s0ix.c   | 280 +++++++++++++++++++++
>  4 files changed, 290 insertions(+), 268 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/e1000e/s0ix.c
>
> diff --git a/drivers/net/ethernet/intel/e1000e/Makefile b/drivers/net/ethernet/intel/e1000e/Makefile
> index 44e58b6e7660..f2332c01f86c 100644
> --- a/drivers/net/ethernet/intel/e1000e/Makefile
> +++ b/drivers/net/ethernet/intel/e1000e/Makefile
> @@ -9,5 +9,5 @@ obj-$(CONFIG_E1000E) += e1000e.o
>
>  e1000e-objs := 82571.o ich8lan.o 80003es2lan.o \
>                mac.o manage.o nvm.o phy.o \
> -              param.o ethtool.o netdev.o ptp.o
> +              param.o ethtool.o netdev.o s0ix.o ptp.o
>
> diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
> index ba7a0f8f6937..b13f956285ae 100644
> --- a/drivers/net/ethernet/intel/e1000e/e1000.h
> +++ b/drivers/net/ethernet/intel/e1000e/e1000.h
> @@ -436,6 +436,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca);
>  #define FLAG2_DFLT_CRC_STRIPPING          BIT(12)
>  #define FLAG2_CHECK_RX_HWTSTAMP           BIT(13)
>  #define FLAG2_CHECK_SYSTIM_OVERFLOW       BIT(14)
> +#define FLAG2_ENABLE_S0IX_FLOWS           BIT(15)
>
>  #define E1000_RX_DESC_PS(R, i)     \
>         (&(((union e1000_rx_desc_packet_split *)((R).desc))[i]))
> @@ -462,6 +463,9 @@ enum latency_range {
>  extern char e1000e_driver_name[];
>
>  void e1000e_check_options(struct e1000_adapter *adapter);
> +void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter);
> +void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter);
> +void e1000e_maybe_enable_s0ix(struct e1000_adapter *adapter);
>  void e1000e_set_ethtool_ops(struct net_device *netdev);
>
>  int e1000e_open(struct net_device *netdev);
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 128ab6898070..cd9839e86615 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c

<snip>

>  static int e1000e_pm_freeze(struct device *dev)
>  {
>         struct net_device *netdev = dev_get_drvdata(dev);
> @@ -6962,7 +6701,6 @@ static __maybe_unused int e1000e_pm_suspend(struct device *dev)
>         struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev));
>         struct e1000_adapter *adapter = netdev_priv(netdev);
>         struct pci_dev *pdev = to_pci_dev(dev);
> -       struct e1000_hw *hw = &adapter->hw;
>         int rc;
>
>         e1000e_flush_lpic(pdev);
> @@ -6974,8 +6712,7 @@ static __maybe_unused int e1000e_pm_suspend(struct device *dev)
>                 e1000e_pm_thaw(dev);
>
>         /* Introduce S0ix implementation */
> -       if (hw->mac.type >= e1000_pch_cnp &&
> -           !e1000e_check_me(hw->adapter->pdev->device))
> +       if (adapter->flags2 & FLAG2_ENABLE_S0IX_FLOWS)
>                 e1000e_s0ix_entry_flow(adapter);

So the placement of this code raises some issues. It isn't a problem
with your patch but a bug in the driver that needs to be addressed. I
am assuming you only need to perform this flow if you successfully
froze the part. However this is doing it in all cases, which is why
the e1000e_pm_thaw is being called before you call this code. This is
something that should probably be an "else if" rather than a seperate
if statement.

>
>         return rc;
> @@ -6986,12 +6723,10 @@ static __maybe_unused int e1000e_pm_resume(struct device *dev)
>         struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev));
>         struct e1000_adapter *adapter = netdev_priv(netdev);
>         struct pci_dev *pdev = to_pci_dev(dev);
> -       struct e1000_hw *hw = &adapter->hw;
>         int rc;
>
>         /* Introduce S0ix implementation */
> -       if (hw->mac.type >= e1000_pch_cnp &&
> -           !e1000e_check_me(hw->adapter->pdev->device))
> +       if (adapter->flags2 & FLAG2_ENABLE_S0IX_FLOWS)
>                 e1000e_s0ix_exit_flow(adapter);
>
>         rc = __e1000_resume(pdev);
> @@ -7655,6 +7390,9 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>         if (!(adapter->flags & FLAG_HAS_AMT))
>                 e1000e_get_hw_control(adapter);
>
> +       /* use heuristics to decide whether to enable s0ix flows */
> +       e1000e_maybe_enable_s0ix(adapter);
> +
>         strlcpy(netdev->name, "eth%d", sizeof(netdev->name));
>         err = register_netdev(netdev);
>         if (err)
