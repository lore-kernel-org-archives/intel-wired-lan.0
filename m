From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 17:05:23 +0000
Subject: [Intel-wired-lan] [next PATCH S12 01/15] i40e/i40evf: Add a
 stat to	keep track of linearization count
In-Reply-To: <1440690163-128213-2-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
 <1440690163-128213-2-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5CFE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, August 27, 2015 8:42 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S12 01/15] i40e/i40evf: Add a stat to
> keep track of linearization count
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> Keep track of how many times we ask the stack to linearize the skb because
> the HW cannot handle skbs with more than 8 frags per segment/single
> packet.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: If455452060963a769bbe6112cba952e79e944b52
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 5 ++++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 5 +++--
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c  | 5 +++--
> drivers/net/ethernet/intel/i40evf/i40e_txrx.h  | 1 +
>  7 files changed, 14 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
