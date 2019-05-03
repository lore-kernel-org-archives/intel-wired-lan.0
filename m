From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 3 May 2019 23:38:59 +0000
Subject: [Intel-wired-lan] [next PATCH S5 07/10] i40e: Missing response
 checks in driver when starting/stopping FW LLDP
In-Reply-To: <20190424122055.27896-7-alice.michael@intel.com>
References: <20190424122055.27896-1-alice.michael@intel.com>
 <20190424122055.27896-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39C6DB@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 24, 2019 5:21 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Marczak, Piotr <piotr.marczak@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S5 07/10] i40e: Missing response
> checks in driver when starting/stopping FW LLDP
> 
> From: Piotr Marczak <piotr.marczak@intel.com>
> 
> Driver did not check response on LLDP flag change and always returned
> SUCCESS.
> 
> This patch now checks for an error and returns an error code and has
> additional information in the log.
> 
> Signed-off-by: Piotr Marczak <piotr.marczak@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


