From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Oct 2015 15:30:02 +0000
Subject: [Intel-wired-lan] [next PATCH S16 01/15] i40e: generate
	fewer	startup messages
In-Reply-To: <1443463964-148204-2-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
 <1443463964-148204-2-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2BB3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S16 01/15] i40e: generate fewer
> startup messages
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Cut down on the number of startup log entries by putting a couple behind
> debug flags and combining a couple others into a single line.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I708089f086308f84d43f8b6f0e8a634a02d058fb
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 20 ++++++++++++--------
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c     |  4 ++--
>  4 files changed, 17 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, fewer startup messages printed to log on startup, fw info follows new combined format.
