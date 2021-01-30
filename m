From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 29 Jan 2021 18:30:51 -0800
Subject: [Intel-wired-lan] [PATCH v2 net-next 1/4] mm: constify
 page_is_pfmemalloc() argument
In-Reply-To: <20210127201031.98544-2-alobakin@pm.me>
References: <20210127201031.98544-1-alobakin@pm.me>
 <20210127201031.98544-2-alobakin@pm.me>
Message-ID: <20210129183051.62874a6d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 27 Jan 2021 20:11:01 +0000 Alexander Lobakin wrote:
> The function only tests for page->index, so its argument should be
> const.
> 
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  include/linux/mm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ecdf8a8cd6ae..078633d43af9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1584,7 +1584,7 @@ struct address_space *page_mapping_file(struct page *page);
>   * ALLOC_NO_WATERMARKS and the low watermark was not
>   * met implying that the system is under some pressure.
>   */
> -static inline bool page_is_pfmemalloc(struct page *page)
> +static inline bool page_is_pfmemalloc(const struct page *page)
>  {
>  	/*
>  	 * Page index cannot be this large so this must be

No objections for this going via net-next?
