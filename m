From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Feb 2016 00:40:27 +0000
Subject: [Intel-wired-lan] [next PATCH S29 10/14] i40e: implement and
 use rx	ctl helper functions
In-Reply-To: <1455754344-6372-11-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-11-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98F420@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Wednesday, February 17, 2016 4:12 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S29 10/14] i40e: implement and use rx
> ctl helper functions
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Use the new AdminQ functions for safely accessing the Rx control registers
> that may be affected by heavy small packet traffic.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Ibb00983e8dcba71f4b760222a609a5fcaa726f18
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c      | 128
> ++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   8 ++
>  drivers/net/ethernet/intel/i40evf/i40e_common.c    | 125
> ++++++++++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_prototype.h |   8 ++
>  4 files changed, 266 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
AQ-RSS functions work properly and change under load without error
