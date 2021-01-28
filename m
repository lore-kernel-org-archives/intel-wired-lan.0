From: David Rientjes <rientjes@google.com>
Date: Thu, 28 Jan 2021 14:44:56 -0800 (PST)
Subject: [Intel-wired-lan] [PATCH v2 net-next 1/4] mm: constify
 page_is_pfmemalloc() argument
In-Reply-To: <20210127201031.98544-2-alobakin@pm.me>
References: <20210127201031.98544-1-alobakin@pm.me>
 <20210127201031.98544-2-alobakin@pm.me>
Message-ID: <cf211a78-7ce7-90e0-a589-1eb0bdc44222@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 27 Jan 2021, Alexander Lobakin wrote:

> The function only tests for page->index, so its argument should be
> const.
> 
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Acked-by: David Rientjes <rientjes@google.com>
