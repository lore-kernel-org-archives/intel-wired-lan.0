From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Mar 2017 21:09:10 +0000
Subject: [Intel-wired-lan] [next-queue v6 PATCH 7/7] i40e: Add support
 to	get switch id and port number for port netdevs
In-Reply-To: <1490833375-2788-8-git-send-email-sridhar.samudrala@intel.com>
References: <1490833375-2788-1-git-send-email-sridhar.samudrala@intel.com>
 <1490833375-2788-8-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040AA3E@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next-queue v6 PATCH 7/7] i40e: Add support to
> get switch id and port number for port netdevs
> 
> Introduce switchdev_ops to PF and port netdevs to return the switch id via
> SWITCHDEV_ATTR_ID_PORT_PARENT_ID attribute.
> Also, ndo_get_phys_port_name() support is added to port netdevs to return
> the port number.
> 
> PF: p4p1, VFs: p4p1_0,p4p1_1, VF port reps:p4p1-vf0, p4p1-vf1, PF port rep:
> p4p1-pf # rmmod i40e; modprobe i40e # devlink dev eswitch set
> pci/0000:42:00.0 mode switchdev # echo 2 >
> /sys/class/net/enp5s0f0/device/sriov_numvfs
> # ip -d l show p4p1
> 27: p4p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
> DEFAULT group default qlen 1000
>     link/ether 3c:fd:fe:a3:18:f8 brd ff:ff:ff:ff:ff:ff promiscuity 0 numtxqueues
> 64 numrxqueues 64 gso_max_size 65536 gso_max_segs 65535 portid
> 3cfdfea318f8 switchid 3cfdfea318f8
>     vf 0 MAC 00:00:00:00:00:00, spoof checking on, link-state disable, trust off
>     vf 1 MAC 00:00:00:00:00:00, spoof checking on, link-state disable, trust off #
> ip -d l show p4p1-pf
> 29: p4p1-pf: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> mode DEFAULT group default qlen 1000
>     link/ether 42:7a:b5:dc:85:11 brd ff:ff:ff:ff:ff:ff promiscuity 0 numtxqueues
> 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 portname 65535
> switchid 3cfdfea318f8 # ip -d l show p4p1-vf0
> 30: p4p1-vf0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> mode DEFAULT group default qlen 1000
>     link/ether 6e:ff:0b:5a:63:6d brd ff:ff:ff:ff:ff:ff promiscuity 0 numtxqueues 1
> numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 portname 0
> switchid 3cfdfea318f8 # ip -d l show p4p1-vf1
> 31: p4p1-vf1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> mode DEFAULT group default qlen 1000
>     link/ether 92:6e:ff:35:05:d5 brd ff:ff:ff:ff:ff:ff promiscuity 0 numtxqueues 1
> numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 portname 1
> switchid 3cfdfea318f8
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 97
> +++++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


