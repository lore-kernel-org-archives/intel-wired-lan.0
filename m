From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Sep 2015 21:04:49 +0000
Subject: [Intel-wired-lan] [next PATCH S14 13/15] i40e/i40evf:
	Add	module_types and update_link_info
In-Reply-To: <1441065295-234333-14-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
 <1441065295-234333-14-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A626F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, August 31, 2015 4:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S14 13/15] i40e/i40evf: Add
> module_types and update_link_info
> 
> Add a module_types variable to the link_info struct to save the module
> information from get_phy_capabilities. This information can be used to
> determine which speeds the module supports.
> 
> Also add a new function update_link_info which updates the module_types
> parameter and then calls get_link_info. This function should be called in place
> of get_link_info so that the module_types variable stays up-to-date with the
> rest of the link information.
> 
> The EAS table does not reflect the values that are actually returned, so
> instead, basing these values on the Ethernet compliance codes specified in
> table 33 of SFF-8436 as these have been accurate.
> 
> Use the new variable in ethtool to differentiate between a 10G/1G dual
> speed fiber module and a 10G only module.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: Ib7585cce321319c10ce15180054c41a6cbd41389
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c    | 30
> +++++++++++++++++++++---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c   | 16 +++++++++----
>  drivers/net/ethernet/intel/i40e/i40e_main.c      |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_type.h      | 18 ++++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_type.h    | 18 ++++++++++++++
>  6 files changed, 76 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
