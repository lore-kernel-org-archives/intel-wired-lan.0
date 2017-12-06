From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Dec 2017 18:23:53 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: Fix kernel-doc format
 warnings
In-Reply-To: <20171204192831.18344-1-anthony.l.nguyen@intel.com>
References: <20171204192831.18344-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EB0969@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, December 4, 2017 11:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: Fix kernel-doc format warnings
> 
> Recent checks added for formatting kernel-doc comments are causing
> warnings if W= is run with a non-zero value.  This patch fixes function
> comments to resolve warnings when W=1 is used.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c     |  3 ++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     | 11 +++++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    |  9 ++++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c       | 10 +++++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c | 22 +++++++++++----
> drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c |  5 +++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c   |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c      |  3 ++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 31 ++++++++++++++----
> ----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c       | 15 +++++++++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |  8 +++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      | 19 ++++++++++---
>  12 files changed, 99 insertions(+), 39 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


