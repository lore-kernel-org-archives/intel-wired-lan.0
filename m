From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jul 2019 18:19:13 +0000
Subject: [Intel-wired-lan] [PATCH S24 09/12] ice: silence some bogus
 error messages
In-Reply-To: <20190723092759.3614-9-anthony.l.nguyen@intel.com>
References: <20190723092759.3614-1-anthony.l.nguyen@intel.com>
 <20190723092759.3614-9-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40CDEF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, July 23, 2019 2:28 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S24 09/12] ice: silence some bogus error
> messages
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> In some circumstances, VF devices can be deactivated while a message is in-
> flight. In that case, a series of  scary error message will be printed in the log.
> Since these are actually harmless, check for this case and suppress them. No
> harm, no foul.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h  | 1 +
> drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


