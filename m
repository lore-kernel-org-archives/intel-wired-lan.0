From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 28 Sep 2015 17:36:58 +0000
Subject: [Intel-wired-lan] [next PATCH S 2/2 v3] i40e/i40evf: refactor
 tx	timeout logic
In-Reply-To: <1443132795-139834-1-git-send-email-catherine.sullivan@intel.com>
References: <1443132795-139834-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B1D28@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, September 24, 2015 3:13 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S 2/2 v3] i40e/i40evf: refactor tx
> timeout logic
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> This patch modifies the driver timeout logic by issuing a writeback request via
> a software interrupt to the hardware the first time the driver detects a hang.
> The driver was too agrressive in resetting a hung queue, so back that off by
> removing logic to down the netdevice after too many hangs, and move the
> function to the service task.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ife100b9d124cd08cbdb81ab659008c1b9abbedea
> ---
> v3: Made i40evf_force_wb static.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h        |   1 -
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 274 +++++++++++++++------
> -----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  75 +------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  10 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  96 +--------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h |   8 -
>  6 files changed, 173 insertions(+), 291 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, still see occasional tx_timeout with hung queue, however adaptor does not reset and link does not go down.
