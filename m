From: Venkataramanan, Anirudh <anirudh.venkataramanan@intel.com>
Date: Tue, 13 Mar 2018 20:42:45 +0000
Subject: [Intel-wired-lan] [PATCH 12/15] ice: Add stats and ethtool
 support
In-Reply-To: <20180310084243.4584ccd9@xeon-e3>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-13-anirudh.venkataramanan@intel.com>
 <20180310084243.4584ccd9@xeon-e3>
Message-ID: <1520973763.696.33.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2018-03-10 at 08:42 -0800, Stephen Hemminger wrote:
> On Fri,  9 Mar 2018 09:21:33 -0800
> Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> wrote:
> 
> > +	/* VSI stats */
> > +	struct rtnl_link_stats64 net_stats;
> > +	struct rtnl_link_stats64 net_stats_prev;
> > +	struct ice_eth_stats eth_stats;
> > +	struct ice_eth_stats eth_stats_prev;
> 
> You also don't need current and previous as separate copies since
> previous is only
> used while computing the current values.

Thanks for the feedback, Stephen.

eth_stats_prev is used in ice_update_eth_stats when we update
eth_stats.

While looking into this though, I found that net_stats_prev field in
struct ice_vsi (and consequently *prev_ns and *prev_es pointers in
ice_update_vsi_stats) may not be needed. Is this what you meant?

Thanks!
Ani
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3302 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180313/51b6b0e0/attachment.bin>
