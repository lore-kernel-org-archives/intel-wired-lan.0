From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 18:14:57 +0000
Subject: [Intel-wired-lan] [PATCH S25 12/12] ice: fix ice_is_tc_ena
In-Reply-To: <20190725095401.24590-12-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
 <20190725095401.24590-12-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40EB0E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, July 25, 2019 2:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S25 12/12] ice: fix ice_is_tc_ena
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> ice_is_tc_ena is used to check whether a given traffic class is enabled.
> Because there are only 8 traffic classes, the function took a u8 bitmap. This
> causes problems because it is cast to an unsigned long causing a static
> analysis warning regarding Out-of-bounds read.
> 
> Fix this by simply updating ice_is_tc_ena to take an unsigned long.
> Passing a u8 to this function should implicitly convert the value.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_type.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


