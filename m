From: Stephen Hemminger <stephen@networkplumber.org>
Date: Sat, 10 Mar 2018 08:42:43 -0800
Subject: [Intel-wired-lan] [PATCH 12/15] ice: Add stats and ethtool
 support
In-Reply-To: <20180309172136.9073-13-anirudh.venkataramanan@intel.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-13-anirudh.venkataramanan@intel.com>
Message-ID: <20180310084243.4584ccd9@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri,  9 Mar 2018 09:21:33 -0800
Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> wrote:

> +	/* VSI stats */
> +	struct rtnl_link_stats64 net_stats;
> +	struct rtnl_link_stats64 net_stats_prev;
> +	struct ice_eth_stats eth_stats;
> +	struct ice_eth_stats eth_stats_prev;

You also don't need current and previous as separate copies since previous is only
used while computing the current values.
