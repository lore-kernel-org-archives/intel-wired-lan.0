From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Mar 2018 21:21:21 +0000
Subject: [Intel-wired-lan] [S87 v5 5/7] i40e: factor out re-enable
 functions for ATR and SB
In-Reply-To: <20180308225211.12254-5-jeffrey.t.kirsher@intel.com>
References: <20180308225211.12254-1-jeffrey.t.kirsher@intel.com>
 <20180308225211.12254-5-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94BE3E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [S87 v5 5/7] i40e: factor out re-enable functions for
> ATR and SB
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> A future patch needs to expand on the logic for re-enabling ATR. Doing so
> would cause some code to break the 80-character line limit.
> 
> To reduce the level of indentation, factor out helper functions for re-
> enabling ATR and SB rules.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 48 +++++++++++++++++++--
> --------
>  1 file changed, 32 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


