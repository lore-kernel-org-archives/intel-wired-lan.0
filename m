From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Apr 2019 18:43:36 +0000
Subject: [Intel-wired-lan] [PATCH] iavf: Limiting RSS queues to CPUs
In-Reply-To: <20190329194850.79377-1-alice.michael@intel.com>
References: <20190329194850.79377-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D378643@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, March 29, 2019 12:49 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH] iavf: Limiting RSS queues to CPUs
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> Limiting RSS queues number to online CPUs number in order to avoid issues
> with creating misconfigured RSS queues.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


