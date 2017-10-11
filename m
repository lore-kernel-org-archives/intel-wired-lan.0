From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 11 Oct 2017 08:42:20 -0400
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v4 0/6] tc-flower
 based cloud filters in i40e
In-Reply-To: <150768099999.5320.1633617713417675266.stgit@anamdev.jf.intel.com>
References: <150768099999.5320.1633617713417675266.stgit@anamdev.jf.intel.com>
Message-ID: <f85aa039-cf16-a25a-5b60-1af747b44f62@mojatatu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 17-10-10 08:24 PM, Amritha Nambiar wrote:
> This patch series enables configuring cloud filters in i40e
> using the tc-flower classifier. The classification function
> of the filter is to match a packet to a class. cls_flower is
> extended to offload classid to hardware. The offloaded classid
> is used direct matched packets to a traffic class on the device.
> The approach here is similar to the tc 'prio' qdisc which uses
> the classid for band selection. The ingress qdisc is called ffff:0,
> so traffic classes are ffff:1 to ffff:8 (i40e has max of 8 TCs).
> TC0 is minor number 1, TC1 is minor number 2 etc.
> 
> The cloud filters are added for a VSI and are cleaned up when
> the VSI is deleted. The filters that match on L4 ports needs
> enhanced admin queue functions with big buffer support for
> extended fields in cloud filter commands.
> 
> Example:
> # tc qdisc add dev eth0 ingress
> # ethtool -K eth0 hw-tc-offload on
> 
> Match Dst IPv4,Dst Port and route to TC1:
> # tc filter add dev eth0 protocol ip parent ffff: prio 1 flower\
>    dst_ip 192.168.1.1/32 ip_proto udp dst_port 22\
>    skip_sw classid ffff:2
> 
> # tc filter show dev eth0 parent ffff:
> filter pref 1 flower chain 0
> filter pref 1 flower chain 0 handle 0x1 classid ffff:2
>    eth_type ipv4
>    ip_proto udp
>    dst_ip 192.168.1.1
>    dst_port 22
>    skip_sw
>    in_hw
> 

Much much better semantic. Thank you.
Have you tested many filter mapping to the same classid?

cheers,
jamal
