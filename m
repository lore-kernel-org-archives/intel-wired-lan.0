From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 15 Jul 2016 23:24:50 +0000
Subject: [Intel-wired-lan] [net-next v6 1/4] igb: add support of RX
 network flow classification
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F30CDB@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [net-next v6 1/4] igb: add support of RX network
> flow classification
> 
> From: Gangfeng Huang <gangfeng.huang@ni.com>
> 
> This patch is meant to allow for RX network flow classification to insert
> and remove Rx filter by ethtool. Ethtool interface has it's own rules
> manager
> 
> Show all filters:
> $ ethtool -n eth0
> 4 RX rings available
> Total 2 rules
> 
> Signed-off-by: Ruhao Gao <ruhao.gao@ni.com>
> Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         |  32 +++++
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 193
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igb/igb_main.c    |  45 +++++++
>  3 files changed, 270 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
