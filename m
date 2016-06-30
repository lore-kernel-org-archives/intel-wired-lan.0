From: 'Matt Porter' <mporter@konsulko.com>
Date: Thu, 30 Jun 2016 12:16:28 -0400
Subject: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add support of
 RX network flow classification
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81F27012@ORSMSX101.amr.corp.intel.com>
References: <1462786062-7572-1-git-send-email-gangfeng.huang@ni.com>
 <1462786062-7572-2-git-send-email-gangfeng.huang@ni.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81EFDB5D@ORSMSX101.amr.corp.intel.com>
 <20160629191232.GA29990@beef>
 <309B89C4C689E141A5FF6A0C5FB2118B81F26C2D@ORSMSX101.amr.corp.intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81F27012@ORSMSX101.amr.corp.intel.com>
Message-ID: <20160630161628.GB29670@beef>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jun 30, 2016 at 01:20:44AM +0000, Brown, Aaron F wrote:
> > From: Brown, Aaron F
> > Sent: Wednesday, June 29, 2016 1:06 PM
> > To: Matt Porter <mporter@konsulko.com>
> > Cc: Gangfeng <gangfeng.huang@ni.com>; intel-wired-lan at lists.osuosl.org;
> > Ruhao Gao <ruhao.gao@ni.com>
> > Subject: RE: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add support of RX
> > network flow classification
> > 
> > > From: Matt Porter [mailto:mporter at konsulko.com]
> > > Sent: Wednesday, June 29, 2016 12:13 PM
> > > To: Brown, Aaron F <aaron.f.brown@intel.com>
> > > Cc: Gangfeng <gangfeng.huang@ni.com>; intel-wired-lan at lists.osuosl.org;
> > > Ruhao Gao <ruhao.gao@ni.com>
> > > Subject: Re: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add support of
> > RX
> > > network flow classification
> > >
> > > On Mon, May 16, 2016 at 10:09:04PM +0000, Brown, Aaron F wrote:
> > > > > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org]
> > > On
> > > > > Behalf Of Gangfeng
> > > > > Sent: Monday, May 9, 2016 2:28 AM
> > > > > To: intel-wired-lan at lists.osuosl.org
> > > > > Cc: Gangfeng Huang <gangfeng.huang@ni.com>; Ruhao Gao
> > > > > <ruhao.gao@ni.com>
> > > > > Subject: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add support of RX
> > > > > network flow classification
> > > > >
> > > > > From: Gangfeng Huang <gangfeng.huang@ni.com>
> > > > >
> > > > > This patch is meant to allow for RX network flow classification to insert
> > > > > and remove Rx filter by ethtool. Ethtool interface has it's own rules
> > > > > manager
> > > > >
> > > > > Show all filters:
> > > > > $ ethtool -n eth0
> > > > > 4 RX rings available
> > > > > Total 2 rules
> > > > >
> > > > > Signed-off-by: Ruhao Gao <ruhao.gao@ni.com>
> > > > > Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
> > > > > ---
> > > > >  drivers/net/ethernet/intel/igb/igb.h         |  32 +++++
> > > > >  drivers/net/ethernet/intel/igb/igb_ethtool.c | 193
> > > > > +++++++++++++++++++++++++++
> > > > >  drivers/net/ethernet/intel/igb/igb_main.c    |  44 ++++++
> > > > >  3 files changed, 269 insertions(+)
> > > >
> > > > This patch is causing 3/4 of my regression systems to fail.  Driver load
> > > seems normal, but applying an IP address via ifconfig causes the following
> > > splat in dmesg and /var/log/messages:
> > >
> > > Hi Aaron,
> > >
> > > I'm looking at this series on current net-next and am wondering if you
> > > saw this issue with just patch 1 applied or you meant the entire series?
> > 
> > Hi Matt,
> > 
> > My recollection is that I saw it with just patch 1 applied.  And my procedure
> > when I see an issue with a series is to try and isolate it to the individual patch
> > and reply to the one in the series that triggers the issue, so I am pretty sure it
> > was with this patch applied and the rest of the series not applied.
> 
> I was able to apply this (v5 1/4) patch to a recent version of Jeff's next-queue / dev-branch (with a little fuzz) and reproduce the problem on one of the systems that was previously triggering it without any difficulty.  It does occur with just this one patch applied.  This was with the system that has an i211 and a pair of 82580 ports.  I will still try to sort out if it happens with just i211 or the pair of 82580s (leaning towards the i211 as a system with a pair of 82580s and an i210 worked fine) but have been searching for another i211 as the system in question is at the bottom of a rack with a bunch of systems stacked on top of it, making the card cage rather difficult to get to.

Ok, the full oops output made me notice the problem. Can you try the
following untested fix on your failing system? It'll apply against
patch 1/4 and is build tested against the next-queue dev-queue branch.

-Matt

From 8773d0f09741d7a318cdd96cf5aad2ddb79096e7 Mon Sep 17 00:00:00 2001
From: Matt Porter <mporter@konsulko.com>
Date: Thu, 30 Jun 2016 11:47:50 -0400
Subject: [PATCH] igb: Fix missing lock init in rx network flow classification
 support

"[net-next,v5,1/4] igb: add support of RX network flow classification"
adds a new nfc_lock to each adapter to protect the rx filter hash list.
This lock is not initialized before use which results in intermittent
oopses. Initialize this lock during probe to fix the issue.

Signed-off-by: Matt Porter <mporter@konsulko.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index c04b1c2..e5a4949 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3075,6 +3075,7 @@ static int igb_sw_init(struct igb_adapter *adapter)
 				  VLAN_HLEN;
 	adapter->min_frame_size = ETH_ZLEN + ETH_FCS_LEN;
 
+	spin_lock_init(&adapter->nfc_lock);
 	spin_lock_init(&adapter->stats64_lock);
 #ifdef CONFIG_PCI_IOV
 	switch (hw->mac.type) {
-- 
2.7.0

