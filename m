From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 30 Jan 2020 22:47:06 +0000
Subject: [Intel-wired-lan] [PATCH S39 07/15] ice: SW DCB,
 report correct max TC value
In-Reply-To: <20200127085927.13999-7-anthony.l.nguyen@intel.com>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
 <20200127085927.13999-7-anthony.l.nguyen@intel.com>
Message-ID: <ef36644ea4a14b6bafc2682f1a35c19d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, January 27, 2020 12:59 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 07/15] ice: SW DCB, report correct max
> TC value
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> lldpad is using the value reported in the DCB config for max_tc as the max
> allowed number of TCs, not the current max.  ICE driver was reporting it as
> current maximum TC.
> 
> Change DCB_NL function to report maximum TC allowed by this device.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


