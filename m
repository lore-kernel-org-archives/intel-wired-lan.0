From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 19 Mar 2018 21:16:39 +0000
Subject: [Intel-wired-lan] [next PATCH S89 7/8] i40e: stop using cmpxchg
 flow in i40e_set_priv_flags()
In-Reply-To: <20180316082637.49915-7-alice.michael@intel.com>
References: <20180316082637.49915-1-alice.michael@intel.com>
 <20180316082637.49915-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94CCD6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, March 16, 2018 1:27 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S89 7/8] i40e: stop using cmpxchg flow
> in i40e_set_priv_flags()
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Now that the only places which modify flags are either (a) during initialization
> prior to creating a netdevice, or (b) while holding the rtnl lock, we no longer
> need the cmpxchg64 call in i40e_set_priv_flags.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


