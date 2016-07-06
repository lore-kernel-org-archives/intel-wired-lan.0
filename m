From: 'Matt Porter' <mporter@konsulko.com>
Date: Wed, 6 Jul 2016 08:29:11 -0400
Subject: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add support of
 RX network flow classification
In-Reply-To: <CY1PR04MB22667E5A6AF951CC05BF9DB7EC3A0@CY1PR04MB2266.namprd04.prod.outlook.com>
References: <1462786062-7572-1-git-send-email-gangfeng.huang@ni.com>
 <1462786062-7572-2-git-send-email-gangfeng.huang@ni.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81EFDB5D@ORSMSX101.amr.corp.intel.com>
 <20160629191232.GA29990@beef>
 <309B89C4C689E141A5FF6A0C5FB2118B81F26C2D@ORSMSX101.amr.corp.intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81F27012@ORSMSX101.amr.corp.intel.com>
 <20160630161628.GB29670@beef>
 <309B89C4C689E141A5FF6A0C5FB2118B81F274D9@ORSMSX101.amr.corp.intel.com>
 <20160630201043.GA1724@beef>
 <CY1PR04MB22667E5A6AF951CC05BF9DB7EC3A0@CY1PR04MB2266.namprd04.prod.outlook.com>
Message-ID: <20160706122911.GA21676@beef>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jul 06, 2016 at 08:28:46AM +0000, Gangfeng Huang wrote:
> Hi matt,
> 
> I have add your fix to the v6 patches and resubmit them, please help to test it.

Ok, thanks. I'll retest with v6 and reply back to that thread. I hope
you are feeling better.

-Matt

> -----Original Message-----
> From: 'Matt Porter' [mailto:mporter at konsulko.com] 
> Sent: 2016?7?1? 4:11
> To: Brown, Aaron F <aaron.f.brown@intel.com>
> Cc: Gangfeng Huang <gangfeng.huang@ni.com>; 'intel-wired-lan at lists.osuosl.org' <intel-wired-lan@lists.osuosl.org>; Ruhao Gao <ruhao.gao@ni.com>
> Subject: Re: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add support of RX network flow classification
> 
> On Thu, Jun 30, 2016 at 07:51:01PM +0000, Brown, Aaron F wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: 'Matt Porter' [mailto:mporter at konsulko.com]
> > > Sent: Thursday, June 30, 2016 9:16 AM
> > > To: Brown, Aaron F <aaron.f.brown@intel.com>
> > > Cc: 'Gangfeng' <gangfeng.huang@ni.com>; 'intel-wired-lan at lists.osuosl.org'
> > > <intel-wired-lan@lists.osuosl.org>; 'Ruhao Gao' <ruhao.gao@ni.com>
> > > Subject: Re: [Intel-wired-lan] [PATCH net-next v5 1/4] igb: add 
> > > support of RX network flow classification
> > >
> > <snip>
> > > 
> > > Ok, the full oops output made me notice the problem. Can you try the 
> > > following untested fix on your failing system? It'll apply against 
> > > patch 1/4 and is build tested against the next-queue dev-queue branch.
> > > 
> > > -Matt
> > > 
> > > From 8773d0f09741d7a318cdd96cf5aad2ddb79096e7 Mon Sep 17 00:00:00
> > > 2001
> > > From: Matt Porter <mporter@konsulko.com>
> > > Date: Thu, 30 Jun 2016 11:47:50 -0400
> > > Subject: [PATCH] igb: Fix missing lock init in rx network flow 
> > > classification  support
> > > 
> > > "[net-next,v5,1/4] igb: add support of RX network flow classification"
> > > adds a new nfc_lock to each adapter to protect the rx filter hash list.
> > > This lock is not initialized before use which results in 
> > > intermittent oopses. Initialize this lock during probe to fix the issue.
> > > 
> > > Signed-off-by: Matt Porter <mporter@konsulko.com>
> > > ---
> > >  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> > > b/drivers/net/ethernet/intel/igb/igb_main.c
> > > index c04b1c2..e5a4949 100644
> > > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > > @@ -3075,6 +3075,7 @@ static int igb_sw_init(struct igb_adapter *adapter)
> > >  				  VLAN_HLEN;
> > >  	adapter->min_frame_size = ETH_ZLEN + ETH_FCS_LEN;
> > > 
> > > +	spin_lock_init(&adapter->nfc_lock);
> > >  	spin_lock_init(&adapter->stats64_lock);
> > >  #ifdef CONFIG_PCI_IOV
> > >  	switch (hw->mac.type) {
> > > --
> > > 2.7.0
> > 
> > Bingo!  That resolved it.  I can now load and bind (with ifconfig) on all the systems that were previously giving me the splat without seeing anything out of the ordinary.
> 
> Excellent! Thanks for doing the grunt testing work on it. ;) Looks like this was the only remaining issue from the v5 submission.
> 
> Gangfeng: can you fold this fix into a v6 submission? If this isn't something you are still working on then let me know and I can resubmit.
> 
> Regards,
> Matt
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
