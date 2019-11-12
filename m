From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Nov 2019 19:32:34 +0000
Subject: [Intel-wired-lan] [PATCH S33 05/15] ice: fix stack leakage
In-Reply-To: <20191108142331.10221-5-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
 <20191108142331.10221-5-anthony.l.nguyen@intel.com>
Message-ID: <6489ebacf7bb4f4592f51b4a653d13f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, November 8, 2019 6:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S33 05/15] ice: fix stack leakage
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> In the case of an invalid virtchannel request the driver would return
> uninitialized data to the VF from the PF stack which is a bug.  Fix by initializing
> the stack variable earlier in the function before any return paths can be
> taken.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


