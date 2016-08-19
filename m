From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Aug 2016 16:35:37 +0000
Subject: [Intel-wired-lan] [PATCH] [dev-queue]i40e: Add support
	for	switchdev API for Switch ID
In-Reply-To: <20160818230123.6522.37801.stgit@terminator23.jf.intel.com>
References: <20160818230123.6522.37801.stgit@terminator23.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F9369@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Amritha Nambiar
> Sent: Thursday, August 18, 2016 4:01 PM
> To: Duyck, Alexander H <alexander.h.duyck@intel.com>; Nambiar, Amritha
> <amritha.nambiar@intel.com>; Singhai, Anjali <anjali.singhai@intel.com>;
> Fastabend, John R <john.r.fastabend@intel.com>; intel-wired-
> lan at lists.osuosl.org; Samudrala, Sridhar <sridhar.samudrala@intel.com>
> Subject: [Intel-wired-lan] [PATCH] [dev-queue]i40e: Add support for
> switchdev API for Switch ID
> 
> This is a follow-on patch to Sridhar's patch series for VF Port representor
> support for SR-IOV VFs on i40e.
> 
> This patch adds support for switchdev ops on the VF Port representors and
> the PF uplink, the only operation implemented is the port attribute API to get
> the port parent ID or the switch ID. The switch ID is used to identify the
> net_devices attached to the same HW switch.
> 
> The switch ID returned for the VF Port representors and the PF uplink is the
> phys_port_id.
> 
> # ip -d a
> 102: enp9s0f0: <BROADCAST,MULTICAST> mtu 1500 qdisc mq state DOWN
> group default qlen 1000
>     link/ether 68:05:ca:35:77:50 brd ff:ff:ff:ff:ff:ff promiscuity 0 numtxqueues
> 64 numrxqueues 64 portid 6805ca357750 switchid 6805ca357750
>     vf 0 MAC 00:00:00:00:00:00, spoof checking on, link-state auto
>     vf 1 MAC 00:00:00:00:00:00, spoof checking on, link-state auto
> 103: enp9s0f1: <BROADCAST,MULTICAST> mtu 1500 qdisc mq state DOWN
> group default qlen 1000
>     link/ether 68:05:ca:35:77:51 brd ff:ff:ff:ff:ff:ff promiscuity 0 numtxqueues
> 64 numrxqueues 64 portid 6805ca357751 switchid 6805ca357751
> 104: enp9s0f0-vf0: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel state
> DOWN group default qlen 1000
>     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 numtxqueues 1
> numrxqueues 1 switchid 6805ca357750
> 105: enp9s0f0-vf1: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel state
> DOWN group default qlen 1000
>     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 numtxqueues 1
> numrxqueues 1 switchid 6805ca357750
>     inet6 fe80::200:ff:fe00:0/64 scope link tentative
>        valid_lft forever preferred_lft forever
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |    1
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |   17 ++++++
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   57
> ++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |    2 +
>  4 files changed, 77 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Switch/port IDs shown as expected


