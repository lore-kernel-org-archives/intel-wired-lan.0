From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Jul 2017 22:16:54 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Ensure MAC filter was
	added	before setting MACVLAN
In-Reply-To: <20170719220026.47784-1-anthony.l.nguyen@intel.com>
References: <20170719220026.47784-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB27E4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, July 19, 2017 3:00 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Ensure MAC filter was added
> before setting MACVLAN
> 
> This patch adds a check to ensure that adding the MAC filter was successful
> before setting the MACVLAN.  If it was unsuccessful, propagate the error.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2:
>   Made changes as suggested by Joe Perches.
>   - Declared retval as an int
>   - Switched logic to return on error
>   - Return 0 on success
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


