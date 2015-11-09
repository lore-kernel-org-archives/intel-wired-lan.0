From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Nov 2015 18:02:55 +0000
Subject: [Intel-wired-lan] [next PATCH S21 02/14] i40evf: set real num
 queues
In-Reply-To: <1446852372-25480-3-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
 <1446852372-25480-3-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060E17FC@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S21 02/14] i40evf: set real num
> queues
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Use the helper function to set the real number of RX queues, and also set
> the real number of TX queues.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I67982799de3f248fb4158ccdc9b1a74385f42ddd
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
