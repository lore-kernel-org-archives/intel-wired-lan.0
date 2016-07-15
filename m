From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 15 Jul 2016 23:25:29 +0000
Subject: [Intel-wired-lan] [net-next v6 2/4] igb: support RX flow
 classification by ethertype
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F30CF0@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [net-next v6 2/4] igb: support RX flow classification
> by ethertype
> 
> From: Gangfeng Huang <gangfeng.huang@ni.com>
> 
> This patch is meant to allow for RX network flow classification to insert
> and remove ethertype filter by ethtool
> 
> Example:
> Add an ethertype filter:
> $ ethtool -N eth0 flow-type ether proto 0x88F8 action 2
> 
> Show all filters:
> $ ethtool -n eth0
> 4 RX rings available
> Total 1 rules
> 
> Filter: 15
> 	Flow Type: Raw Ethernet
> 	Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> 	Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> 	Ethertype: 0x88F8 mask: 0x0
> 	Action: Direct to queue 2
> 
> Delete the filter by location:
> $ ethtool -N delete 15
> 
> Signed-off-by: Ruhao Gao <ruhao.gao@ni.com>
> Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.h |  5 ++
>  drivers/net/ethernet/intel/igb/igb.h         | 20 +++++++-
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 77
> +++++++++++++++++++++++++++-
>  drivers/net/ethernet/intel/igb/igb_ptp.c     |  4 +-
>  4 files changed, 102 insertions(+), 4 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
