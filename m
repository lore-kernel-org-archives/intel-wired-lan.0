From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 11 Sep 2020 10:43:48 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 05/11] intel-ethernet:
 make W=1 build cleanly
In-Reply-To: <20200911012337.14015-6-jesse.brandeburg@intel.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911012337.14015-6-jesse.brandeburg@intel.com>
Message-ID: <877dt0nr8r.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jesse Brandeburg <jesse.brandeburg@intel.com> writes:

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

...

> diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> index 4e7a0810eaeb..2120dacfd55c 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> @@ -139,6 +139,7 @@ static void e1000_phy_init_script(struct e1000_hw *hw)
>  		 * at the end of this routine.
>  		 */
>  		ret_val = e1000_read_phy_reg(hw, 0x2F5B, &phy_saved_data);
> +		e_dbg("Reading PHY register 0x2F5B failed: %d\n", ret_val);
>

Adding this debug statement seems unrelated.

>  		/* Disabled the PHY transmitter */
>  		e1000_write_phy_reg(hw, 0x2F5B, 0x0003);

Apart from this,

Reviewed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

-- 
Vinicius
