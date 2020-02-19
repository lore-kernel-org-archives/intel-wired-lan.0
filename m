From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Feb 2020 19:40:41 +0000
Subject: [Intel-wired-lan] [PATCH S39 v2 07/15] ice: SW DCB,
 report correct max TC value
In-Reply-To: <20200213213129.34023-6-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
 <20200213213129.34023-6-anthony.l.nguyen@intel.com>
Message-ID: <4e52cc666a9449ad806ee3a78497a470@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 13, 2020 1:31 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 v2 07/15] ice: SW DCB, report correct
> max TC value
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


