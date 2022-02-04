From: Switzer, David <david.switzer@intel.com>
Date: Fri, 4 Feb 2022 19:27:54 +0000
Subject: [Intel-wired-lan] [net-queue, v2,
 1/5] i40e: Remove rx page reuse double count.
In-Reply-To: <1639769719-81285-2-git-send-email-jdamato@fastly.com>
References: <1639769719-81285-1-git-send-email-jdamato@fastly.com>
 <1639769719-81285-2-git-send-email-jdamato@fastly.com>
Message-ID: <SN6PR11MB3518FA19E64833FA59065632EB299@SN6PR11MB3518.namprd11.prod.outlook.com>
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
>Subject: [net-queue,v2,1/5] i40e: Remove rx page reuse double count.
>
>Page reuse was being tracked from two locations:
>  - i40e_reuse_rx_page (via 40e_clean_rx_irq), and
>  - i40e_alloc_mapped_page
>
>Remove the double count and only count reuse from
>i40e_alloc_mapped_page when the page is about to be reused.
>
>Signed-off-by: Joe Damato <jdamato@fastly.com>
>---
> drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 --
> 1 file changed, 2 deletions(-)
>
Tested-By: Dave Switzer <david.switzer@intel.com>

