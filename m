From: Benjamin Poirier <bpoirier@suse.com>
Date: Tue, 25 Apr 2017 11:44:23 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] e1000e: Don't return
 uninitialized stats
In-Reply-To: <20170425105405.01541742@xeon-e3>
References: <20170421212012.25950-1-bpoirier@suse.com>
 <630A6B92B7EDEB45A87E20D3D286660171182EED@hasmsx109.ger.corp.intel.com>
 <caef8d69-9e47-bbcc-0758-e5900e1cb291@intel.com>
 <20170424191026.wpnpyhdaurfjixl7@f1.synalogic.ca>
 <309B89C4C689E141A5FF6A0C5FB2118B8C5EF4F7@ORSMSX101.amr.corp.intel.com>
 <1493111272.68612.2.camel@intel.com>
 <20170425105405.01541742@xeon-e3>
Message-ID: <20170425184423.lg6rqgjeucjxqne2@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2017/04/25 10:54, Stephen Hemminger wrote:
[...]
> > > The call to memset was removed from the upstream kernel with:
> > > -------------------------------------------------------------------
> > > -----------------
> > > commit 5944701df90d9577658e2354cc27c4ceaeca30fe
> > > Author: stephen hemminger <stephen@networkplumber.org>
> > > Date:?? Fri Jan 6 19:12:53 2017 -0800
> > > 
> > > ??? net: remove useless memset's in drivers get_stats64
> > > 
> > > ??? In dev_get_stats() the statistic structure storage has already
> > > been
> > > ??? zeroed. Therefore network drivers do not need to call memset()
> > > again.
> > > ...
> > > < changes to other drivers snipped out >
> > > ...
> > > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> > > b/drivers/net/ethernet/int
> > > index 723025b..79651eb 100644
> > > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> > > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> > > @@ -5925,7 +5925,6 @@ void e1000e_get_stats64(struct net_device
> > > *netdev,
> > > ?{
> > > ??????? struct e1000_adapter *adapter = netdev_priv(netdev);
> > > 
> > > -?????? memset(stats, 0, sizeof(struct rtnl_link_stats64));
> > > ??????? spin_lock(&adapter->stats64_lock);
> > > ??????? e1000e_update_stats(adapter);
> > > ??????? /* Fill out the OS statistics structure */
> > > -------------------------------------------------------------------
> > > -----------------
> > > 
> > > This also is where the bad counters start to show up for e1000e for
> > > my test systems.? From this driver on I see (very) large values for
> > > tx_dropped, rx_over_errors and tx_fifo_errors on driver load (even
> > > before bringing the interface up.? It seems the memset is not so
> > > useless for this driver after all.? Would simply reverting the e1000e
> > > portion of this patch resolve the issue?  
> > 
> > Looks like Aaron beat me to the punch on pointing out that we had this
> > very code in there before.  It appears that Stephen's
> > assertion/assumption was incorrect about the stats structure being
> > zero'd out, which is why we are seeing the issue.
> > 
> > I have no issue reverting Stephen's earlier patch, or do we want to
> > pursue why the stats structure is not zero'd out and resolve that
> > instead.  Either way, just want to make sure we are all on the same
> > page as to the right solution so that we do not end up repeating this
> > in the future.
> 
> Lets's fix this in the base code.
> 
> From: Stephen Hemminger <sthemmin@microsoft.com>
> Date: Tue, 25 Apr 2017 10:50:19 -0700
> Subject: [PATCH net] net: always zero statistics
> 
> Drivers with 32 bit statistics API also should get zeroed statistics.
> 
> Fixes: 5944701df90d ("net: remove useless memset's in drivers get_stats64")

This is probably a good change to do but it doesn't fix anything in
5944701df90d, especially not the problem with e1000e.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170425/c6f78092/attachment-0001.asc>
