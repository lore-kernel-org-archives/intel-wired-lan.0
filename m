From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 20:30:20 +0000
Subject: [Intel-wired-lan] [next PATCH S1 2/6] i40e: Add support FEC
 configuration for Fortville 25G
In-Reply-To: <20181219144542.85924-2-alice.michael@intel.com>
References: <20181219144542.85924-1-alice.michael@intel.com>
 <20181219144542.85924-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343984@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 19, 2018 6:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Damian Dybek <damian.dybek@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S1 2/6] i40e: Add support FEC
> configuration for Fortville 25G
> 
> From: Damian Dybek <damian.dybek@intel.com>
> 
> This patch adds support for setting/getting FEC configuration using ethtool
> options:
>        set/show-priv-flags rs-fec/base-r-fec
>        set/show-fec off/rs/baser/auto for kernels version >= 4.14
> 
> Signed-off-by: Damian Dybek <damian.dybek@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |   4 +
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 228 +++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  26 ++
>  3 files changed, 256 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


