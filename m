From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Sep 2016 17:27:28 +0000
Subject: [Intel-wired-lan] [PATCH net-next 3/3] i40e: fix sideband
	flow	director vector allocation
In-Reply-To: <1474285071-28218-4-git-send-email-sassmann@kpanic.de>
References: <1474285071-28218-1-git-send-email-sassmann@kpanic.de>
 <1474285071-28218-4-git-send-email-sassmann@kpanic.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0E782@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next 3/3] i40e: fix sideband flow
> director vector allocation
> 
> Currently if the MSI-X vector limit is reached the sideband flow director gets
> disabled. A bit too early to make that decision, as vectors may get re-
> distributed. So move the check further back.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


