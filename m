From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Oct 2018 22:09:00 +0000
Subject: [Intel-wired-lan] [PATCH] i40e/ixgbe/igb: fail on new wol flag
 setting WAKE_MAGICSECURE
In-Reply-To: <20181010181010.86131-1-alice.michael@intel.com>
References: <20181010181010.86131-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3291FB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, October 10, 2018 11:10 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e/ixgbe/igb: fail on new wol flag setting
> WAKE_MAGICSECURE
> 
> From: Todd Fujinaka <todd.fujinaka@intel.com>
> 
> There's a new flag for setting WoL filters that is only enabled on one
> manufacturer's NICs, and it's not ours. Fail with EOPNOTSUPP.
> 
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c   | 3 ++-
>  drivers/net/ethernet/intel/igb/igb_ethtool.c     | 2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 3 ++-
>  3 files changed, 5 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


