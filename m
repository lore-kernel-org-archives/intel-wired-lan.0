From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 4 Aug 2021 20:52:48 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3] ethernet: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <20210804121318.337276-1-arnd@kernel.org>
References: <20210804121318.337276-1-arnd@kernel.org>
Message-ID: <CO1PR11MB5089A77D5388203C4AA2F9E4D6F19@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Wednesday, August 04, 2021 4:57 AM
> To: David S. Miller <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>;
> Richard Cochran <richardcochran@gmail.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Andrew Lunn <andrew@lunn.ch>; Vivien
> Didelot <vivien.didelot@gmail.com>; Florian Fainelli <f.fainelli@gmail.com>;
> Vladimir Oltean <olteanv@gmail.com>; Claudiu Manoil
> <claudiu.manoil@nxp.com>; Alexandre Belloni
> <alexandre.belloni@bootlin.com>; UNGLinuxDriver at microchip.com; Nicolas
> Ferre <nicolas.ferre@microchip.com>; Claudiu Beznea
> <claudiu.beznea@microchip.com>; Yisen Zhuang <yisen.zhuang@huawei.com>;
> Salil Mehta <salil.mehta@huawei.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Tariq Toukan <tariqt@nvidia.com>; Saeed
> Mahameed <saeedm@nvidia.com>; Leon Romanovsky <leon@kernel.org>; Jiri
> Pirko <jiri@nvidia.com>; Ido Schimmel <idosch@nvidia.com>; Shannon Nelson
> <snelson@pensando.io>; drivers at pensando.io; Sergei Shtylyov
> <sergei.shtylyov@gmail.com>; Edward Cree <ecree.xilinx@gmail.com>; Martin
> Habets <habetsm.xilinx@gmail.com>; Giuseppe Cavallaro
> <peppe.cavallaro@st.com>; Alexandre Torgue <alexandre.torgue@foss.st.com>;
> Jose Abreu <joabreu@synopsys.com>; Heiner Kallweit <hkallweit1@gmail.com>;
> Russell King <linux@armlinux.org.uk>; Yangbo Lu <yangbo.lu@nxp.com>; Randy
> Dunlap <rdunlap@infradead.org>; Simon Horman
> <simon.horman@netronome.com>; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [PATCH net-next v3] ethernet: fix PTP_1588_CLOCK dependencies
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
> This is a recurring problem in many drivers, and we have discussed
> it several times befores, without reaching a consensus. I'm providing
> a link to the previous email thread for reference, which discusses
> some related problems.
> 
> To solve the dependency issue better than the 'imply' keyword, introduce a
> separate Kconfig symbol "CONFIG_PTP_1588_CLOCK_OPTIONAL" that any driver
> can depend on if it is able to use PTP support when available, but works
> fine without it. Whenever CONFIG_PTP_1588_CLOCK=m, those drivers are
> then prevented from being built-in, the same way as with a 'depends on
> PTP_1588_CLOCK || !PTP_1588_CLOCK' dependency that does the same trick,
> but that can be rather confusing when you first see it.
> 
> Since this should cover the dependencies correctly, the IS_REACHABLE()
> hack in the header is no longer needed now, and can be turned back
> into a normal IS_ENABLED() check. Any driver that gets the dependency
> wrong will now cause a link time failure rather than being unable to use
> PTP support when that is in a loadable module.
> 
> However, the two recently added ptp_get_vclocks_index() and
> ptp_convert_timestamp() interfaces are only called from builtin code with
> ethtool and socket timestamps, so keep the current behavior by stubbing
> those out completely when PTP is in a loadable module. This should be
> addressed properly in a follow-up.
> 
> As Richard suggested, we may want to actually turn PTP support into a
> 'bool' option later on, preventing it from being a loadable module
> altogether, which would be one way to solve the problem with the ethtool
> interface.
> 
> Fixes: 06c16d89d2cb ("ice: register 1588 PTP clock device object for E810 devices")
> Link:
> https://lore.kernel.org/netdev/CAK8P3a06enZOf=XyZ+zcAwBczv41UuCTz+=0FMf
> 2gBz1_cOnZQ at mail.gmail.com/
> Link: https://lore.kernel.org/netdev/CAK8P3a3=eOxE-K25754+fB_-
> i_0BZzf9a9RfPTX3ppSwu9WZXw at mail.gmail.com/
> Link: https://lore.kernel.org/netdev/20210726084540.3282344-1-
> arnd at kernel.org/
> Cc: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks for the "_OPTIONAL" symbol, I definitely find that more readable than the "depends on A || !A".

> diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/Kconfig
> b/drivers/net/ethernet/oki-semi/pch_gbe/Kconfig
> index af84f72bf08e..4e18b64dceb9 100644
> --- a/drivers/net/ethernet/oki-semi/pch_gbe/Kconfig
> +++ b/drivers/net/ethernet/oki-semi/pch_gbe/Kconfig
> @@ -6,6 +6,7 @@
>  config PCH_GBE
>  	tristate "OKI SEMICONDUCTOR IOH(ML7223/ML7831) GbE"
>  	depends on PCI && (X86_32 || COMPILE_TEST)
> +	depends on PTP_1588_CLOCK
>  	select MII
>  	select PTP_1588_CLOCK_PCH
>  	select NET_PTP_CLASSIFY

I did notice this one driver which now directly depends on PTP_1558_CLOCK, but I suspect that's because it actually doesn't work if you disable PTP?
