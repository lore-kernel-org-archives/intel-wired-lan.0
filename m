From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 May 2018 22:14:27 +0000
Subject: [Intel-wired-lan] [next PATCH S92 7/9] i40e: update data
 pointer directly when copying to the buffer
In-Reply-To: <20180517080840.30192-7-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
 <20180517080840.30192-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B771890@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, May 17, 2018 1:09 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S92 7/9] i40e: update data pointer
> directly when copying to the buffer
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> A future patch is going to add a helper function i40e_add_ethtool_stats that
> will help lower the amount of boiler plate code in the i40e_get_ethtool_stats
> function.
> 
> This conversion will take place over many patches, and the helper function
> will work by directly updating a reference to the data pointer.
> 
> Since this would not work combined with the current method of accessing
> data like an array, update all the code that copies stats into the data buffer to
> use direct updates to the pointer instead of array accesses.
> 
> This will prevent incorrect stat updates for patches in between the
> conversion.
> 
> Similarly, when copying strings, we used a separate char *p pointer.
> Instead, use the data pointer directly as it's already a (u8 *) type which is the
> same size.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 117 ++++++++++++---------
> ----
>  1 file changed, 58 insertions(+), 59 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


