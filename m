From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Sep 2016 18:50:10 +0000
Subject: [Intel-wired-lan] [dev-queue PATCH v2] i40evf: Fix link state
 event	handling.
In-Reply-To: <1472761647-2595-1-git-send-email-sridhar.samudrala@intel.com>
References: <1472761647-2595-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FC5C3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Thursday, September 01, 2016 1:27 PM
> To: intel-wired-lan at lists.osuosl.org; Fastabend, John R
> <john.r.fastabend@intel.com>; Singhai, Anjali <anjali.singhai@intel.com>
> Subject: [Intel-wired-lan] [dev-queue PATCH v2] i40evf: Fix link state event
> handling.
> 
> Currently disabling the link state from PF via
> 	ip link set enp5s0f0 vf 0 state disable doesn't disable the CARRIER on
> the VF.
> 
> This patch updates the carrier and starts/stops the tx queues based on the
> link state notification from PF.
> 
>   PF: enp5s0f0, VF: enp5s2
>   #modprobe i40e
>   #echo 2 > /sys/class/net/enp5s0f0/device/sriov_numvfs
>   #ip link set enp5s2 up
>   #ip -d link show enp5s2
>   175: enp5s2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq
> state UP mode DEFAULT group default qlen 1000
>       link/ether ea:4d:60:bc:6f:85 brd ff:ff:ff:ff:ff:ff promiscuity 0 addrgenmode
> eui64
>   #ip link set enp5s0f0 vf 0 state disable
>   #ip -d link show enp5s0f0
>   171: enp5s0f0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> mode DEFAULT group default qlen 1000
>       link/ether 68:05:ca:2e:72:68 brd ff:ff:ff:ff:ff:ff promiscuity 0 addrgenmode
> eui64 numtxqueues 72 numrxqueues 72 portid 6805ca2e7268
>       vf 0 MAC 00:00:00:00:00:00, spoof checking on, link-state disable, trust off
>       vf 1 MAC 00:00:00:00:00:00, spoof checking on, link-state auto, trust off
>   #ip -d link show enp5s2
>   175: enp5s2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq
> state DOWN mode DEFAULT group default qlen 1000
>        link/ether ea:4d:60:bc:6f:85 brd ff:ff:ff:ff:ff:ff promiscuity 0 addrgenmode
> eui64 numtxqueues 16 numrxqueues 16
> 
> v2:
> Update adapter->link_up when carrier is turned off.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c     |  4 ++++
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 10 +++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Functions as described


