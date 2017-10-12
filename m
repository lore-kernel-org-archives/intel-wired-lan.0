From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 12 Oct 2017 17:12:51 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/2 net-next] i40e: fix link
 reporting
In-Reply-To: <20171011214943.7076-1-alan.brady@intel.com>
References: <20171011214943.7076-1-alan.brady@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAC71C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alan Brady
> Sent: Wednesday, October 11, 2017 2:50 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 1/2 net-next] i40e: fix link reporting
> 
> When querying the NVM for supported phy_types, on some firmware
> versions, we were failing to actually fill out the phy_types which means
> ethtool wouldn't report any link types.
> 
> Testing-hints:
> Check 'ethtool <iface>' if you have the right (wrong?) firmware.
> Without this patch, no link modes will be reported.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


