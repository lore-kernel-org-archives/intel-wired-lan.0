From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Nov 2015 17:48:33 +0000
Subject: [Intel-wired-lan] [next PATCH S21 01/14] i40evf: increase
	max	number of queues
In-Reply-To: <1446852372-25480-2-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
 <1446852372-25480-2-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060E17E8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, November 06, 2015 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S21 01/14] i40evf: increase max
> number of queues
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Future devices will allow for more queue pairs, so allocate a netdev that can
> handle them. While we're at it, get rid of the separate MAX_TX/MAX_RX
> defines. Since we always get matched queue pairs, having these makes no
> sense.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I0e3556cd9a962506e509eb7c0afa36b329e8cb51
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h      | 3 +--
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
