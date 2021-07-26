From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 26 Jul 2021 21:21:09 +0000
Subject: [Intel-wired-lan] [PATCH] ethernet/intel: fix PTP_1588_CLOCK
 dependencies
In-Reply-To: <20210726084540.3282344-1-arnd@kernel.org>
References: <20210726084540.3282344-1-arnd@kernel.org>
Message-ID: <CO1PR11MB5089F97937FF0141FD02D3B3D6E89@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Monday, July 26, 2021 1:45 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Jakub
> Kicinski <kuba@kernel.org>; Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Kurt Kanzenbach <kurt@linutronix.de>;
> Saleem, Shiraz <shiraz.saleem@intel.com>; Ertman, David M
> <david.m.ertman@intel.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [PATCH] ethernet/intel: fix PTP_1588_CLOCK dependencies
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The 'imply' keyword does not do what most people think it does, it only
> politely asks Kconfig to turn on another symbol, but does not prevent
> it from being disabled manually or built as a loadable module when the
> user is built-in. In the ICE driver, the latter now causes a link failure:
> 
> aarch64-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function
> `ice_eth_ioctl':
> ice_main.c:(.text+0x13b0): undefined reference to `ice_ptp_get_ts_config'
> ice_main.c:(.text+0x13b0): relocation truncated to fit: R_AARCH64_CALL26
> against undefined symbol `ice_ptp_get_ts_config'
> aarch64-linux-ld: ice_main.c:(.text+0x13bc): undefined reference to
> `ice_ptp_set_ts_config'
> ice_main.c:(.text+0x13bc): relocation truncated to fit: R_AARCH64_CALL26
> against undefined symbol `ice_ptp_set_ts_config'
> aarch64-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function
> `ice_prepare_for_reset':
> ice_main.c:(.text+0x31fc): undefined reference to `ice_ptp_release'
> ice_main.c:(.text+0x31fc): relocation truncated to fit: R_AARCH64_CALL26 against
> undefined symbol `ice_ptp_release'
> aarch64-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function
> `ice_rebuild':
> 
> For the other Intel network drivers, there is no link error when the
> drivers are built-in and PTP is a loadable module, because
> linux/ptp_clock_kernel.h contains an IS_REACHABLE() check, but this
> just changes the compile-time failure to a runtime failure, which is
> arguably worse.
> 
> Change all the Intel drivers to use the 'depends on PTP_1588_CLOCK ||
> !PTP_1588_CLOCK' trick to prevent the broken configuration, as we
> already do for several other drivers. To avoid circular dependencies,
> this also requires changing the IGB driver back to using the normal
> 'depends on I2C' instead of 'select I2C'.
> 
> Fixes: 06c16d89d2cb ("ice: register 1588 PTP clock device object for E810 devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for fixing this!

It feels like Kconfig should have a simpler way to write this, and/or we should update the doc, since I would expect this to be a common issue with optional dependencies

Obviously "depends" handles this right but it forces a dependency in all cases, instead of being optional. select is used to ensure that some bit is turned on if you turn on that item, and imply is supposed to be that but optional...


> ---
>  drivers/net/ethernet/intel/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/Kconfig
> b/drivers/net/ethernet/intel/Kconfig
> index 2aa84bd97287..ab75cde0c4ec 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -58,8 +58,8 @@ config E1000
>  config E1000E
>  	tristate "Intel(R) PRO/1000 PCI-Express Gigabit Ethernet support"
>  	depends on PCI && (!SPARC32 || BROKEN)
> +	depends on PTP_1588_CLOCK || !PTP_1588_CLOCK
>  	select CRC32
> -	imply PTP_1588_CLOCK
>  	help
>  	  This driver supports the PCI-Express Intel(R) PRO/1000 gigabit
>  	  ethernet family of adapters. For PCI or PCI-X e1000 adapters,
> @@ -87,7 +87,7 @@ config E1000E_HWTS
>  config IGB
>  	tristate "Intel(R) 82575/82576 PCI-Express Gigabit Ethernet support"
>  	depends on PCI
> -	imply PTP_1588_CLOCK
> +	depends on PTP_1588_CLOCK || !PTP_1588_CLOCK
>  	select I2C


Commit message said you changed IGB to use depends I2C, but the content doesn't...

>  	select I2C_ALGOBIT
>  	help
> @@ -159,9 +159,9 @@ config IXGB
>  config IXGBE
>  	tristate "Intel(R) 10GbE PCI Express adapters support"
>  	depends on PCI
> +	depends on PTP_1588_CLOCK || !PTP_1588_CLOCK
>  	select MDIO
>  	select PHYLIB
> -	imply PTP_1588_CLOCK
>  	help
>  	  This driver supports Intel(R) 10GbE PCI Express family of
>  	  adapters.  For more information on how to identify your adapter, go
> @@ -239,7 +239,7 @@ config IXGBEVF_IPSEC
> 
>  config I40E
>  	tristate "Intel(R) Ethernet Controller XL710 Family support"
> -	imply PTP_1588_CLOCK
> +	depends on PTP_1588_CLOCK || !PTP_1588_CLOCK
>  	depends on PCI
>  	select AUXILIARY_BUS
>  	help
> @@ -295,11 +295,11 @@ config ICE
>  	tristate "Intel(R) Ethernet Connection E800 Series Support"
>  	default n
>  	depends on PCI_MSI
> +	depends on PTP_1588_CLOCK || !PTP_1588_CLOCK
>  	select AUXILIARY_BUS
>  	select DIMLIB
>  	select NET_DEVLINK
>  	select PLDMFW
> -	imply PTP_1588_CLOCK
>  	help
>  	  This driver supports Intel(R) Ethernet Connection E800 Series of
>  	  devices.  For more information on how to identify your adapter, go
> @@ -317,7 +317,7 @@ config FM10K
>  	tristate "Intel(R) FM10000 Ethernet Switch Host Interface Support"
>  	default n
>  	depends on PCI_MSI
> -	imply PTP_1588_CLOCK
> +	depends on PTP_1588_CLOCK || !PTP_1588_CLOCK
>  	help
>  	  This driver supports Intel(R) FM10000 Ethernet Switch Host
>  	  Interface.  For more information on how to identify your adapter,
> --
> 2.29.2

