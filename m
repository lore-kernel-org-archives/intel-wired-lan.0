From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 23 Sep 2020 03:40:56 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] intel-ethernet: make W=1
 build cleanly
In-Reply-To: <20200904203849.2248944-1-jesse.brandeburg@intel.com>
References: <20200904203849.2248944-1-jesse.brandeburg@intel.com>
Message-ID: <DM6PR11MB289091A9803D744F5033A0D5BC380@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jesse Brandeburg
> Sent: Friday, September 4, 2020 1:39 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v2] intel-ethernet: make W=1
> build cleanly
> 
> This takes care of all of the trivial W=1 fixes in the Intel
> Ethernet drivers, which allows developers and maintainers to
> build more of the networking tree with more complete warning
> checks.
> 
> Almost all of the changes were trivial comment updates on
> function headers, but some of the changes were for variables that
> were storing a return value from a register read, where the
> return value wasn't used. Those conversions to remove the lvalue
> of the assignment should be safe because the readl memory mapped
> reads are marked volatile and should not be optimized out without
> an lvalue (I suspect a very long time ago this wasn't guaranteed
> as it is today).
> 
> Inspired by Lee Jones' series of wireless work to do the same.
> Compile tested only.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: pointed at net-next instead
> 
>  drivers/net/ethernet/intel/e100.c             |   8 +-
>  drivers/net/ethernet/intel/e1000/e1000_hw.c   | 147 ++++++++----------
>  drivers/net/ethernet/intel/e1000/e1000_main.c |  39 +++--
>  .../net/ethernet/intel/e1000e/80003es2lan.c   |   1 -
>  drivers/net/ethernet/intel/e1000e/ich8lan.c   |  16 +-
>  drivers/net/ethernet/intel/e1000e/netdev.c    |  50 ++++--
>  drivers/net/ethernet/intel/e1000e/phy.c       |   3 +
>  drivers/net/ethernet/intel/e1000e/ptp.c       |   2 +-
>  drivers/net/ethernet/intel/igb/e1000_82575.c  |   6 +-
>  drivers/net/ethernet/intel/igb/e1000_i210.c   |   5 +-
>  drivers/net/ethernet/intel/igb/e1000_mac.c    |   1 +
>  drivers/net/ethernet/intel/igb/e1000_mbx.c    |   1 +
>  drivers/net/ethernet/intel/igb/igb_main.c     |  28 ++--
>  drivers/net/ethernet/intel/igb/igb_ptp.c      |   8 +-
>  drivers/net/ethernet/intel/igbvf/netdev.c     |  17 +-
>  drivers/net/ethernet/intel/igc/igc_main.c     |   2 +-
>  drivers/net/ethernet/intel/igc/igc_ptp.c      |   4 +-
>  drivers/net/ethernet/intel/ixgb/ixgb_hw.c     | 135 ++++++++--------
>  drivers/net/ethernet/intel/ixgb/ixgb_main.c   |  17 +-
>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |   3 +-
>  20 files changed, 265 insertions(+), 228 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
