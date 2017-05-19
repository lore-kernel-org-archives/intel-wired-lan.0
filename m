From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 19 May 2017 21:12:58 +0000
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Don't return uninitialized
	stats
In-Reply-To: <1495181811.2376.0.camel@intel.com>
References: <20170425175433.ykc6ilm6uo7e6my2@f1.synalogic.ca>
 <20170517202413.18321-1-bpoirier@suse.com>
 <20170518.104614.1739169308591707817.davem@davemloft.net>
 <1495181811.2376.0.camel@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5F9877@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Kirsher, Jeffrey T
> Sent: Friday, May 19, 2017 1:17 AM
> To: David Miller <davem@davemloft.net>; bpoirier at suse.com
> Cc: s.priebe at profihost.ag; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; pmenzel at molgen.mpg.de; Neftin, Sasha
> <sasha.neftin@intel.com>; Brown, Aaron F <aaron.f.brown@intel.com>;
> stephen at networkplumber.org
> Subject: Re: [PATCH v2] e1000e: Don't return uninitialized stats
> 
> On Thu, 2017-05-18 at 10:46 -0400, David Miller wrote:
> > From: Benjamin Poirier <bpoirier@suse.com>
> > Date: Wed, 17 May 2017 16:24:13 -0400
> >
> > > Some statistics passed to ethtool are garbage because
> > > e1000e_get_stats64()
> > > doesn't write them, for example: tx_heartbeat_errors. This leaks kernel
> > > memory to userspace and confuses users.
> > >
> > > Do like ixgbe and use dev_get_stats() which first zeroes out
> > > rtnl_link_stats64.
> > >
> > > Fixes: 5944701df90d ("net: remove useless memset's in drivers
> > > get_stats64")
> > > Reported-by: Stefan Priebe <s.priebe@profihost.ag>
> > > Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
