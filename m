From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Sep 2015 21:20:43 +0000
Subject: [Intel-wired-lan] [next PATCH S14 v2 14/15] i40e/i40evf:
 Refactor	PHY structure and add phy_capabilities enum
In-Reply-To: <1441121790-31321-1-git-send-email-catherine.sullivan@intel.com>
References: <1441121790-31321-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A628D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Tuesday, September 01, 2015 8:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S14 v2 14/15] i40e/i40evf: Refactor
> PHY structure and add phy_capabilities enum
> 
> Remove unused members in the PHY structure and add a new member to
> store all the capabilities the PHY has as reported by the FW. This information
> will help us determine what speeds the device is capable of when link is
> down.
> 
> Also add an enum to decode the PHY types the NVM is capable of.
> Use the phy_types variable to determine what phy types are possible when
> link is down instead of device id as it will be more accurate.
> 
> When on a backplane device, we do not support changing any settings,
> however we should display all the phy_types we are capable of so if we see a
> backplane dev ID set supported and advertised purely based on the
> phy_types variable.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: Ia75d560f1fcd30c54cbfb7458690c5867559a930
> ---
> v2: Fix sparse error with le32_to_cpu call
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 189 ++++++++++++++------
> -----
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |   8 ++
>  drivers/net/ethernet/intel/i40e/i40e_type.h    |  37 ++++-
>  drivers/net/ethernet/intel/i40evf/i40e_type.h  |  37 ++++-
>  4 files changed, 181 insertions(+), 90 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
