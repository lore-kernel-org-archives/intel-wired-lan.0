From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 Jan 2018 19:15:27 +0000
Subject: [Intel-wired-lan] [next PATCH S85-V1 03/14] i40e: Do not allow
 use more TC queue pairs than MSI-X vectors exist
In-Reply-To: <20171229134910.14233-1-alice.michael@intel.com>
References: <20171229134910.14233-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D71E5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, December 29, 2017 5:49 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Jablonski, Pawel <pawel.jablonski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S85-V1 03/14] i40e: Do not allow use
> more TC queue pairs than MSI-X vectors exist
> 
> From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> 
> This patch suppresses the message about invalid TC mapping and wrong
> selected TX queue. The root cause of this bug was setting too many TC
> queue pairs on huge multiprocessor machines. When quantity of the TC
> queue pairs is exceeding MSI-X vectors count then TX queue number can be
> selected beyond actual TX queues amount.
> 
> Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++++
>  1 file changed, 4 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


