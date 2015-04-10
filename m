From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 09 Apr 2015 17:34:55 -0700
Subject: [Intel-wired-lan] [PATCH 3/3 net-next] net_device: Add minimal
 padding to allow for net_device pointer alignment
In-Reply-To: <1676328eb3e9d02a4432783494d0c5a13f0d4656.1428622095.git.tgraf@suug.ch>
References: <cover.1428622095.git.tgraf@suug.ch>
 <1676328eb3e9d02a4432783494d0c5a13f0d4656.1428622095.git.tgraf@suug.ch>
Message-ID: <1428626095.25985.282.camel@edumazet-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-10 at 01:43 +0200, Thomas Graf wrote:
> Makes use of the __alignof__ GCC builtin to determine the minimal
> amount of padding required to align the pointer afterwards.
> 
> Due to use of ____cacheline_aligned_in_smp inside net_device,
> struct net_device is actually always a multiple of SMP_CACHE_BYTES
> so typically no padding is needed but this logic is kept in place
> in case that is no longer the case.
> 
> Signed-off-by: Thomas Graf <tgraf@suug.ch>
> ---
>  include/linux/kernel.h | 2 ++
>  net/core/dev.c         | 3 +--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index d6d630d..4ec018f 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -50,6 +50,8 @@
>  #define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
>  #define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
>  #define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
> +#define PTR_ALIGN_PAD(type, a) \
> +	({ (__alignof__(type) < (a)) ? @ - __alignof__(type) : 0; })
>  
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>  
> diff --git a/net/core/dev.c b/net/core/dev.c
> index b2775f0..2b43aba 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6794,8 +6794,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  		alloc_size = ALIGN(alloc_size, NETDEV_ALIGN);
>  		alloc_size += sizeof_priv;
>  	}
> -	/* ensure 32-byte alignment of whole construct */
> -	alloc_size += NETDEV_ALIGN - 1;
> +	alloc_size += PTR_ALIGN_PAD(struct net_device, NETDEV_ALIGN);
>  
>  	p = kzalloc(alloc_size, GFP_KERNEL | __GFP_NOWARN | __GFP_REPEAT);
>  	if (!p)


I believe code intent was to get an alignment even if kmalloc() returns
say 0xxxxx0008.

AFAIK, SLAB in debug mode was able to do this.






