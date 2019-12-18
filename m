From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:25:47 +0000
Subject: [Intel-wired-lan] [PATCH S35 08/15] ice: Remove Rx flex
 descriptor programming
In-Reply-To: <20191212111307.33566-8-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
 <20191212111307.33566-8-anthony.l.nguyen@intel.com>
Message-ID: <0df4bf9c351b4f23a5d23a67a3b0d0f2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, December 12, 2019 3:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S35 08/15] ice: Remove Rx flex descriptor
> programming
> 
> From: Vignesh Sridhar <vignesh.sridhar@intel.com>
> 
> Remove Rx flex descriptor metadata and flag programming; per specification
> these registers cannot be written to as they are read only.
> 
> Signed-off-by: Vignesh Sridhar <vignesh.sridhar@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c   | 104 ------------------
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   9 --
>  2 files changed, 113 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


