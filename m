From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 Sep 2015 21:36:50 +0000
Subject: [Intel-wired-lan] [next PATCH S14 04/15] i40evf: properly
 handle	ndo_set_mac_address calls
In-Reply-To: <1441065295-234333-5-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
 <1441065295-234333-5-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A6520@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S14 04/15] i40evf: properly handle
> ndo_set_mac_address calls
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The driver was not correctly handling calls to its ndo_set_mac_address
> method. It did not properly check to see if the override would be allowed by
> the PF driver, and never removed the old address from its filter list.
> 
> Add a new flag to the adapter struct which is set if the MAC address is
> assigned by the PF. Check this flag and don't allow the MAC address to be
> changed if it is set. Search for and properly remove the filter for the old MAC
> address when the new one is set.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I817bf620c869c5a80e6a7eab65c9cbad1dc89799
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h      |  1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 18 +++++++++++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, can change VF MAC with ethtool and ip.
