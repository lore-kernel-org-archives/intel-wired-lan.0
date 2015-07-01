From: Young, James M <james.m.young@intel.com>
Date: Wed, 1 Jul 2015 20:41:09 +0000
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH
	2/8]	i40e/i40evf: add macros for virtual channel API version
	and	device capability
In-Reply-To: <1433449442-31420-3-git-send-email-catherine.sullivan@intel.com>
References: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
 <1433449442-31420-3-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1C071@ORSMSX102.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 2/8] i40e/i40evf:
> add macros for virtual channel API version and device capability
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Now that we've rolled the virtual channel API version to 1.1, add some
> macros to test what version is being used by our partner in crime. For the VF,
> add some macros to determine what our device capabilities are.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I79f6683d4c23bd76a8ad9fd492776fcc1208e1dc
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 3 +++
>  drivers/net/ethernet/intel/i40evf/i40evf.h         | 9 +++++++++
>  2 files changed, 12 insertions(+)
> 

Tested-by: Jim Young <james.m.young@intel.com>

Actually not testable on net-next kernel as I cannot find API 1.0 i40e/i40evf drivers that will build on the 4.1.0rc7 kernel (kcompat issues) This patch does not break current i40e/i40evf driver operation so I am letting it pass.
