From: Gangfeng Huang <gangfeng.huang@ni.com>
Date: Tue, 12 Jan 2016 08:32:32 +0000
Subject: [Intel-wired-lan] [PATCH next-queue 1/3] igb: Enable the
	ethtool	interface fo Rx filter
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81E4D36B@ORSMSX101.amr.corp.intel.com>
References: <1451456399-13353-1-git-send-email-gangfeng.huang@ni.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81E4D36B@ORSMSX101.amr.corp.intel.com>
Message-ID: <DM2PR0401MB09907A74230900BB8820D802ECCA0@DM2PR0401MB0990.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

About these patches, I only do the test on I210 because I do not have other adapters in this series, 

-----Original Message-----
From: Brown, Aaron F [mailto:aaron.f.brown at intel.com] 
Sent: 2016?1?12? 10:08
To: Gangfeng Huang <gangfeng.huang@ni.com>; intel-wired-lan at lists.osuosl.org
Cc: Ruhao Gao <ruhao.gao@ni.com>
Subject: RE: [Intel-wired-lan] [PATCH next-queue 1/3] igb: Enable the ethtool interface fo Rx filter

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on 
> behalf of Gangfeng [gangfeng.huang at ni.com]
> Sent: Tuesday, December 29, 2015 10:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Gangfeng Huang; Ruhao Gao
> Subject: [Intel-wired-lan] [PATCH next-queue 1/3] igb: Enable the ethtool       interface fo Rx filter
> 
> From: Gangfeng Huang <gangfeng.huang@ni.com>
> 
> This patch is meant to allow for nfc to insert and remove Rx filter by 
> ethtool. Ethtool interface has it's own rules manager
> 
> Show all filters:
> $ ethtool -n eth0
> 4 RX rings available
> Total 2 rules
> 
> Signed-off-by: Ruhao Gao <ruhao.gao@ni.com>
> Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         |   31 +++++
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |  193 ++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igb/igb_main.c    |   55 ++++++++
>  3 files changed, 279 insertions(+)

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on 
> behalf of Gangfeng [gangfeng.huang at ni.com]
> Sent: Tuesday, December 29, 2015 10:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Gangfeng Huang; Ruhao Gao
> Subject: [Intel-wired-lan] [PATCH next-queue 1/3] igb: Enable the ethtool       interface fo Rx filter
> 
> From: Gangfeng Huang <gangfeng.huang@ni.com>
> 
> This patch is meant to allow for nfc to insert and remove Rx filter by 
> ethtool. Ethtool interface has it's own rules manager
> 
> Show all filters:
> $ ethtool -n eth0
> 4 RX rings available
> Total 2 rules
> 
> Signed-off-by: Ruhao Gao <ruhao.gao@ni.com>
> Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         |   31 +++++
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |  193 ++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igb/igb_main.c    |   55 ++++++++
>  3 files changed, 279 insertions(+)

This series seems to be fine for i210 and i350, but all the other parts I have tried fail to insert a rule with either an "Invalid argument" message, for i211,  or "Unknown error 524".  The message is the same whether I try to apply an ethertype RX filter or a VLAN priority filter, my examples here are just using the ethertype filter.

For the i210:
u1458:[0]/root> ethtool -N eth1 flow-type ether proto 0x88F8 action 2
rmgr: Cannot insert RX class rule: Invalid argument u1458:[0]/root>

For an 82575EB, 82576, 82580 and i354:
u1458:[0]/root> ethtool -N eth3 flow-type ether proto 0x88F8 action 2
rmgr: Cannot insert RX class rule: Unknown error 524 u1458:[0]/root>

In all cases the pre-patch behaviour was:
u1485:[0]/root> ethtool -N eth3 flow-type ether proto 0x88F8 action 2
rxclass: Cannot get RX class rule count: Operation not supported Cannot insert classification rule u1485:[0]/root>
