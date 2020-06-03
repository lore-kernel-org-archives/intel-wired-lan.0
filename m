From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 3 Jun 2020 19:24:16 +0000
Subject: [Intel-wired-lan] [next-queue v3] net/intel: remove driver
 versions from Intel drivers
In-Reply-To: <20200529071833.633168-1-jeffrey.t.kirsher@intel.com>
References: <20200529071833.633168-1-jeffrey.t.kirsher@intel.com>
Message-ID: <DM6PR11MB2890D68DE3DB647BE51B8C73BC880@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jeff
> Kirsher
> Sent: Friday, May 29, 2020 12:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Liedtke, Kevin D
> <kevin.d.liedtke@intel.com>; Rowden, Aaron F <aaron.f.rowden@intel.com>
> Subject: [Intel-wired-lan] [next-queue v3] net/intel: remove driver versions from
> Intel drivers
> 
> As with other networking drivers, remove the unnecessary driver version
> from the Intel drivers. The ethtool driver information and module version
> will then report the kernel version instead.
> 
> For ixgbe, i40e and ice drivers, the driver passes the driver version to
> the firmware to confirm that we are up and running.  So we now pass the
> value of UTS_RELEASE to the firmware.  This adminq call is required per
> the HAS document.  The Device then sends an indication to the BMC that the
> PF driver is present. This is done using Host NC Driver Status Indication
> in NC-SI Get Link command or via the Host Network Controller Driver Status
> Change AEN.
> 
> What the BMC may do with this information is implementation-dependent, but
> this is a standard NC-SI 1.1 command we honor per the HAS.
> 
> CC: Bruce Allan <bruce.w.allan@intel.com>
> CC: Jesse Brandeburg <jesse.brandeburg@intel.com>
> CC: Alek Loktionov <aleksandr.loktionov@intel.com>
> CC: Kevin Liedtke <kevin.d.liedtke@intel.com>
> CC: Aaron Rowden <aaron.f.rowden@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> v2: fixed Co-developed-by: tag
> 
> v3: Addressed Bruce Allan's concerns in the patch description with all
>     the information that the firmware team was able to share
>     Did not address Shannon Nelson's suggestion to remove all print
>     statements in the drivers initialization functions... I plan to take
>     my chances with the Linux community
> 
>  drivers/net/ethernet/intel/e100.c             |  6 +----
>  drivers/net/ethernet/intel/e1000/e1000.h      |  1 -
>  .../net/ethernet/intel/e1000/e1000_ethtool.c  |  2 --
>  drivers/net/ethernet/intel/e1000/e1000_main.c |  5 +----
>  drivers/net/ethernet/intel/e1000e/e1000.h     |  1 -
>  drivers/net/ethernet/intel/e1000e/ethtool.c   |  2 --
>  drivers/net/ethernet/intel/e1000e/netdev.c    |  8 +------
>  drivers/net/ethernet/intel/fm10k/fm10k.h      |  1 -
>  .../net/ethernet/intel/fm10k/fm10k_ethtool.c  |  2 --
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c |  5 +----
>  drivers/net/ethernet/intel/i40e/i40e.h        |  1 -
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  2 --
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 22 +++++--------------
>  drivers/net/ethernet/intel/iavf/iavf.h        |  1 -
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    |  1 -
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 14 +-----------
>  drivers/net/ethernet/intel/iavf/iavf_type.h   |  8 -------
>  drivers/net/ethernet/intel/ice/ice.h          |  1 -
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  1 -
>  drivers/net/ethernet/intel/ice/ice_main.c     | 22 ++++++-------------
>  drivers/net/ethernet/intel/igb/igb.h          |  1 -
>  drivers/net/ethernet/intel/igb/igb_ethtool.c  |  1 -
>  drivers/net/ethernet/intel/igb/igb_main.c     | 11 +---------
>  drivers/net/ethernet/intel/igbvf/ethtool.c    |  2 --
>  drivers/net/ethernet/intel/igbvf/igbvf.h      |  1 -
>  drivers/net/ethernet/intel/igbvf/netdev.c     |  5 +----
>  drivers/net/ethernet/intel/igc/igc.h          |  1 -
>  drivers/net/ethernet/intel/igc/igc_ethtool.c  |  1 -
>  drivers/net/ethernet/intel/igc/igc_main.c     |  7 +-----
>  drivers/net/ethernet/intel/ixgb/ixgb.h        |  1 -
>  .../net/ethernet/intel/ixgb/ixgb_ethtool.c    |  2 --
>  drivers/net/ethernet/intel/ixgb/ixgb_main.c   |  6 +----
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 -
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  2 --
>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |  3 ++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 ++++-----
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c  |  2 --
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |  1 -
>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  7 +-----
>  39 files changed, 29 insertions(+), 142 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
