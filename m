From: David Rientjes <rientjes@google.com>
Date: Thu, 28 Jan 2021 14:48:43 -0800 (PST)
Subject: [Intel-wired-lan] [PATCH v2 net-next 3/4] net: introduce common
 dev_page_is_reserved()
In-Reply-To: <20210127201031.98544-4-alobakin@pm.me>
References: <20210127201031.98544-1-alobakin@pm.me>
 <20210127201031.98544-4-alobakin@pm.me>
Message-ID: <d8e86f1a-d2a6-d8af-142c-f735fd3be9f2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 27 Jan 2021, Alexander Lobakin wrote:

> A bunch of drivers test the page before reusing/recycling for two
> common conditions:
>  - if a page was allocated under memory pressure (pfmemalloc page);
>  - if a page was allocated at a distant memory node (to exclude
>    slowdowns).
> 
> Introduce and use a new common function for doing this and eliminate
> all functions-duplicates from drivers.
> 
> Suggested-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Looks even better than I thought!

(Since all of the changes are in drivers/net/ethernet/, I assume 
everything directly or indirectly includes skbuff.h already.)

Acked-by: David Rientjes <rientjes@google.com>

Thanks for doing this.
