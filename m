From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 24 Jan 2017 18:48:09 +0000
Subject: [Intel-wired-lan] [next-queue v4 PATCH 2/7] i40e: Introduce VF
 Port	Representator(VFPR) netdevs.
In-Reply-To: <1484260510-9162-3-git-send-email-sridhar.samudrala@intel.com>
References: <1484260510-9162-1-git-send-email-sridhar.samudrala@intel.com>
 <1484260510-9162-3-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5BE95@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next-queue v4 PATCH 2/7] i40e: Introduce VF Port
> Representator(VFPR) netdevs.
> 
> VF Port Representator netdevs are created for each VF if the switch mode is
> set to 'switchdev'. These netdevs can be used to control and configure VFs
> from PFs namespace. They enable exposing VF statistics, configure and
> monitor link state, mtu, filters, fdb/vlan entries etc. of VFs.
> Broadcast filters are not enabled in switchdev mode.
> VFPR netdevs inherit the mac address from the PF.
> 
> Sample script to create VF port representors # rmmod i40e; modprobe i40e #
> devlink dev eswitch set pci/0000:05:00.0 mode switchdev # echo 2 >
> /sys/class/net/enp5s0f0/device/sriov_numvfs
> # ip l show
> 297: enp5s0f0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop portid
> 6805ca2e7268 state DOWN mode DEFAULT group default qlen 1000
>      link/ether 68:05:ca:2e:72:68 brd ff:ff:ff:ff:ff:ff
>      vf 0 MAC 00:00:00:00:00:00, spoof checking on, link-state auto, trust off
>      vf 1 MAC 00:00:00:00:00:00, spoof checking on, link-state auto, trust off
> 299: enp5s0f0-vf0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state
> DOWN mode DEFAULT group default qlen 1000
>      link/ether 68:05:ca:2e:72:68 brd ff:ff:ff:ff:ff:ff
> 300: enp5s0f0-vf1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state
> DOWN mode DEFAULT group default qlen 1000
>      link/ether 68:05:ca:2e:72:68 brd ff:ff:ff:ff:ff:ff
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |  21 ++-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 153
> ++++++++++++++++++++-
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  14 ++
>  3 files changed, 182 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


