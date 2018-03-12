From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Mar 2018 21:20:53 +0000
Subject: [Intel-wired-lan] [S87 v5 4/7] i40e: track filter type
 statistics when deleting invalid filters
In-Reply-To: <20180308225211.12254-4-jeffrey.t.kirsher@intel.com>
References: <20180308225211.12254-1-jeffrey.t.kirsher@intel.com>
 <20180308225211.12254-4-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94BE2E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, March 8, 2018 2:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [S87 v5 4/7] i40e: track filter type statistics when
> deleting invalid filters
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When hardware has trouble with a particular filter, we delete it from the list.
> Unfortunately, we did not properly update the per-filter statistic when doing
> so.
> 
> Create a helper function to handle this, and properly reduce the necessary
> counter so that it tracks the number of active filters properly.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 56
> ++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


