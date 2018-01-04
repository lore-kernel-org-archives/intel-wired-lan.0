From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jan 2018 22:07:07 +0000
Subject: [Intel-wired-lan] [next PATCH S84-V2 05/13] i40e: Display LLDP
 information on vSphere Web Client
In-Reply-To: <20171227123242.22356-5-alice.michael@intel.com>
References: <20171227123242.22356-1-alice.michael@intel.com>
 <20171227123242.22356-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D700D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 27, 2017 4:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Menon, Upasana <upasana.menon@intel.com>; Menon at osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S84-V2 05/13] i40e: Display LLDP
> information on vSphere Web Client
> 
> From: Menon, Upasana <upasana.menon@intel.com>
> 
> This patch enables driver to display LLDP information on the vSphere Web
> Client with Intel adapters (X710, XL710) and Distributed Virtual Switch.
> 
> Signed-off-by: Menon, Upasana <upasana.menon@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 12 ++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_common.c      | 27
> ++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  4 ++++
>  .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 12 ++++++++++
>  4 files changed, 55 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


