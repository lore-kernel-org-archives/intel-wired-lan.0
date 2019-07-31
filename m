From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 17:36:51 +0000
Subject: [Intel-wired-lan] [PATCH S23 v4 08/15] ice: allow empty rx
 descriptors
In-Reply-To: <20190725085541.55104-8-anthony.l.nguyen@intel.com>
References: <20190725085541.55104-1-anthony.l.nguyen@intel.com>
 <20190725085541.55104-8-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40E97F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, July 25, 2019 1:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S23 v4 08/15] ice: allow empty rx
> descriptors
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> In some circumstances, the hardware will hand us a receive descriptor which
> has no data attached, but is otherwise valid. The receive code was
> improperly ignoring these descriptors, which result in an infinite loop.
> 
> To fix this, change the receive code to process all descriptors, regardless of
> the size of the associated data. Add checks to the memory-handling
> functions to allow for zero size.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


