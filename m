From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 18 Dec 2018 15:48:22 +0100
Subject: [Intel-wired-lan] [PATCH 1/2] xsk: export xdp_get_umem_from_qid
In-Reply-To: <20181218134514.6388-1-jan.sokolowski@intel.com>
References: <20181218134514.6388-1-jan.sokolowski@intel.com>
Message-ID: <CAJ+HfNhMDU+BzEt7Tgi6pfTR5hT6kM6daWTqJaPqxk=swstK3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Den tis 18 dec. 2018 kl 14:48 skrev Jan Sokolowski <jan.sokolowski@intel.com>:
>
> Export xdp_get_umem_from_qid for other modules to use.
>
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>

Adding netdev.

Acked-by: Bj?rn T?pel <bjorn.topel@intel.com>

> ---
>  net/xdp/xdp_umem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> index a264cf2accd0..424ae2538f9f 100644
> --- a/net/xdp/xdp_umem.c
> +++ b/net/xdp/xdp_umem.c
> @@ -60,6 +60,7 @@ struct xdp_umem *xdp_get_umem_from_qid(struct net_device *dev,
>
>         return NULL;
>  }
> +EXPORT_SYMBOL(xdp_get_umem_from_qid);
>
>  static void xdp_clear_umem_at_qid(struct net_device *dev, u16 queue_id)
>  {
> --
> 2.18.1
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
