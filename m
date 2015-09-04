From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 4 Sep 2015 21:53:12 +0000
Subject: [Intel-wired-lan] [next PATCH S11 04/15] i40e/i40evf: add
 driver	support for new device ids
In-Reply-To: <1440616461-110869-5-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
 <1440616461-110869-5-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A58E9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, August 26, 2015 12:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S11 04/15] i40e/i40evf: add driver
> support for new device ids
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Early addition of new a device id.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I61a8c8556fdf4f5714be4e4089689e374f30293c
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c   | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c  | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_type.h     | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_common.c | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h   | 1 +
>  6 files changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, modinfo shows additional device ID for i40e
