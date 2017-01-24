From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 24 Jan 2017 19:32:00 +0000
Subject: [Intel-wired-lan] [next-queue v4 PATCH 6/7] i40e: Add support
 for	exposing VF port statistics via VFPR netdev on the host.
In-Reply-To: <1484260510-9162-7-git-send-email-sridhar.samudrala@intel.com>
References: <1484260510-9162-1-git-send-email-sridhar.samudrala@intel.com>
 <1484260510-9162-7-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5BF16@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next-queue v4 PATCH 6/7] i40e: Add support for
> exposing VF port statistics via VFPR netdev on the host.
> 
> From: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> By default stats counted by HW are returned via the original
> ndo_get_stats64() api. Stats counted in SW are returned via
> ndo_get_offload_stats() api.
> 
> Small script to demonstrate vfpr stats in switchdev mode.
> PF: enp5s0f0, VFs: enp5s2,enp5s2f1 VFPRs:enp5s0f0-vf0, enp5s0f0-vf1
> 
> # rmmod i40e; modprobe i40e
> # devlink dev eswitch set pci/0000:05:00.0 mode switchdev # echo 2 >
> /sys/class/net/enp5s0f0/device/sriov_numvfs
> # ip link set enp5s0f0 vf 0 mac 00:11:22:33:44:55 # ip link set enp5s0f0 vf 1 mac
> 00:11:22:33:44:56 # rmmod i40evf; modprobe i40evf
> 
> /* Create 2 namespaces and move the VFs to the corresponding ns */ # ip
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
> # ip netns exec ns0 ip -s l show enp5s2
> 56: enp5s2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq
> state UP mode DEFAULT group default qlen 1000
>     link/ether 00:11:22:33:44:55 brd ff:ff:ff:ff:ff:ff
>     RX: bytes  packets  errors  dropped overrun mcast
>     1468       18       0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     1398       17       0       0       0       0
> # ip -s l show enp5s0f0-vf0
> 52: enp5s0f0-vf0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
> fq_codel master vfpr-br state UP mode DEFAULT group default qlen 1000
>     link/ether 68:05:ca:2e:72:68 brd ff:ff:ff:ff:ff:ff
>     RX: bytes  packets  errors  dropped overrun mcast
>     1398       17       0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     1468       18       0       0       0       0
> # ip netns exec ns1 ip -s l show enp5s2f1
> 57: enp5s2f1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq
> state UP mode DEFAULT group default qlen 1000
>     link/ether 00:11:22:33:44:56 brd ff:ff:ff:ff:ff:ff
>     RX: bytes  packets  errors  dropped overrun mcast
>     1486       18       0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     1538       19       0       0       0       0
> # ip -s l show enp5s0f0-vf1
> 53: enp5s0f0-vf1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
> fq_codel master vfpr-br state UP mode DEFAULT group default qlen 1000
>     link/ether 68:05:ca:2e:72:68 brd ff:ff:ff:ff:ff:ff
>     RX: bytes  packets  errors  dropped overrun mcast
>     1538       19       0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     1486       18       0       0       0       0
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  44 ++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 108
> +++++++++++++++++++++
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  10 ++
>  3 files changed, 160 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


