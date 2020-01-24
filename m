From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jan 2020 23:17:09 +0000
Subject: [Intel-wired-lan] [PATCH S37 09/15] ice: update Unit Load
 Status bitmask to check after reset
In-Reply-To: <20200122152041.41498-9-anthony.l.nguyen@intel.com>
References: <20200122152041.41498-1-anthony.l.nguyen@intel.com>
 <20200122152041.41498-9-anthony.l.nguyen@intel.com>
Message-ID: <ba8ef820247142c4a3663d41db885f7d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 09/15] ice: update Unit Load Status
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


