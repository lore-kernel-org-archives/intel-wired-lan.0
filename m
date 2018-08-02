From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 Aug 2018 18:29:13 +0000
Subject: [Intel-wired-lan] [next PATCH S93 01/11] i40e: add helper
 function for copying strings from stat arrays
In-Reply-To: <20180731104148.11896-1-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2DB313@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S93 01/11] i40e: add helper function
> for copying strings from stat arrays
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Many of the ethtool statistics use the same basic logic for copying strings into
> the supplied buffer. A set of stats are stored in a const array of i40e_stats
> structures, and we apply these all together.
> 
> Simplify the stats code by introducing a helper function which can take a stats
> array and copy the strings into the buffer, updating the buffer pointer as we
> go.
> 
> We use a macro to implement i40e_add_stat_strings so that ARRAY_SIZE can
> be used on the array passed in. This ensures that we always use the
> matching size in __i40e_add_stat_strings.
> 
> More complex stats currently do not use i40e_stats arrays, usually due to
> custom formatted strings, or because the stats are not laid out in the
> expected way. These stats will be updated to use the helper function in
> separate future patches.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 59 +++++++++++++++++--
> -------
>  1 file changed, 39 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


