From: Nicolas Pitre <nico@fluxnic.net>
Date: Tue, 13 Oct 2020 14:36:56 -0400 (EDT)
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 33/58] fs/cramfs: Utilize
 new kmap_thread()
In-Reply-To: <20201009195033.3208459-34-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
 <20201009195033.3208459-34-ira.weiny@intel.com>
Message-ID: <nycvar.YSQ.7.78.906.2010131436200.2184@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 9 Oct 2020, ira.weiny at intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> The kmap() calls in this FS are localized to a single thread.  To avoid
> the over head of global PKRS updates use the new kmap_thread() call.
> 
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

>  fs/cramfs/inode.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 912308600d39..003c014a42ed 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -247,8 +247,8 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
>  		struct page *page = pages[i];
>  
>  		if (page) {
> -			memcpy(data, kmap(page), PAGE_SIZE);
> -			kunmap(page);
> +			memcpy(data, kmap_thread(page), PAGE_SIZE);
> +			kunmap_thread(page);
>  			put_page(page);
>  		} else
>  			memset(data, 0, PAGE_SIZE);
> @@ -826,7 +826,7 @@ static int cramfs_readpage(struct file *file, struct page *page)
>  
>  	maxblock = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	bytes_filled = 0;
> -	pgdata = kmap(page);
> +	pgdata = kmap_thread(page);
>  
>  	if (page->index < maxblock) {
>  		struct super_block *sb = inode->i_sb;
> @@ -914,13 +914,13 @@ static int cramfs_readpage(struct file *file, struct page *page)
>  
>  	memset(pgdata + bytes_filled, 0, PAGE_SIZE - bytes_filled);
>  	flush_dcache_page(page);
> -	kunmap(page);
> +	kunmap_thread(page);
>  	SetPageUptodate(page);
>  	unlock_page(page);
>  	return 0;
>  
>  err:
> -	kunmap(page);
> +	kunmap_thread(page);
>  	ClearPageUptodate(page);
>  	SetPageError(page);
>  	unlock_page(page);
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 
> 
