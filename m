From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Aug 2017 17:24:14 +0000
Subject: [Intel-wired-lan] [next PATCH S77-V3 01/10] i40e: fix for
	flow	director counters not wrapping as expected
In-Reply-To: <20170714132709.52657-1-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E90AEE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:27 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Stachura, Mariusz <mariusz.stachura@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S77-V3 01/10] i40e: fix for flow
> director counters not wrapping as expected
> 
> From: Mariusz Stachura <mariusz.stachura@intel.com>
> 
> An eratta with GLQF_PCNT causes it to not wrap as expected. This can cause
> an error in flow director statistics. This patch resets affected counters just
> after reading.
> 
> Testing Hints (required if no HSD): DCR 2187
> 
> Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 35 +++++++++++++++++++--
> --------
>  1 file changed, 23 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


