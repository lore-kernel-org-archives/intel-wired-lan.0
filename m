From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 4 Sep 2015 22:04:55 +0000
Subject: [Intel-wired-lan] [next PATCH S11 08/15] i40e/i40evf: assure
 clean	asq status report
In-Reply-To: <1440616461-110869-9-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
 <1440616461-110869-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A593D@ORSMSX104.amr.corp.intel.com>
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
> Cc: Pau, Christopher
> Subject: [Intel-wired-lan] [next PATCH S11 08/15] i40e/i40evf: assure clean
> asq status report
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> There was a possibility where the asq_last_status could get through without
> update and thus report a previous error.  I don't think we've actually seen
> this happen, but this patch will help make sure it doesn't.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Signed-off-by: Christopher Pau <christopher.pau@intel.com>
> Change-ID: I9e33927052a5ee6ea21f80b66d4c4b76c2760b17
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c   | 2 ++
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.c | 2 ++
>  2 files changed, 4 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
