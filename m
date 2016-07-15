From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 15 Jul 2016 23:26:08 +0000
Subject: [Intel-wired-lan] [net-next v6 3/4] igb: support RX flow
 classification by VLAN priority
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F30D06@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Gangfeng
> Sent: Tuesday, July 5, 2016 10:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Gangfeng Huang <gangfeng.huang@ni.com>; Ruhao Gao
> <ruhao.gao@ni.com>
> Subject: [Intel-wired-lan] [net-next v6 3/4] igb: support RX flow classification
> by VLAN priority
> 
> From: Gangfeng Huang <gangfeng.huang@ni.com>
> 
> This patch is meant to allow for RX network flow classification to insert
> and remove VLAN priority filter by ethtool
> 
> Example:
> Add an VLAN priority filter:
> $ ethtool -N eth0 flow-type ether vlan 0x6000 vlan-mask 0x1FFF action 2 loc 1
> 
> Show all filters:
> $ ethtool -n eth0
> 4 RX rings available
> Total 1 rules
> 
> Filter: 1
> 	Flow Type: Raw Ethernet
> 	Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> 	Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> 	Ethertype: 0x0 mask: 0xFFFF
> 	VLAN EtherType: 0x0 mask: 0xffff
> 	VLAN: 0x6000 mask: 0x1fff
> 	User-defined: 0x0 mask: 0xffffffffffffffff
> 	Action: Direct to queue 2
> 
> Delete the filter by location:
> $ ethtool -N delete 1
> 
> Signed-off-by: Ruhao Gao <ruhao.gao@ni.com>
> Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_defines.h |  4 ++
>  drivers/net/ethernet/intel/igb/e1000_regs.h    |  1 +
>  drivers/net/ethernet/intel/igb/igb.h           |  3 +
>  drivers/net/ethernet/intel/igb/igb_ethtool.c   | 91
> ++++++++++++++++++++++++--
>  4 files changed, 92 insertions(+), 7 deletions(-)
>

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
