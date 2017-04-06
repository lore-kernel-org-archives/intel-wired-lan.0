From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Apr 2017 21:43:14 +0000
Subject: [Intel-wired-lan] [next S66 v2 06/11] i40e: remove extraneous
 loop	in i40e_vsi_wait_queues_disabled
In-Reply-To: <20170405115103.67374-6-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
 <20170405115103.67374-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B15E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 5, 2017 4:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next S66 v2 06/11] i40e: remove extraneous loop
> in i40e_vsi_wait_queues_disabled
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We can simply check both Tx and Rx queues in a single loop, rather than
> repeating the loop twice.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ic06f26b0e3c2620e0e33c1a2999edda488e647ad
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


