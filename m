From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Sep 2016 18:55:47 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/3] i40e: check if vectors
 are	already depleted when doing VMDq allocation
In-Reply-To: <1474285071-28218-2-git-send-email-sassmann@kpanic.de>
References: <1474285071-28218-1-git-send-email-sassmann@kpanic.de>
 <1474285071-28218-2-git-send-email-sassmann@kpanic.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0EAE8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Stefan Assmann
> Sent: Monday, September 19, 2016 4:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH net-next 1/3] i40e: check if vectors are
> already depleted when doing VMDq allocation
> 
> During MSI-X vector allocation for VMDq, a check for "no vectors left"
> was missing, add it. This prevents more vectors to be allocated than available.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 27 ++++++++++++++++-------
> ----
>  1 file changed, 16 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


