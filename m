From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 2 Aug 2021 13:07:10 +0000
Subject: [Intel-wired-lan] [PATCH] ethernet/intel: fix PTP_1588_CLOCK
 dependencies
In-Reply-To: <20210726084540.3282344-1-arnd@kernel.org>
References: <20210726084540.3282344-1-arnd@kernel.org>
Message-ID: <BYAPR11MB336781A3C6B41DFFFD838157FCEF9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Arnd Bergmann
> Sent: Monday, July 26, 2021 2:15 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; netdev at vger.kernel.org; Kurt
> Kanzenbach <kurt@linutronix.de>; linux-kernel at vger.kernel.org; intel-
> wired-lan at lists.osuosl.org; Saleem, Shiraz <shiraz.saleem@intel.com>
> Subject: [Intel-wired-lan] [PATCH] ethernet/intel: fix PTP_1588_CLOCK
> dependencies
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The 'imply' keyword does not do what most people think it does, it only
> politely asks Kconfig to turn on another symbol, but does not prevent it from
> being disabled manually or built as a loadable module when the user is built-
> in. In the ICE driver, the latter now causes a link failure:
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
> ice_main.c:(.text+0x31fc): relocation truncated to fit: R_AARCH64_CALL26
> against undefined symbol `ice_ptp_release'
> aarch64-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function
> `ice_rebuild':
> 
> For the other Intel network drivers, there is no link error when the drivers
> are built-in and PTP is a loadable module, because linux/ptp_clock_kernel.h
> contains an IS_REACHABLE() check, but this just changes the compile-time
> failure to a runtime failure, which is arguably worse.
> 
> Change all the Intel drivers to use the 'depends on PTP_1588_CLOCK ||
> !PTP_1588_CLOCK' trick to prevent the broken configuration, as we already
> do for several other drivers. To avoid circular dependencies, this also requires
> changing the IGB driver back to using the normal 'depends on I2C' instead of
> 'select I2C'.
> 
> Fixes: 06c16d89d2cb ("ice: register 1588 PTP clock device object for E810
> devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/intel/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Tested-by: Gurucharan  G <Gurucharanx.g@intel.com> (A Contingent Worker at Intel)
