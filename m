From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Jul 2015 21:14:14 +0000
Subject: [Intel-wired-lan] [next PATCH S9 10/15] i40e/i40evf: add new
 device	id 1588
In-Reply-To: <1437684884-222825-11-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
 <1437684884-222825-11-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE530@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, July 23, 2015 1:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S9 10/15] i40e/i40evf: add new device
> id 1588
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Add new device id and support for another 20Gb device.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Ib1b61e5bb6201d84953f97cade39a6e3369c2cf2
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c   | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c  | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 2 ++
>  drivers/net/ethernet/intel/i40e/i40e_type.h     | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_common.c | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h   | 1 +
>  6 files changed, 7 insertions(+)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Present in git log, "modinfo i40e" shows additional device id 1588.
