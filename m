From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Oct 2017 17:44:08 +0000
Subject: [Intel-wired-lan] [PATCH v3 11/14 net-next] i40e:
	convert	i40e_phy_type_to_ethtool to new API
In-Reply-To: <20171005215344.2886-12-alan.brady@intel.com>
References: <20171005215344.2886-1-alan.brady@intel.com>
 <20171005215344.2886-12-alan.brady@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAC2DF@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 11/14 net-next] i40e: convert
> i40e_phy_type_to_ethtool to new API
> 
> We are still largely using the old ethtool API macros.  This is problematic
> because eventually they will be removed and they only support 32 bits of
> PHY types.
> 
> This overhauls i40e_phy_type_to_ethtool to use only the new API.  Doing
> this also allows us to provide much better support for newer 25G and 10G
> PHY types which is included here as well.
> 
> The remaining usages of the old ethtool API will be addressed in other
> patches in the series.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 204 +++++++++++++++++-
> -------
>  1 file changed, 140 insertions(+), 64 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


