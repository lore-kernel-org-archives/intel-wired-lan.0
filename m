From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 18:11:35 +0000
Subject: [Intel-wired-lan] [PATCH S25 04/12] ice: Fix ethtool port and
 PFC stats for 4x25G cards
In-Reply-To: <20190725095401.24590-4-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
 <20190725095401.24590-4-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40EA8A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, July 25, 2019 2:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S25 04/12] ice: Fix ethtool port and PFC
> stats for 4x25G cards
> 
> From: Usha Ketineni <usha.k.ketineni@intel.com>
> 
> This patch fixes the issue where port and PFC statistics counters are
> incrementing at the wrong port with 4x25G cards.
> Read the GLPRT port registers using lport parameter instead of pf_id to
> update the statistics otherwise the pf_ids are flipped for ports 2 and 3 when
> read from the HW register PF_FUNC_RID and this is expected as per
> hardware specification.
> 
> Signed-off-by: Usha Ketineni <usha.k.ketineni@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 13 ++--
>  drivers/net/ethernet/intel/ice/ice_main.c    | 76 ++++++++++----------
>  2 files changed, 45 insertions(+), 44 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


