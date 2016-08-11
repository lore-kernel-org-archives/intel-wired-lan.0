From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 11 Aug 2016 19:25:21 +0000
Subject: [Intel-wired-lan] [next PATCH S41-V2 1/5] i40e: use
 alloc_workqueue	instead of create_singlethread_workqueue
In-Reply-To: <1470335825-15534-2-git-send-email-bimmy.pujari@intel.com>
References: <1470335825-15534-1-git-send-email-bimmy.pujari@intel.com>
 <1470335825-15534-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F89ED@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Thursday, August 04, 2016 11:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S41-V2 1/5] i40e: use
> alloc_workqueue instead of create_singlethread_workqueue
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Replace calls to create_singlethread_workqueue instead with
> alloc_workqueue as is style with other Intel drivers. This provides more
> control over workqueue creation, and allows explicit setting of the desired
> mode of operation. It also makes it more obvious that driver name constant
> is passed to a format "%s".
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I6192b44caf5140336cd54c5b350d51c73b541fdb
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 3 ++-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


