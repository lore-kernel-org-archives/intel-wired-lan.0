From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Feb 2020 22:34:04 +0000
Subject: [Intel-wired-lan] [PATCH S37 v3 09/15] ice: update Unit Load
 Status bitmask to check after reset
In-Reply-To: <20200206092013.23388-9-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
 <20200206092013.23388-9-anthony.l.nguyen@intel.com>
Message-ID: <6d71af06e6a9422ca9343c54eda1ecb3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 6, 2020 1:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 v3 09/15] ice: update Unit Load Status
> bitmask to check after reset
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> After a reset the Unit Load Status bits in the GLNVM_ULD register to check
> for completion should be 0x7FF before continuing.  Update the mask to
> check (minus the three reserved bits that are always set).
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c    | 18 +++++++++++++-----
>  .../net/ethernet/intel/ice/ice_hw_autogen.h    |  6 ++++++
>  2 files changed, 19 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


