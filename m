From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Jan 2017 21:35:27 +0000
Subject: [Intel-wired-lan] [next-queue v5 PATCH 7/7] i40e: Add support
 to	get switch id and port number for VFPR netdevs
In-Reply-To: <1485392057-3261-8-git-send-email-sridhar.samudrala@intel.com>
References: <1485392057-3261-1-git-send-email-sridhar.samudrala@intel.com>
 <1485392057-3261-8-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D4E6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Wednesday, January 25, 2017 4:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v5 PATCH 7/7] i40e: Add support to
> get switch id and port number for VFPR netdevs
> 
> Introduce switchdev_ops to PF and VFPR netdevs to return the switch id via
> SWITCHDEV_ATTR_ID_PORT_PARENT_ID attribute.
> Also, ndo_get_phys_port_name() support is added to VFPR netdevs to
> return the port number.
> 
> PF: enp5s0f0, VFs: enp5s2,enp5s2f1 VFPRs:enp5s0f0-vf0, enp5s0f0-vf1 #
> rmmod i40e; modprobe i40e # devlink dev eswitch set pci/0000:05:00.0 mode
> switchdev # echo 2 > /sys/class/net/enp5s0f0/device/sriov_numvfs
> # ip -d l show enp5s0f0
> 32: enp5s0f0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> mode DEFAULT group default qlen 1000
>     link/ether 68:05:ca:2e:72:68 brd ff:ff:ff:ff:ff:ff promiscuity 0 addrgenmode
> eui64 numtxqueues 72 numrxqueues 72 gso_max_size 65536 gso_max_segs
> 65535 portid 6805ca2e7268 switchid 6805ca2e7268
>     vf 0 MAC 00:00:00:00:00:00, spoof checking on, link-state disable, trust off
>     vf 1 MAC 00:00:00:00:00:00, spoof checking on, link-state disable, trust off #
> ip -d l show enp5s0f0-vf0
> 34: enp5s0f0-vf0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state
> DOWN mode DEFAULT group default qlen 1000
>     link/ether 68:05:ca:2e:72:68 brd ff:ff:ff:ff:ff:ff promiscuity 0 addrgenmode
> eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs
> 65535 portname 0 switchid 6805ca2e7268 # ip -d l show enp5s0f0-vf1
> 35: enp5s0f0-vf1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state
> DOWN mode DEFAULT group default qlen 1000
>     link/ether 68:05:ca:2e:72:68 brd ff:ff:ff:ff:ff:ff promiscuity 0 addrgenmode
> eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs
> 65535 portname 1 switchid 6805ca2e7268
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Anjali Singhai <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 28 +++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 40
> ++++++++++++++++++++++
>  3 files changed, 69 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


