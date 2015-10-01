From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Oct 2015 16:31:56 +0000
Subject: [Intel-wired-lan] [next PATCH S16 02/15] i40e/i40evf: Fix
 compile	issue related to const string
In-Reply-To: <1443463964-148204-3-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
 <1443463964-148204-3-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2BC6@ORSMSX104.amr.corp.intel.com>
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
> Cc: Wu, Jingjing
> Subject: [Intel-wired-lan] [next PATCH S16 02/15] i40e/i40evf: Fix compile
> issue related to const string
> 
> From: Jingjing Wu <jingjing.wu@intel.com>
> 
> Add const to functions that return strings that aren't going to be modified.
> This addresses some reported compile complaints.
> 
> Signed-off-by: Jingjing Wu <jingjing.wu@intel.com>
> Change-ID: Ic56b1e814ab4d23a50480e7fdec652445f776ee8
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c      | 4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c         | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   | 4 ++--
>  drivers/net/ethernet/intel/i40evf/i40e_common.c    | 4 ++--
>  drivers/net/ethernet/intel/i40evf/i40e_prototype.h | 4 ++--
>  5 files changed, 9 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, no compile errors related to changed functions.
