From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 25 Apr 2016 22:37:44 +0000
Subject: [Intel-wired-lan] [next PATCH S33 13/13] i40evf: Add driver
 support	for promiscuous mode
In-Reply-To: <1460475052-6348-14-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460475052-6348-14-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D4E1D@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S33 13/13] i40evf: Add driver support
> for promiscuous mode
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> Add necessary Linux Ethernet driver support for promiscuous mode
> operation. Add a flag so the VF knows it is in promiscuous mode and two
> state flags to discreetly track multicast and unicast promiscuous states.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-Id: Ib2f2dc7a7582304fec90fc917ebb7ded21ba1de4
> ---
> Testing Hints : Test using
> ip link set dev eXX promisc on/off
> on the vf
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c  | 14 +++++++-------
>  drivers/net/ethernet/intel/i40evf/i40evf.h          |  3 +++
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c     | 19
> +++++++++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 11 +++++++++++
>  4 files changed, 40 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Promiscuous mode can be enabled on VF driver
