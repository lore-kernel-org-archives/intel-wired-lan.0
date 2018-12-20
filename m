From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 20:29:52 +0000
Subject: [Intel-wired-lan] [next PATCH S1 1/6] i40e: Limiting RSS queues
 to CPUs.
In-Reply-To: <20181219144542.85924-1-alice.michael@intel.com>
References: <20181219144542.85924-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343978@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 19, 2018 6:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S1 1/6] i40e: Limiting RSS queues to
> CPUs.
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> Limiting RSS queues number to online CPUs number in order to avoid issues
> with creating misconfigured RSS queues.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


