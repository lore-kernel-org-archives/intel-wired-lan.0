From: David Rientjes <rientjes@google.com>
Date: Thu, 28 Jan 2021 14:49:27 -0800 (PST)
Subject: [Intel-wired-lan] [PATCH v2 net-next 4/4] net: page_pool:
 simplify page recycling condition tests
In-Reply-To: <20210127201031.98544-5-alobakin@pm.me>
References: <20210127201031.98544-1-alobakin@pm.me>
 <20210127201031.98544-5-alobakin@pm.me>
Message-ID: <7ac4064-b63-b26f-10db-68b83e6d4c6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 27 Jan 2021, Alexander Lobakin wrote:

> pool_page_reusable() is a leftover from pre-NUMA-aware times. For now,
> this function is just a redundant wrapper over page_is_pfmemalloc(),
> so Inline it into its sole call site.
> 
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Acked-by: David Rientjes <rientjes@google.com>
