From: Matthew Wilcox <willy@infradead.org>
Date: Sun, 31 Jan 2021 12:23:48 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 5/5] net: page_pool:
 simplify page recycling condition tests
In-Reply-To: <20210131120844.7529-6-alobakin@pm.me>
References: <20210131120844.7529-1-alobakin@pm.me>
 <20210131120844.7529-6-alobakin@pm.me>
Message-ID: <20210131122348.GM308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Jan 31, 2021 at 12:12:11PM +0000, Alexander Lobakin wrote:
> pool_page_reusable() is a leftover from pre-NUMA-aware times. For now,
> this function is just a redundant wrapper over page_is_pfmemalloc(),
> so inline it into its sole call site.

Why doesn't this want to use {dev_}page_is_reusable()?

