From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Jan 2016 21:22:59 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S27 01/15] i40e:
	move	sync_vsi_filters up in service_task
In-Reply-To: <1452732712-12248-2-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
 <1452732712-12248-2-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9808DB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, January 13, 2016 4:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH S27 01/15] i40e: move
> sync_vsi_filters up in service_task
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The sync_vsi_filters function is moved up in the service_task because it may
> need to request a reset, and we don't want to wait another round of service
> task time.
> 
> NOTE: Filters will be replayed by sync_vsi_filters including broadcast and
> promiscuous settings.
> 
> Also, added some error handling in this space in case any of these fail the
> driver will retry correctly.
> 
> Also update copyright year.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I23f3d552100baecea69466339f738f27614efd47
> ---
> Testing Hints: This bug hits a sensitive area of the driver that is used in many
> different paths such as reset (PFR/CORER/GLOBR) and multicast address
> add/remove, vlan add/remove, MAC address add/remove.  As much testing
> as possible should be done in the areas of filter add/remove, maximum filter
> add, etc.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, driver correctly recovers from errors in reset/filter paths
