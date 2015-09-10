From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Sep 2015 16:40:20 +0000
Subject: [Intel-wired-lan] [next PATCH S14 01/15] i40e/i40evf: Add new
 link	status defines
In-Reply-To: <1441065295-234333-2-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
 <1441065295-234333-2-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A614C@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S14 01/15] i40e/i40evf: Add new link
> status defines
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Add the new Port link status bit and rename the link status to function link
> status.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I71289327ae62638ce967b6ad40114caf998b6dab
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 4 +++-
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
