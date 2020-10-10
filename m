From: Eric W. Biederman <ebiederm@xmission.com>
Date: Fri, 09 Oct 2020 22:43:15 -0500
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 51/58] kernel: Utilize
 new kmap_thread()
In-Reply-To: <20201009195033.3208459-52-ira.weiny@intel.com> (ira weiny's
 message of "Fri, 9 Oct 2020 12:50:26 -0700")
References: <20201009195033.3208459-1-ira.weiny@intel.com>
 <20201009195033.3208459-52-ira.weiny@intel.com>
Message-ID: <87k0vysq3w.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ira.weiny at intel.com writes:

> From: Ira Weiny <ira.weiny@intel.com>
>
> This kmap() call is localized to a single thread.  To avoid the over
> head of global PKRS updates use the new kmap_thread() call.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  kernel/kexec_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index c19c0dad1ebe..272a9920c0d6 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -815,7 +815,7 @@ static int kimage_load_normal_segment(struct kimage *image,
>  		if (result < 0)
>  			goto out;
>  
> -		ptr = kmap(page);
> +		ptr = kmap_thread(page);
>  		/* Start with a clear page */
>  		clear_page(ptr);
>  		ptr += maddr & ~PAGE_MASK;
> @@ -828,7 +828,7 @@ static int kimage_load_normal_segment(struct kimage *image,
>  			memcpy(ptr, kbuf, uchunk);
>  		else
>  			result = copy_from_user(ptr, buf, uchunk);
> -		kunmap(page);
> +		kunmap_thread(page);
>  		if (result) {
>  			result = -EFAULT;
>  			goto out;
> @@ -879,7 +879,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>  			goto out;
>  		}
>  		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
> -		ptr = kmap(page);
> +		ptr = kmap_thread(page);
>  		ptr += maddr & ~PAGE_MASK;
>  		mchunk = min_t(size_t, mbytes,
>  				PAGE_SIZE - (maddr & ~PAGE_MASK));
> @@ -895,7 +895,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>  		else
>  			result = copy_from_user(ptr, buf, uchunk);
>  		kexec_flush_icache_page(page);
> -		kunmap(page);
> +		kunmap_thread(page);
>  		arch_kexec_pre_free_pages(page_address(page), 1);
>  		if (result) {
>  			result = -EFAULT;
