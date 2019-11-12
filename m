From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Nov 2019 19:35:33 +0000
Subject: [Intel-wired-lan] [PATCH S33 11/15] ice: add helpers for
 virtchnl
In-Reply-To: <20191108142331.10221-11-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
 <20191108142331.10221-11-anthony.l.nguyen@intel.com>
Message-ID: <17f52e93f82142a6aa24a13732c5a64a@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S33 11/15] ice: add helpers for virtchnl
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The virtchannel interface was repeating a lot of strings and wasting storage
> space in the kernel.  There was also inconsistent messages for the same
> thing.  Consolidate all those messages and bit checks into a couple of helper
> functions.
> 
> Also, reduce stack space usage by simplifying getting the pointer to the pf
> using a helper.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Co-developed-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 134 ++++++++----------
>  1 file changed, 63 insertions(+), 71 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


