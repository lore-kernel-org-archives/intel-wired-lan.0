From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Sep 2015 17:45:58 +0000
Subject: [Intel-wired-lan] [next PATCH S12 14/15] i40e/i40evf: save
	aq	writeback for future inspection
In-Reply-To: <1440690163-128213-15-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
 <1440690163-128213-15-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A6D0D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, August 27, 2015 8:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S12 14/15] i40e/i40evf: save aq
> writeback for future inspection
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Add the ability to save the AdminQ write back descriptor if a caller supplies a
> buffer for it to be saved into.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I3d1301d26360b39a2d66dc8569e851f54133a3af
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c   | 4 ++++
>  drivers/net/ethernet/intel/i40e/i40e_adminq.h   | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.c | 4 ++++
> drivers/net/ethernet/intel/i40evf/i40e_adminq.h | 1 +
>  4 files changed, 10 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, admin queue data written and read correctly.
