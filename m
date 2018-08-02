From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 Aug 2018 18:29:38 +0000
Subject: [Intel-wired-lan] [next PATCH S93 02/11] i40e: add helper to
 copy statistic values into ethtool buffer
In-Reply-To: <20180731104148.11896-2-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
 <20180731104148.11896-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2DB323@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 31, 2018 3:42 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S93 02/11] i40e: add helper to copy
> statistic values into ethtool buffer
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Similar to the helper function to copy the ethtool stats strings, add and use a
> helper function for copying the ethtool stats into the supplied buffer.
> 
> Just like before, we use a macro to avoid having to pass ARRAY_SIZE
> manually, so as to reduce chance of bugs.
> 
> Some of the stats, especially queue stats, are a bit trickier, and will be
> handled in future patches.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 116
> ++++++++++++++++++++-----
>  1 file changed, 93 insertions(+), 23 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


