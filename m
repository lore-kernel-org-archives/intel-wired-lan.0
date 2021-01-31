From: Matthew Wilcox <willy@infradead.org>
Date: Sun, 31 Jan 2021 12:17:30 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 1/5] mm: constify
 page_is_pfmemalloc() argument
In-Reply-To: <20210131120844.7529-2-alobakin@pm.me>
References: <20210131120844.7529-1-alobakin@pm.me>
 <20210131120844.7529-2-alobakin@pm.me>
Message-ID: <20210131121730.GK308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Jan 31, 2021 at 12:11:30PM +0000, Alexander Lobakin wrote:
> The function only tests for page->index, so its argument should be
> const.
> 
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Acked-by: David Rientjes <rientjes@google.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
