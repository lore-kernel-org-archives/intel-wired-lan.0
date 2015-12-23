From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Dec 2015 19:27:50 +0000
Subject: [Intel-wired-lan] [next PATCH S24 06/12] i40e/i40evf: Use
 private	workqueue
In-Reply-To: <1450823114-29514-7-git-send-email-deepthi.kavalur@intel.com>
References: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
 <1450823114-29514-7-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96F8EA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Tuesday, December 22, 2015 2:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S24 06/12] i40e/i40evf: Use private
> workqueue
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> As done per ixgbe, use a private workqueue to avoid blocking the system
> workqueue.  This avoids some strange side effects when some other entity is
> depending on the system work queue.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ic8ba08f5b03696cf638b21afd25fbae7738d55ee
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 15 ++++++++++++++-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 10 +++++++++-
>  2 files changed, 23 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
