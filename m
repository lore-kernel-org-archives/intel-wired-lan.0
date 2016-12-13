From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 13 Dec 2016 20:57:12 +0100
Subject: [Intel-wired-lan] [PATCH v3 3/4] i40e: Add XDP_TX support
In-Reply-To: <20161213134007.14707-4-bjorn.topel@gmail.com>
References: <20161213134007.14707-1-bjorn.topel@gmail.com>
 <20161213134007.14707-4-bjorn.topel@gmail.com>
Message-ID: <CAJ+HfNhY50t0_GyBq0F+yHDb7UFMO2+d7J+M8SmjpbE0M_xm2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

2016-12-13 14:40 GMT+01:00 Bj?rn T?pel <bjorn.topel@gmail.com>:
[...]
> @@ -625,6 +627,15 @@ u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw)
>  #define WB_STRIDE 4
>
>  /**
> + * i40e_page_is_reserved - check if reuse is possible
> + * @page: page struct to check
> + */
> +static inline bool i40e_page_is_reserved(struct page *page)
> +{
> +       return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
> +}

I started to use use Scott's i40e_page_is_reusable(), but missed to
get rid if this
leftover function.

So this one is not used, and should be removed.

[...]


Bj?rn
