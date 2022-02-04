From: Switzer, David <david.switzer@intel.com>
Date: Fri, 4 Feb 2022 19:27:08 +0000
Subject: [Intel-wired-lan] [net-queue, v2,
 3/5] i40e: Add a stat tracking new RX page allocations.
In-Reply-To: <1639769719-81285-4-git-send-email-jdamato@fastly.com>
References: <1639769719-81285-1-git-send-email-jdamato@fastly.com>
 <1639769719-81285-4-git-send-email-jdamato@fastly.com>
Message-ID: <SN6PR11MB3518D319A2EF050E5E83C756EB299@SN6PR11MB3518.namprd11.prod.outlook.com>
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
>Subject: [net-queue,v2,3/5] i40e: Add a stat tracking new RX page allocations.
>
>Add a counter for new page allocations in the i40e RX path. This stat is
>accessible with ethtool.
>
>Signed-off-by: Joe Damato <jdamato@fastly.com>
>---
> drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
> drivers/net/ethernet/intel/i40e/i40e_main.c    | 5 ++++-
> drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 2 ++
> drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 1 +
> 5 files changed, 9 insertions(+), 1 deletion(-)
>
Tested-By: Dave Switzer <david.switzer@intel.com>

