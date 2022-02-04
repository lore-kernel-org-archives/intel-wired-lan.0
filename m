From: Switzer, David <david.switzer@intel.com>
Date: Fri, 4 Feb 2022 19:26:03 +0000
Subject: [Intel-wired-lan] [net-queue, v2,
 5/5] i40e: Add a stat for tracking busy rx pages.
In-Reply-To: <1639769719-81285-6-git-send-email-jdamato@fastly.com>
References: <1639769719-81285-1-git-send-email-jdamato@fastly.com>
 <1639769719-81285-6-git-send-email-jdamato@fastly.com>
Message-ID: <SN6PR11MB35181032FC5D1E9037CEB040EB299@SN6PR11MB3518.namprd11.prod.outlook.com>
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
>Subject: [net-queue,v2,5/5] i40e: Add a stat for tracking busy rx pages.
>
>In some cases, pages cannot be reused by i40e because the page is busy. Add
>a counter for this event.
>
>Busy page count is accessible via ethtool.
>
>Signed-off-by: Joe Damato <jdamato@fastly.com>
>---
> drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  1 +
> drivers/net/ethernet/intel/i40e/i40e_main.c    |  5 ++++-
> drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 12 ++++++++----
> drivers/net/ethernet/intel/i40e/i40e_txrx.h    |  1 +
> 5 files changed, 15 insertions(+), 5 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>

