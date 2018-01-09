From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 9 Jan 2018 22:38:13 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] i40e: Fix channel
 addition in reset flow
In-Reply-To: <151546124009.14015.16331913167013558885.stgit@anamdev.jf.intel.com>
References: <151546124009.14015.16331913167013558885.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7FEC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Amritha Nambiar
> Sent: Monday, January 8, 2018 5:27 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] i40e: Fix channel
> addition in reset flow
> 
> Fix recreating the channel VSIs during the reset flow to reconfigure the Tx
> rings and the queue context associated with the channel VSI.
> Also update the next_base_queue for the VSI while rebuilding the channel
> VSIs after a reset.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


