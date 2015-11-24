From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 24 Nov 2015 22:41:03 +0000
Subject: [Intel-wired-lan] [next PATCH] i40e: trivial fixes
In-Reply-To: <1447896942-10644-1-git-send-email-jesse.brandeburg@intel.com>
References: <1447896942-10644-1-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F892970@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Wednesday, November 18, 2015 5:36 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH] i40e: trivial fixes
> 
> 1) remove duplicate include of tcp.h
> 2) put an ampersand at the end of a line instead of the beginning
> 3) remove a useless dev_info
> 4) match declaration of function to the implementation
> 5) repair incorrect comment
> 6) correct whitespace
> 7) remove unused define
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  7 +++----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  6 +-----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 15 ++++-----------
>  3 files changed, 8 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
