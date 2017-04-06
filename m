From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Apr 2017 22:05:05 +0000
Subject: [Intel-wired-lan] [next S66 v2 03/11] i40e: Decrease the scope
 of	rtnl lock
In-Reply-To: <20170405115103.67374-3-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
 <20170405115103.67374-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B1CD@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 5, 2017 4:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Maciej Sosin <maciej.sosin@intel.com>
> Subject: [Intel-wired-lan] [next S66 v2 03/11] i40e: Decrease the scope of rtnl
> lock
> 
> From: Maciej Sosin <maciej.sosin@intel.com>
> 
> Previously rtnl lock was held during whole reset procedure that was stoping
> other PFs running their reset procedures. In the result reset was not handled
> properly and host reset was the only way to recover.
> 
> Signed-off-by: Maciej Sosin <maciej.sosin@intel.com>
> Change-ID: I23c0771c0303caaa7bd64badbf0c667e25142954
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |   2 +-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |   6 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 138 +++++++++++++++++--
> ------
>  3 files changed, 101 insertions(+), 45 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


