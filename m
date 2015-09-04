From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 4 Sep 2015 21:56:19 +0000
Subject: [Intel-wired-lan] [next PATCH S11 05/15] i40e/i40evf: fix
	a	potential type compare issue
In-Reply-To: <1440616461-110869-6-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
 <1440616461-110869-6-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A58FB@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S11 05/15] i40e/i40evf: fix a potential
> type compare issue
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Rework an if expression to assure there is no type compare problem
> between a size and a possible negative number.
> 
> Reported-by: Helin Zhang <helin.zhang@intel.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I4921fcc96abfcf69490efce020a9e4007f251c99
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.h   | 3 +--
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.h | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
