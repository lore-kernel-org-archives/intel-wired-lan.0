From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 11 Aug 2016 19:41:44 +0000
Subject: [Intel-wired-lan] [next PATCH S41-V2 3/5] i40e: refactor
 tail_bump	check
In-Reply-To: <1470335825-15534-4-git-send-email-bimmy.pujari@intel.com>
References: <1470335825-15534-1-git-send-email-bimmy.pujari@intel.com>
 <1470335825-15534-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F8A10@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S41-V2 3/5] i40e: refactor tail_bump
> check
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch refactors tail bump check.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: Ide0e19171d67d90cb2b06b8dcd4fa791ae120160
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 6 ++----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
