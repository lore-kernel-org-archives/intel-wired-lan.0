From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Apr 2016 18:43:39 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/2] ixgbe: Add support for
 redirect action to cls_u32 offloads.
In-Reply-To: <570400D5.7020302@intel.com>
References: <1459877947-8241-1-git-send-email-sridhar.samudrala@intel.com>
 <1459877947-8241-2-git-send-email-sridhar.samudrala@intel.com>
 <570400D5.7020302@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9CF41A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Samudrala, Sridhar
> Sent: Tuesday, April 05, 2016 11:16 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; Fastabend, John R
> <john.r.fastabend@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH net-next 2/2] ixgbe: Add support for
> redirect action to cls_u32 offloads.
> 
> 
> 
> On 4/5/2016 10:39 AM, Sridhar Samudrala wrote:
> > From: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >
> > This patch enables 'redirect' to a SRIOV VF or a offloaded macvlan
> > device queue via tc 'mirred' action.
> Jeff,
> This patch has a dependency on this patch
> https://git.kernel.org/cgit/linux/kernel/git/jkirsher/next-
> queue.git/commit/?h=dev-
> queue&id=aff19cd6dd891364ba440ee0e02fe8a83a110f7c
> which is in your dev_queue branch.
> 
> Thanks
> Sridhar
> >
> > Verified with the following script that creates SRIOV VFs,  offloaded
> > macvlan and adds tc u32 filters with redirect action to the associated
> > netdevs.
> >
> >   # add ingress qdisc.
> >   tc qdisc add dev p4p1 ingress
> >
> >   # enable hw tc offload.
> >   ethtool -K p4p1 hw-tc-offload on
> >
> >   # create 4 sriov VFs and bring up the first one.
> >   echo 4 > /sys/class/net/p4p1/device/sriov_numvfs
> >   sleep 1
> >   ip link set p4p1 up
> >   ip link set p4p1_0 up
> >
> >   # create a offloaded macvlan device and bring it up.
> >   ethtool -K p4p1 l2-fwd-offload on
> >   ip link add link p4p1 name mvlan_1 type macvlan
> >   ip link set mvlan_1 up
> >
> >   # add u32 filter with action to redirect to VF netdev
> >   tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
> >      handle 800:0:1 u32 ht 800: \
> >      match ip src 192.168.1.3/32 \
> >      action mirred egress redirect dev p4p1_0
> >
> >   # add u32 filter with action to redirect to macvlan netdev
> >   tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
> >      handle 800:0:2 u32 ht 800: \
> >      match ip src 192.168.2.3/32 \
> >      action mirred egress redirect dev mvlan_1
> >
> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > ---
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 96
> +++++++++++++++++++++++----
> >   1 file changed, 83 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Filters added successfully
