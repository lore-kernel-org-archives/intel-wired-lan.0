From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 24 Jan 2017 19:28:09 +0000
Subject: [Intel-wired-lan] [next-queue v4 PATCH 5/7] i40e: Add TX and
	RX	support in switchdev mode.
In-Reply-To: <1484260510-9162-6-git-send-email-sridhar.samudrala@intel.com>
References: <1484260510-9162-1-git-send-email-sridhar.samudrala@intel.com>
 <1484260510-9162-6-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5BF05@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Thursday, January 12, 2017 2:35 PM
> To: Duyck, Alexander H <alexander.h.duyck@intel.com>; Fastabend, John R
> <john.r.fastabend@intel.com>; Singhai, Anjali <anjali.singhai@intel.com>;
> jakub.kicinski at netronome.com; davem at davemloft.net; Peterson, Scott D
> <scott.d.peterson@intel.com>; gerlitz.or at gmail.com; jiri at resnulli.us; intel-
> wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [next-queue v4 PATCH 5/7] i40e: Add TX and RX
> support in switchdev mode.
> 
> In switchdev mode, broadcast filter is not enabled on VFs. The broadcasts
> and unknown frames from VFs are received by the PF and passed to
> corresponding VF port representator netdev.
> A host based switching entity like a linux bridge or OVS redirects these
> frames to the right VFs via VFPR netdevs. Any frames sent via VFPR netdevs
> are sent as directed transmits to the corresponding VFs. To enable directed
> transmit, skb metadata dst is used to pass the VF id and the frame is
> requeued to call the PFs transmit routine.
> 
> Small script to demonstrate inter VF pings in switchdev mode.
> PF: enp5s0f0, VFs: enp5s2,enp5s2f1 VFPRs:enp5s0f0-vf0, enp5s0f0-vf1
> 
> # rmmod i40e; modprobe i40e
> # devlink dev eswitch set pci/0000:05:00.0 mode switchdev # echo 2 >
> /sys/class/net/enp5s0f0/device/sriov_numvfs
> # ip link set enp5s0f0 vf 0 mac 00:11:22:33:44:55 # ip link set enp5s0f0 vf 1 mac
> 00:11:22:33:44:56 # rmmod i40evf; modprobe i40evf
> 
> /* Create 2 namespaces and move the VFs to the corresponding ns. */ # ip
> netns add ns0 # ip link set enp5s2 netns ns0 # ip netns exec ns0 ip addr add
> 192.168.1.10/24 dev enp5s2 # ip netns exec ns0 ip link set enp5s2 up # ip
> netns add ns1 # ip link set enp5s2f1 netns ns1 # ip netns exec ns1 ip addr add
> 192.168.1.11/24 dev enp5s2f1 # ip netns exec ns1 ip link set enp5s2f1 up
> 
> /* bring up pf and vfpr netdevs */
> # ip link set enp5s0f0 up
> # ip link set enp5s0f0-vf0 up
> # ip link set enp5s0f0-vf1 up
> 
> /* Create a linux bridge and add vfpr netdevs to it. */ # ip link add vfpr-br
> type bridge # ip link set enp5s0f0-vf0 master vfpr-br # ip link set enp5s0f0-vf1
> master vfpr-br # ip addr add 192.168.1.1/24 dev vfpr-br # ip link set vfpr-br up
> 
> # ip netns exec ns0 ping -c3 192.168.1.11 # ip netns exec ns1 ping -c3
> 192.168.1.10
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |   1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |   4 +
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 106
> ++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   2 +
>  drivers/net/ethernet/intel/i40e/i40e_type.h        |   3 +
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  17 +++-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   1 +
>  7 files changed, 127 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


