From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Sep 2016 18:58:23 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/3] i40e: fix MSI-X
	vector	redistribution if hw limit is reached
In-Reply-To: <1474285071-28218-3-git-send-email-sassmann@kpanic.de>
References: <1474285071-28218-1-git-send-email-sassmann@kpanic.de>
 <1474285071-28218-3-git-send-email-sassmann@kpanic.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0EBA4@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next 2/3] i40e: fix MSI-X vector
> redistribution if hw limit is reached
> 
> The driver allocates 1 vector per CPU thread and the current hardware limit
> for vectors is 129 per PF. On systems with 128 or more threads this currently
> means all vectors are used by the PF leaving no room for additional features
> like VMDq, iWARP, etc...
> The code that should redistribute the vectors in this case is broken and never
> triggers. Fixed the code so that it actually triggers if the hardware limit is
> reached and adjust the number of queue pairs accordingly.
> Also the number of initially requested iWARP vectors was not properly saved
> when the vector limit was reached, and therefore always zero.
> 
> Comparison with debug statement.
> Before:
> i40e 0000:2d:00.0: VMDq disabled, not enough MSI-X vectors i40e
> 0000:2d:00.0: IWARP disabled, not enough MSI-X vectors i40e 00.0 MSI-X
> vector distribution: PF 128, VMDq 0, FDSB 0, iWARP 0
> After:
> i40e 0000:2d:00.0: MSI-X vector limit reached, attempting to redistribute
> vectors i40e 00.0 MSI-X vector distribution: PF 78, VMDq 8, FDSB 0, iWARP 42
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 38 +++++++++++++++++-----
> -------
>  1 file changed, 22 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


