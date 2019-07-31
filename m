From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 17:08:18 +0000
Subject: [Intel-wired-lan] [PATCH S24 v2 02/12] ice: Account for all
 states of FW DCBx and LLDP
In-Reply-To: <20190729090454.5501-2-anthony.l.nguyen@intel.com>
References: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
 <20190729090454.5501-2-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40E85B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, July 29, 2019 2:05 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S24 v2 02/12] ice: Account for all states of
> FW DCBx and LLDP
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Currently, only the DCBx status is taken into account to determine if FW LLDP
> is possible.  But there are NVM version coming out with DCBx enabled, and
> FW LLDP disabled.  This is causing errors where the driver sees that DCBx is
> not disabled, and then tries to register for LLDP MIB change events, and fails.
> 
> Change the logic to detect both DCBx and LLDP states in the FW engine.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 34 +++++++-------------
>  1 file changed, 12 insertions(+), 22 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


