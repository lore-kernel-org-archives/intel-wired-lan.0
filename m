From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Oct 2017 17:45:43 +0000
Subject: [Intel-wired-lan] [PATCH v3 14/14 net-next] i40e:
	convert	i40e_set_link_ksettings to new API
In-Reply-To: <20171005215344.2886-15-alan.brady@intel.com>
References: <20171005215344.2886-1-alan.brady@intel.com>
 <20171005215344.2886-15-alan.brady@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAC319@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 14/14 net-next] i40e: convert
> i40e_set_link_ksettings to new API
> 
> This finishes off the conversion to the new ethtool API by removing the old
> macros being used in i40e_set_link_ksettings and replacing them with shiny
> new ones.
> 
> This conversion also allows us to provide link speed support for new 25G and
> 10G macros which is included here as well.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 93 ++++++++++++++++----
> ------
>  1 file changed, 57 insertions(+), 36 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


