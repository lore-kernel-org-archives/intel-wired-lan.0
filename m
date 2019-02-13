From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Feb 2019 20:21:49 +0000
Subject: [Intel-wired-lan] [next PATCH S2-V2 10/12] i40e: Report
 advertised link modes on 40GBASE_SR4
In-Reply-To: <20190206230826.24970-10-alice.michael@intel.com>
References: <20190206230826.24970-1-alice.michael@intel.com>
 <20190206230826.24970-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D365FFC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, February 6, 2019 3:08 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Ludkiewicz, Adam <adam.ludkiewicz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S2-V2 10/12] i40e: Report advertised
> link modes on 40GBASE_SR4
> 
> From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
> 
> Defined the advertised link mode field for 40000baseSR4_Full for use with
> ethtool.
> 
> Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


