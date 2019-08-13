From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Aug 2019 17:25:48 +0000
Subject: [Intel-wired-lan] [PATCH S27 13/15] ice: move code closer
 together
In-Reply-To: <20190808143938.4968-13-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
 <20190808143938.4968-13-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D4116AB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, August 8, 2019 7:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S27 13/15] ice: move code closer together
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> This is a simple patch to move the assignment to a local variable closer to the
> site where the local variable is used.  This can help readability and also maybe
> performance, although the performance enhancement is really dependent
> upon the compiler.
> 
> No functional change.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


