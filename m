From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jan 2018 22:19:09 +0000
Subject: [Intel-wired-lan] [next PATCH S84-V2 10/13] i40e: Fix kdump
 failure
In-Reply-To: <20171227132211.24019-1-alice.michael@intel.com>
References: <20171227132211.24019-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7057@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 27, 2017 5:22 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S84-V2 10/13] i40e: Fix kdump failure
> 
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> kdump fails in the system when used in conjunction with Ethernet driver
> X722/X710. This is mainly because when we are resource constrained i.e.
> when we have just one online_cpus, we are enabling VMDq and iWARP. It
> doesn't make sense to enable them with just one cpu and starve kdump for
> lack of IRQs.
> 
> So don't enable VMDq or iWARP when we just have a single cpu.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


