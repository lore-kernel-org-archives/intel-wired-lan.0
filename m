From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Apr 2016 17:22:05 +0000
Subject: [Intel-wired-lan] [PATCH v2 01/13] ixgbe: use BIT() macro
In-Reply-To: <1460588914-20143-2-git-send-email-jacob.e.keller@intel.com>
References: <1460588914-20143-1-git-send-email-jacob.e.keller@intel.com>
 <1460588914-20143-2-git-send-email-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2581@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Wednesday, April 13, 2016 4:08 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v2 01/13] ixgbe: use BIT() macro
> 
> Several areas of ixgbe were written before widespread usage of the
> BIT(n) macro. With the impending release of GCC 6 and its associated new
> warnings, some usages such as (1 << 31) have been noted within the ixgbe
> driver source. Fix these wholesale and prevent future issues by simply using
> BIT macro instead of hand coded bit shifts.
> 
> Also fix a few shifts that are shifting values into place by using the 'u' prefix to
> indicate unsigned. It doesn't strictly matter in these cases because we're not
> shifting by too large a value, but these are all unsigned values and should be
> indicated as such.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h           |  68 ++++-----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c     |   6 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     |  16 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    |  30 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c       |   4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c |   2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c |   2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c    |   6 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  14 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  32 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c       |   4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h       |   2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |   4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |  22 +--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      | 164 ++++++++++---------
> --
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |   4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |   8 +-
>  17 files changed, 194 insertions(+), 194 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver compiles and passes traffic
