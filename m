From: David Rientjes <rientjes@google.com>
Date: Thu, 28 Jan 2021 14:45:23 -0800 (PST)
Subject: [Intel-wired-lan] [PATCH v2 net-next 2/4] skbuff: constify
 skb_propagate_pfmemalloc() "page" argument
In-Reply-To: <20210127201031.98544-3-alobakin@pm.me>
References: <20210127201031.98544-1-alobakin@pm.me>
 <20210127201031.98544-3-alobakin@pm.me>
Message-ID: <b1d34275-1564-a46c-601b-a4b9865f50c7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 27 Jan 2021, Alexander Lobakin wrote:

> The function doesn't write anything to the page struct itself,
> so this argument can be const.
> 
> Misc: align second argument to the brace while at it.
> 
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Acked-by: David Rientjes <rientjes@google.com>
