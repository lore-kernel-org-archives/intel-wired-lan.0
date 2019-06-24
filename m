From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Mon, 24 Jun 2019 12:23:42 -0700
Subject: [Intel-wired-lan] [PATCH 03/11] xdp: add offset param to
 zero_copy_allocator
In-Reply-To: <20190620090958.2135-4-kevin.laatz@intel.com>
References: <20190620090958.2135-1-kevin.laatz@intel.com>
 <20190620090958.2135-4-kevin.laatz@intel.com>
Message-ID: <20190624122342.26c6a9b4@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 20 Jun 2019 09:09:50 +0000, Kevin Laatz wrote:
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 0f25b3675c5c..ea801fd2bf98 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -53,7 +53,8 @@ struct xdp_mem_info {
>  struct page_pool;
>  
>  struct zero_copy_allocator {
> -	void (*free)(struct zero_copy_allocator *zca, unsigned long handle);
> +	void (*free)(struct zero_copy_allocator *zca, unsigned long handle,
> +			off_t off);
>  };

Please run checkpatch --strict on all your changes.  The code
formatting is incorrect in many ways in this series.

Please include performance measurements proving the slow down
is negligible in the cover letter.
