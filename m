From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 Sep 2015 21:14:04 +0000
Subject: [Intel-wired-lan] [next PATCH S14 12/15] i40e: Add promiscuous
 on	VLAN support
In-Reply-To: <1441065295-234333-13-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
 <1441065295-234333-13-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A64B8@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S14 12/15] i40e: Add promiscuous on
> VLAN support
> 
> From: Greg Rose <gregory.v.rose@intel.com>
> 
> NFV use cases require the ability to steer packets to VSIs by VLAN tag alone
> while being in promiscuous mode for multicast and unicast MAC addresses.
> These two new functions support that ability.
> 
> Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
> Change-ID: Ifef704b07e0ee8a39d3c351dbd5dc83bb2f63c45
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c    | 68
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h |  6 +++
>  2 files changed, 74 insertions(+)

Code changes present in tree, monitoring VLAN interface with Wireshark set to promiscuous mode shows "entering promiscuous mode" for the vlan, but vlan will not pass traffic. PF will pass traffic.
