From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Mar 2017 19:35:46 +0000
Subject: [Intel-wired-lan] [next-queue v6 PATCH 2/7] i40e: Introduce
 Port	Representor netdevs and switchdev mode.
In-Reply-To: <1490833375-2788-3-git-send-email-sridhar.samudrala@intel.com>
References: <1490833375-2788-1-git-send-email-sridhar.samudrala@intel.com>
 <1490833375-2788-3-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040A9E1@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Wednesday, March 29, 2017 5:23 PM
> To: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; Duyck,
> Alexander H <alexander.h.duyck@intel.com>; Singhai, Anjali
> <anjali.singhai@intel.com>; jakub.kicinski at netronome.com;
> gerlitz.or at gmail.com; jiri at resnulli.us; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>
> Subject: [Intel-wired-lan] [next-queue v6 PATCH 2/7] i40e: Introduce Port
> Representor netdevs and switchdev mode.
> 
> Port Representator netdevs are created for each PF and VF if the switch
> mode is set to 'switchdev'. These netdevs can be used to control and
> configure VFs and PFs when they are moved to a different namespace.
> They enable exposing statistics, configure and monitor link state, mtu,
> filters,fdb/vlan entries etc.
> 
> Sample script to create port representors # rmmod i40e; modprobe i40e #
> devlink dev eswitch set pci/0000:42:00.0 mode switchdev # echo 2 >
> /sys/class/net/p4p1/device/sriov_numvfs
> # ip l show
> 122: p4p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> mode DEFAULT qlen 1000
>     link/ether 3c:fd:fe:a3:18:f8 brd ff:ff:ff:ff:ff:ff
>     vf 0 MAC 00:00:00:00:00:00, spoof checking on, link-state auto, trust off
>     vf 1 MAC 00:00:00:00:00:00, spoof checking on, link-state auto, trust off
> 124: p4p1-pf: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> mode DEFAULT qlen 1000
>     link/ether 72:8e:34:b2:d0:44 brd ff:ff:ff:ff:ff:ff
> 125: p4p1-vf0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> mode DEFAULT qlen 1000
>     link/ether 02:57:a0:18:2b:ce brd ff:ff:ff:ff:ff:ff
> 126: p4p1-vf1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> mode DEFAULT qlen 1000
>     link/ether 32:7c:77:5f:3e:e3 brd ff:ff:ff:ff:ff:ff
> 127: p4p1_0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> mode DEFAULT qlen 1000
>     link/ether 26:51:28:54:69:43 brd ff:ff:ff:ff:ff:ff
> 128: p4p1_1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> mode DEFAULT qlen 1000
> 
> p4p1 is the PF. p4p1-pf is the port netdev for PF.
> p4p1_0, p4p1_1 are VFs and p4p1-vf0, p4p1-vf1 are the port netdev's for the
> 2 VFs.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |  19 +++
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 187
> ++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   9 +
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   6 +
>  4 files changed, 220 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


