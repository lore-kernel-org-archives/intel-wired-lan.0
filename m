From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 27 Jan 2021 13:52:11 -0800
Subject: [Intel-wired-lan] [PATCH v2 net-next 0/4] net: consolidate
 page_is_pfmemalloc() usage
In-Reply-To: <20210127201031.98544-1-alobakin@pm.me>
References: <20210127201031.98544-1-alobakin@pm.me>
Message-ID: <20210127135211.00005620@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Lobakin wrote:

> page_is_pfmemalloc() is used mostly by networking drivers to test
> if a page can be considered for reusing/recycling.
> It doesn't write anything to the struct page itself, so its sole
> argument can be constified, as well as the first argument of
> skb_propagate_pfmemalloc().
> In Page Pool core code, it can be simply inlined instead.
> Most of the callers from NIC drivers were just doppelgangers of
> the same condition tests. Derive them into a new common function
> do deduplicate the code.

This is a useful cleanup! Thanks.

For the series:
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
