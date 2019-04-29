From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 29 Apr 2019 18:16:15 +0000
Subject: [Intel-wired-lan] [PATCH S20 10/15] ice: Remove redundant and
 premature event config
In-Reply-To: <20190416173052.28928-11-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
 <20190416173052.28928-11-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39ACC8@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S20 10/15] ice: Remove redundant and
> premature event config
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> In the path for re-enabling FW LLDP engine, there is a call to register for LLDP
> MIB change events.  This call is redundant, in that the call to ice_pf_dcb_cfg
> will already register the driver for these events.  Also, the call as it stands
> now is too early in the flow before before DCB is configured.
> 
> Remove the redundant call.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 6 ------
>  1 file changed, 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


