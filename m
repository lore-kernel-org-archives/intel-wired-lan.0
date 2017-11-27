From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Nov 2017 23:37:35 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] i40e: Support
 only TCP filters via big buffer
In-Reply-To: <151096270698.41070.15719394215346077510.stgit@anamdev.jf.intel.com>
References: <151096270698.41070.15719394215346077510.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAF91A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Amritha Nambiar
> Sent: Friday, November 17, 2017 3:52 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] i40e: Support only
> TCP filters via big buffer
> 
> Change big buffer cloud filter function to operate in TCP only mode. UDP
> based filters are not supported via big buffer cloud filters. Also change few
> return types to indicate unsupported vs invalid configuration.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


