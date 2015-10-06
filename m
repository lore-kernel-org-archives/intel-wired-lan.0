From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Oct 2015 16:11:31 +0000
Subject: [Intel-wired-lan] [next PATCH S18 8/8] i40e/i40evf: Bump i40e
 to	1.3.46 and i40evf to 1.3.33
In-Reply-To: <1443724661-92168-9-git-send-email-catherine.sullivan@intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
 <1443724661-92168-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B377A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, October 01, 2015 11:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S18 8/8] i40e/i40evf: Bump i40e to
> 1.3.46 and i40evf to 1.3.33
> 
> Bump up the version...
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: Ib8d501021671ba20250115ed54330e2c182255b7
> 
> ---
> Testing-hints: check version
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, modinfo shows correct version for i40e and i40evf.
