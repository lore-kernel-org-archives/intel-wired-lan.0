From: Switzer, David <david.switzer@intel.com>
Date: Mon, 7 Feb 2022 15:17:35 +0000
Subject: [Intel-wired-lan] [net-queue, v2,
 4/5] i40e: Add a stat for tracking pages waived.
In-Reply-To: <1639769719-81285-5-git-send-email-jdamato@fastly.com>
References: <1639769719-81285-1-git-send-email-jdamato@fastly.com>
 <1639769719-81285-5-git-send-email-jdamato@fastly.com>
Message-ID: <SN6PR11MB3518C39BFBA3C58F8995F191EB2C9@SN6PR11MB3518.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



>-----Original Message-----
>From: Joe Damato <jdamato@fastly.com>
>Sent: Friday, December 17, 2021 11:35 AM
To: intel-wired-lan@lists.osuosl.org
>Cc: kuba at kernel.org; Brandeburg, Jesse <jesse.brandeburg@intel.com>;
>Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Joe Damato
><jdamato@fastly.com>
>Subject: [net-queue,v2,4/5] i40e: Add a stat for tracking pages waived.
>
>In some cases, pages can not be reused because they are not associated with
>the correct NUMA zone. Knowing how often pages are waived helps users to
>understand the interaction between the driver's memory usage and their
>system.
>
>Pass rx_stats through to i40e_can_reuse_rx_page to allow tracking when
>pages are waived.
>
>The page waive count is accessible via ethtool.
>
>Signed-off-by: Joe Damato <jdamato@fastly.com>
>---
> drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  1 +
> drivers/net/ethernet/intel/i40e/i40e_main.c    |  5 ++++-
> drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 13 ++++++++++---
> drivers/net/ethernet/intel/i40e/i40e_txrx.h    |  1 +
> 5 files changed, 17 insertions(+), 4 deletions(-)
>
Tested-By: Dave Switzer <david.switzer@intel.com>


