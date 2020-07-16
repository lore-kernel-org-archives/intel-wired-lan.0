From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Jul 2020 17:48:37 +0000
Subject: [Intel-wired-lan] [PATCH S50 14/15] ice: disable no longer
 needed workaround for FW logging
In-Reply-To: <20200713205318.32425-14-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
 <20200713205318.32425-14-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145494CA6676E7DF6160C788C7F0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, July 13, 2020 1:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S50 14/15] ice: disable no longer needed
> workaround for FW logging
> 
> From: Ben Shelton <benjamin.h.shelton@intel.com>
> 
> For the FW logging info AQ command, we currently set the ICE_AQ_FLAG_RD
> in order to work around a FW issue. This issue has been fixed so remove the
> workaround.
> 
> Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


