From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Oct 2017 19:08:06 +0000
Subject: [Intel-wired-lan] [PATCH v3 08/14 net-next] i40e: group autoneg
 PHY	types together
In-Reply-To: <20171005215344.2886-9-alan.brady@intel.com>
References: <20171005215344.2886-1-alan.brady@intel.com>
 <20171005215344.2886-9-alan.brady@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAC375@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alan Brady
> Sent: Thursday, October 5, 2017 2:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 08/14 net-next] i40e: group autoneg
> PHY types together
> 
> This separates the setting of autoneg in i40e_phy_types_to_ethtool into its
> own conditional.  Doing this adds clarity as what PHYs support/advertise
> autoneg and makes it easier to add new PHY types in the future.
> 
> This also fixes an issue on devices with CRT_RETIMER where advertising
> autoneg was being set, but supported autoneg was not.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 85 +++++++++++++---------
> ----
>  1 file changed, 41 insertions(+), 44 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


