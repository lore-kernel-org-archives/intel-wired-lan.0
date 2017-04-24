From: Benjamin Poirier <bpoirier@suse.com>
Date: Mon, 24 Apr 2017 12:10:26 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] e1000e: Don't return
 uninitialized stats
In-Reply-To: <caef8d69-9e47-bbcc-0758-e5900e1cb291@intel.com>
References: <20170421212012.25950-1-bpoirier@suse.com>
 <630A6B92B7EDEB45A87E20D3D286660171182EED@hasmsx109.ger.corp.intel.com>
 <caef8d69-9e47-bbcc-0758-e5900e1cb291@intel.com>
Message-ID: <20170424191026.wpnpyhdaurfjixl7@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sasha, please use reply-all to keep everyone in cc (including me...).

On 2017/04/24 11:17, Neftin, Sasha wrote:
> On 4/23/2017 15:53, Neftin, Sasha wrote:
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Benjamin Poirier
> > Sent: Saturday, April 22, 2017 00:20
> > To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> > Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Stefan Priebe <s.priebe@profihost.ag>
> > Subject: [Intel-wired-lan] [PATCH 1/2] e1000e: Don't return uninitialized stats
> > 
> > Some statistics passed to ethtool are garbage because e1000e_get_stats64() doesn't write them, for example: tx_heartbeat_errors. This leaks kernel memory to userspace and confuses users.
> > 
> > Do like ixgbe and use dev_get_stats() which first zeroes out rtnl_link_stats64.
> > 
> > Reported-by: Stefan Priebe <s.priebe@profihost.ag>
> > Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> > ---
> >   drivers/net/ethernet/intel/e1000e/ethtool.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
> > index 7aff68a4a4df..f117b90cdc2f 100644
> > --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
> > +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
> > @@ -2063,7 +2063,7 @@ static void e1000_get_ethtool_stats(struct net_device *netdev,
> >   	pm_runtime_get_sync(netdev->dev.parent);
> > -	e1000e_get_stats64(netdev, &net_stats);
> > +	dev_get_stats(netdev, &net_stats);
> >   	pm_runtime_put_sync(netdev->dev.parent);
> > --
> > 2.12.2
> > 
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at lists.osuosl.org
> > http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
> Hello,
> 
> We would like to not accept this patch. Suggested generic method
> '*dev_get_stats' (net/core/dev.c) calls 'ops->ndo_get_stats64' method which
> eventually calls e1000e_get_stats64 (netdev.c) - so there is same
> functionality. Also, see that 'e1000e_get_stats64' method in netdev.c (line

No, it's not the same functionality because dev_get_stats() does a
memset on the rtnl_link_stats64 struct.

> 5928) calls 'memset' with 0's before update statistics.  Local sanity check

I don't see any memset in e1000e_get_stats64(). What kernel version are
you looking at?

> in our lab shows 'tx_heartbeat_errors' counter reported as 0.
> 

Please see the mail I just sent to Paul Menzel <pmenzel@molgen.mpg.de>
for more information about the issue and how to reproduce it.
