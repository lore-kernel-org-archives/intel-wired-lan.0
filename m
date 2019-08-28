From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Aug 2019 17:05:59 +0000
Subject: [Intel-wired-lan] [PATCH S28 9/9] ice: Rework around
 device/function capabilities
In-Reply-To: <20190827131354.12703-9-anthony.l.nguyen@intel.com>
References: <20190827131354.12703-1-anthony.l.nguyen@intel.com>
 <20190827131354.12703-9-anthony.l.nguyen@intel.com>
Message-ID: <9b6fceb208524d6ab0b7003ff9fd11d7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, August 27, 2019 6:14 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S28 9/9] ice: Rework around
> device/function capabilities
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> ice_parse_caps is printing capabilities in a different way when compared to
> the variable names. This makes it difficult to search for the right strings in the
> debug logs. So this patch updates the print strings to be exactly the same as
> the fields' name in the structure.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 40 ++++++++++-----------
>  1 file changed, 20 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


