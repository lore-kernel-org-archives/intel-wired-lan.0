From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Sep 2015 20:36:02 +0000
Subject: [Intel-wired-lan] [next PATCH S14 10/15] i40e/i40evf: split
 device	ids into a separate file
In-Reply-To: <1441065295-234333-11-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
 <1441065295-234333-11-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A624B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, August 31, 2015 4:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S14 10/15] i40e/i40evf: split device ids
> into a separate file
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Due to desires to write userland drivers, and other requests, without
> needing the rest of the include files, the device ids are pulled out into a
> standalone file.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Ic0b047dbf9d4b0891892309c1f2079f56d9b60e8
> ---
>  drivers/net/ethernet/intel/i40e/i40e_devids.h   | 55
> +++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h     | 26 +-----------
>  drivers/net/ethernet/intel/i40evf/i40e_devids.h | 55
> +++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_type.h   | 26 +-----------
>  4 files changed, 112 insertions(+), 50 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/i40e/i40e_devids.h
>  create mode 100644 drivers/net/ethernet/intel/i40evf/i40e_devids.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, new file i40e_devids.h present in tree.
