From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Jan 2017 21:34:07 +0000
Subject: [Intel-wired-lan] [next-queue v5 PATCH 3/7] i40e: Sync link
 state	between VFs and VFPRs
In-Reply-To: <1485392057-3261-4-git-send-email-sridhar.samudrala@intel.com>
References: <1485392057-3261-1-git-send-email-sridhar.samudrala@intel.com>
 <1485392057-3261-4-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D4BB@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next-queue v5 PATCH 3/7] i40e: Sync link state
> between VFs and VFPRs
> 
> This patch enables
> - reflecting the link state of VFPR based on VF admin state & link state
>   of VF based on admin state of VFPR.
> - bringing up/down the VFPR sends a notification to update VF link state.
> - bringing up/down the VF will cause the link state update of VFPR.
> - enable/disable VF link state via ndo_set_vf_link_state will update the
>   admin state of associated VFPR.
> 
> PF: enp5s0f0, VFs: enp5s2,enp5s2f1 VFPRs:enp5s0f0-vf0, enp5s0f0-vf1 #
> rmmod i40e; modprobe i40e # devlink dev eswitch set pci/0000:05:00.0 mode
> switchdev # echo 2 > /sys/class/net/enp5s0f0/device/sriov_numvfs
> 
> # ip link set enp5s2 up
> # ip link set enp5s0f0-vf0 up
> # ip link set enp5s0f0-vf1 up
> 
> /* enp5s2 UP -> enp5s0f0-vf0 CARRIER ON */ # ip link show enp5s0f0-vf0
> 215: enp5s0f0-vf0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
> fq_codel state UP mode DEFAULT group default qlen 1000
>      link/ether 68:05:ca:2e:72:68 brd ff:ff:ff:ff:ff:ff
> 
> /* enp5s0f0-vf0 UP -> enp5s2 CARRIER ON */ # ip link show enp5s2
> 218: enp5s2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq
> state UP mode DEFAULT group default qlen 1000
>      link/ether ea:4d:60:bc:6f:85 brd ff:ff:ff:ff:ff:ff
> 
> /* enp5s2f1 DOWN -> enp5s0f0-vf1 NO-CARRIER */ # ip link show enp5s0f0-
> vf1
> 216: enp5s0f0-vf1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500
> qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
>      link/ether 68:05:ca:2e:72:68 brd ff:ff:ff:ff:ff:ff
> 
> # ip link set enp5s0f0-vf0 down
> # ip link set enp5s2f1 up
> 
> /* enp5s0-vf0 DOWN -> enp5s2 NO_CARRIER */ # ip link show enp5s2
> 218: enp5s2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq
> state DOWN mode DEFAULT group default qlen 1000
>      link/ether ea:4d:60:bc:6f:85 brd ff:ff:ff:ff:ff:ff
> 
> # ip -d link show enp5s0f0
> 213: enp5s0f0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop portid
> 6805ca27268 state DOWN mode DEFAULT group default qlen 1000
>      link/ether 68:05:ca:2e:72:68 brd ff:ff:ff:ff:ff:ff promiscuity 0 addrgenmode
> eui64
>      vf 0 MAC 00:00:00:00:00:00, spoof checking on, link-state disable, trust off
>      vf 1 MAC 00:00:00:00:00:00, spoof checking on, link-state enable, trust off
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Anjali Singhai <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 44
> ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


