From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 25 Apr 2016 22:36:30 +0000
Subject: [Intel-wired-lan] [next PATCH S33 11/13] i40e: Add promiscuous
 on	VLAN support
In-Reply-To: <1460475052-6348-12-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460475052-6348-12-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D4DFD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Tuesday, April 12, 2016 8:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S33 11/13] i40e: Add promiscuous on
> VLAN support
> 
> From: Greg Rose <gregory.v.rose@intel.com>
> 
> NFV use cases require the ability to steer packets to VSIs by VLAN tag alone
> while being in promiscuous mode for multicast and unicast MAC addresses.
> These two new functions support that ability.
> 
> Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c    | 70
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h |  8 +++
>  2 files changed, 78 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Promiscuous mode, packet steering works with VLAN traffic correctly
