From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 22 Dec 2015 21:59:23 -0800
Subject: [Intel-wired-lan] [PATCH 0/3] igb: Add RX ethertype filter and
 VLAN priority filter
In-Reply-To: <1450767577-21759-1-git-send-email-gangfeng.huang@ni.com>
References: <1450767577-21759-1-git-send-email-gangfeng.huang@ni.com>
Message-ID: <1450850363.3169.68.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-12-22 at 14:59 +0800, Gangfeng Huang wrote:
> Gangfeng Huang (3):
> ? igb: Enable the ethtool interface fo Rx filter
> ? igb: add support of ethertype RX filters
> ? igb: add support of Rx VLAN priority filters

Dropping this series because it does not apply cleanly to my next-queue 
tree, specifically the dev-queue branch. ?Please rebase your patch
series to my next-queue tree and dev-queue branch before re-submitting
this series.
> 
> ?drivers/net/ethernet/intel/igb/e1000_82575.h?? |??? 5 +
> ?drivers/net/ethernet/intel/igb/e1000_defines.h |??? 5 +
> ?drivers/net/ethernet/intel/igb/e1000_regs.h??? |??? 1 +
> ?drivers/net/ethernet/intel/igb/igb.h?????????? |?? 52 ++++
> ?drivers/net/ethernet/intel/igb/igb_ethtool.c?? |? 345
> ++++++++++++++++++++++++
> ?drivers/net/ethernet/intel/igb/igb_main.c????? |?? 57 ++++
> ?drivers/net/ethernet/intel/igb/igb_ptp.c?????? |??? 4 +-
> ?7 files changed, 467 insertions(+), 2 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151222/4bdc824c/attachment.asc>
