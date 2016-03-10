From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Mar 2016 18:38:09 +0000
Subject: [Intel-wired-lan] [PATCH 2/5] i40e/i40evf: Add support for
	bulk	free in Tx cleanup
In-Reply-To: <20160307173003.5682.90872.stgit@localhost.localdomain>
References: <20160307172722.5682.38580.stgit@localhost.localdomain>
 <20160307173003.5682.90872.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99CCD9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, March 07, 2016 9:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/5] i40e/i40evf: Add support for bulk free
> in Tx cleanup
> 
> This patch enables bulk Tx clean for skbs.  In order to enable it we need to
> pass the napi_budget value as that is used to determine if we are truly
> running in NAPI mode or if we are simply calling the routine from netpoll with
> a budget of 0.  In order to avoid adding too many more variables I thought it
> best to pass the VSI directly in a fashion similar to what we do on igb and
> ixgbe with the q_vector.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   20 +++++++++++---------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   20 +++++++++++---------
>  2 files changed, 22 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver correctly builds and passes traffic normally.
