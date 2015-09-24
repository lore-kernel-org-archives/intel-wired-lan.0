From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 24 Sep 2015 19:25:54 +0000
Subject: [Intel-wired-lan] [net PATCH V2] i40e: fix VLAN inside VXLAN
In-Reply-To: <1442955422-192436-1-git-send-email-jesse.brandeburg@intel.com>
References: <1442955422-192436-1-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B18D1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Tuesday, September 22, 2015 1:57 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net PATCH V2] i40e: fix VLAN inside VXLAN
> 
> Previously to this patch, the hardware was removing VLAN tags from the
> inner header of VXLAN packets.  The hardware configuration can be changed
> to leave the packet alone since that is what the linux stack expects for this
> type of VLAN in VXLAN packet.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2 - capitalized acronyms in commit message
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, configured systems with VLAN inside a VxLAN, passed traffic and observed correct headers present on VLAN and VxLAN traffic.

