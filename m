From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Aug 2016 16:00:20 +0000
Subject: [Intel-wired-lan] [dev-queue PATCH v2 1/3] i40e: Introduce VF
 port	representor/control netdevs.
In-Reply-To: <1471542901-13405-2-git-send-email-sridhar.samudrala@intel.com>
References: <1471542901-13405-1-git-send-email-sridhar.samudrala@intel.com>
 <1471542901-13405-2-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F9339@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Thursday, August 18, 2016 10:55 AM
> To: intel-wired-lan at lists.osuosl.org; Singhai, Anjali
> <anjali.singhai@intel.com>; Fastabend, John R
> <john.r.fastabend@intel.com>; Nambiar, Amritha
> <amritha.nambiar@intel.com>; Duyck, Alexander H
> <alexander.h.duyck@intel.com>
> Subject: [Intel-wired-lan] [dev-queue PATCH v2 1/3] i40e: Introduce VF port
> representor/control netdevs.
> 
> This patch enables creation of a VF Port representor/Control netdev
> associated with each VF. These netdevs can be used to control and configure
> VFs from PFs namespace. They enable exposing VF statistics, configuring link
> state, mtu, fdb/vlan entries etc.
> 
>     # echo 2 > /sys/class/net/enp5s0f0/device/sriov_numvfs
>     # ip l show
>     297: enp5s0f0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop portid
> 6805ca2e7268 state DOWN mode DEFAULT group default qlen 1000
>     link/ether 68:05:ca:2e:72:68 brd ff:ff:ff:ff:ff:ff
>     vf 0 MAC 00:00:00:00:00:00, spoof checking on, link-state auto, trust off
>     vf 1 MAC 00:00:00:00:00:00, spoof checking on, link-state auto, trust off
>     299: enp5s0f0-vf0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state
> DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
>     300: enp5s0f0-vf1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state
> DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 88
> ++++++++++++++++++++++
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 14 ++++
>  2 files changed, 102 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Functions as expected


