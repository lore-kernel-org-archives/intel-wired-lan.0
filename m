From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 05 Jan 2017 13:46:11 -0800
Subject: [Intel-wired-lan] [net-next PATCH v2 2/6] i40e: Introduce VF
 Port Representator(VFPR) netdevs.
In-Reply-To: <1483466874-2962-3-git-send-email-sridhar.samudrala@intel.com>
References: <1483466874-2962-1-git-send-email-sridhar.samudrala@intel.com>
 <1483466874-2962-3-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <1483652771.25700.41.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2017-01-03 at 10:07 -0800, Sridhar Samudrala wrote:
> VF Port Representator netdevs are created for each VF if the switch mode
> is set to 'switchdev'. These netdevs can be used to control and configure
> VFs from PFs namespace. They enable exposing VF statistics, configure and
> monitor link state, mtu, filters, fdb/vlan entries etc. of VFs.
> Broadcast filters are not enabled in switchdev mode.
> 
> Sample script to create VF port representors
> # rmmod i40e; modprobe i40e
> # devlink dev eswitch set pci/0000:05:00.0 mode switchdev
> # echo 2 > /sys/class/net/enp5s0f0/device/sriov_numvfs
> # ip l show
> 297: enp5s0f0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop portid
> 6805ca2e7268 state DOWN mode DEFAULT group default qlen 1000
> ???? link/ether 68:05:ca:2e:72:68 brd ff:ff:ff:ff:ff:ff
> ???? vf 0 MAC 00:00:00:00:00:00, spoof checking on, link-state auto,
> trust off
> ???? vf 1 MAC 00:00:00:00:00:00, spoof checking on, link-state auto,
> trust off
> 299: enp5s0f0-vf0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> mode DEFAULT group default qlen 1000
> ???? link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
> 300: enp5s0f0-vf1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> mode DEFAULT group default qlen 1000
> ???? link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
> ?drivers/net/ethernet/intel/i40e/i40e_main.c??????? |? 21 ++-
> ?drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 154
> ++++++++++++++++++++-
> ?drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |? 14 ++
> ?3 files changed, 182 insertions(+), 7 deletions(-)

This does not apply cleanly because it is based on an older version of
i40e_virtchnl_pf.c file.  It appears that i40e has been updated to use
"i40e_add_filter()" yet your patch still uses "i40e_add_mac_filter()".

We need to clarify what the "right way" is to add filters and use the
correct function.

Dropping this series and will await v3, please address the other feedback
from Or Gerlitz and Jiri Pirko as well in your updated series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170105/7ebb2708/attachment.asc>
