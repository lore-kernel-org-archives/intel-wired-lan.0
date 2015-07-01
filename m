From: Young, James M <james.m.young@intel.com>
Date: Wed, 1 Jul 2015 20:48:43 +0000
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 3/8]
	i40e:	support virtual channel API 1.1
In-Reply-To: <1433449442-31420-4-git-send-email-catherine.sullivan@intel.com>
References: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
 <1433449442-31420-4-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1C0BA@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, June 04, 2015 1:24 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 3/8] i40e:
> support virtual channel API 1.1
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Store off the VF API version for use when figuring out the VF driver
> capabilities. Add support for the VF driver handing its capabilities to the PF
> driver and then use this information when sending VF resource information
> back to the VF driver.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ic00d0eeeb5b8118085e12f068ef857089a8f7c2d
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 25
> ++++++++++++++++------
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  2 ++
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
Tested-By: Jim Young <james.m.young@intel.com>
Actually not testable on net-next kernel as I cannot find a API 1.0 i40e/evf driver that will build on the 4.1.0rc7 kernel (kcompat issues) This patch does not break current i40e/evf driver operation so I am letting it pass.
