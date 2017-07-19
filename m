From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Jul 2017 19:11:35 +0000
Subject: [Intel-wired-lan] [next PATCH S76-V2 02/13] i40e: remove
 workaround	for resetting XPS on newer kernels
In-Reply-To: <20170714131019.52530-2-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
 <20170714131019.52530-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB24B6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:10 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S76-V2 02/13] i40e: remove
> workaround for resetting XPS on newer kernels
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Since commit 3ffa037d7f78 ("i40e: Set XPS bit mask to zero in DCB mode")
> we've tried to reset the XPS settings by building a custom empty CPU mask.
> 
> This workaround is not necessary because we're not really removing the XPS
> setting, but simply setting it so that no CPU is valid. Since v4.10 we've had this
> taken care of for us in the netdev core code.
> 
> We recently added a new macro to COMPAT which allows us to wrap the XPS
> workaround when it's not necessary.
> 
> While we're doing this, we change the ordering of the calls, and add an early
> return statement. This helps make the code easier to understand, and
> reduces the headache of reading these #ifdefs. This should help future
> maintainability.
> 
> Second, we shorten the code further by using zalloc_cpumask_var instead of
> a separate call to bitmap_zero().
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


