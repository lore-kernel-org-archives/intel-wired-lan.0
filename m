From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Jul 2015 20:34:53 +0000
Subject: [Intel-wired-lan] [next PATCH S9 02/15] i40e: Fix a port
	VLAN	configuration bug
In-Reply-To: <1437684884-222825-3-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
 <1437684884-222825-3-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE6E2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, July 23, 2015 1:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S9 02/15] i40e: Fix a port VLAN
> configuration bug
> 
> From: Greg Rose <gregory.v.rose@intel.com>
> 
> If a port VLAN is set for a given virtual function (VF) before the VF driver is
> loaded then a configuration error results in which the port VLAN is ignored
> when the VF driver is subsequently loaded.  This causes the VF's MAC/VLAN
> filters to not use the correct VLAN filter.  This patch ensures that the port
> VLAN filter is considered at the right time during configuration of the VF's
> MAC/VLAN filters.
> 
> Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
> Change-ID: I28f404cbc21a4c6d70a7980b87c77f13f06685a4
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Present in git log, code changes present in tree, verified able to create VF prior to driver loading, no errors when driver is subsequently loaded, and VF is able to pass traffic.
