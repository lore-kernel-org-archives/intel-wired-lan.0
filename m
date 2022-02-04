From: Switzer, David <david.switzer@intel.com>
Date: Fri, 4 Feb 2022 19:24:29 +0000
Subject: [Intel-wired-lan] [net-queue, v2,
 2/5] i40e: Aggregate and export RX page reuse stat.
In-Reply-To: <1639769719-81285-3-git-send-email-jdamato@fastly.com>
References: <1639769719-81285-1-git-send-email-jdamato@fastly.com>
 <1639769719-81285-3-git-send-email-jdamato@fastly.com>
Message-ID: <SN6PR11MB3518A49809BC6EE6C6A2333BEB299@SN6PR11MB3518.namprd11.prod.outlook.com>
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
>Subject: [net-queue,v2,2/5] i40e: Aggregate and export RX page reuse stat.
>
>rx page reuse was already being tracked by the i40e driver per RX ring.
>Aggregate the counts and make them accessible via ethtool.
>
>Signed-off-by: Joe Damato <jdamato@fastly.com>
>---
> drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
> drivers/net/ethernet/intel/i40e/i40e_main.c    | 5 ++++-
> 3 files changed, 6 insertions(+), 1 deletion(-)
>
Tested-By: Dave Switzer <david.switzer@intel.com>


