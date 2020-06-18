From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 18 Jun 2020 17:30:04 +0000
Subject: [Intel-wired-lan] [next-queue v2] ethernet/intel: Convert
 fallthrough code comments
In-Reply-To: <20200604030726.1573257-1-jeffrey.t.kirsher@intel.com>
References: <20200604030726.1573257-1-jeffrey.t.kirsher@intel.com>
Message-ID: <DM6PR11MB2890E6CAF422C79422991A3BBC9B0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jeff Kirsher
> Sent: Wednesday, June 3, 2020 8:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Joe Perches <joe@perches.com>
> Subject: [Intel-wired-lan] [next-queue v2] ethernet/intel: Convert fallthrough
> code comments
> 
> Convert all the remaining 'fall through" code comments to the newer
> 'fallthough;' keyword.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_hw.c   |  4 +--
>  drivers/net/ethernet/intel/e1000/e1000_main.c |  3 +-
>  .../net/ethernet/intel/e1000/e1000_param.c    |  2 +-
>  drivers/net/ethernet/intel/e1000e/82571.c     |  4 +--
>  drivers/net/ethernet/intel/e1000e/ethtool.c   | 11 ++++---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c   | 14 ++++-----
>  drivers/net/ethernet/intel/e1000e/netdev.c    | 30 +++++++++----------
>  drivers/net/ethernet/intel/e1000e/param.c     |  2 +-
>  drivers/net/ethernet/intel/e1000e/phy.c       |  2 +-
>  drivers/net/ethernet/intel/e1000e/ptp.c       |  3 +-
>  .../net/ethernet/intel/fm10k/fm10k_ethtool.c  |  4 +--
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c |  4 +--
>  drivers/net/ethernet/intel/fm10k/fm10k_mbx.c  |  6 ++--
>  .../net/ethernet/intel/fm10k/fm10k_netdev.c   |  2 +-
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c   |  8 ++---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c |  2 +-
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 ++--
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c    |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  6 ++--
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  4 +--
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c   |  2 +-
>  drivers/net/ethernet/intel/igb/e1000_82575.c  |  4 +--
>  drivers/net/ethernet/intel/igb/e1000_nvm.c    |  2 +-
>  drivers/net/ethernet/intel/igb/e1000_phy.c    |  4 +--
>  drivers/net/ethernet/intel/igb/igb_ethtool.c  |  8 ++---
>  drivers/net/ethernet/intel/igb/igb_main.c     | 26 ++++++++--------
>  drivers/net/ethernet/intel/igb/igb_ptp.c      |  2 +-
>  drivers/net/ethernet/intel/igbvf/netdev.c     |  4 +--
>  drivers/net/ethernet/intel/igc/igc_ethtool.c  | 16 +++-------
>  drivers/net/ethernet/intel/igc/igc_main.c     |  5 ++--
>  .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |  2 +-
>  .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |  6 ++--
>  .../net/ethernet/intel/ixgbe/ixgbe_common.c   |  4 +--
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 10 +++----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 30 +++++++++----------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  |  4 +--
>  .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  4 +--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 10 +++----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  4 +--
>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 10 +++----
>  drivers/net/ethernet/intel/ixgbevf/vf.c       |  6 ++--
>  43 files changed, 135 insertions(+), 151 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
