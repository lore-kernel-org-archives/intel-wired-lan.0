From: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 13 Oct 2020 21:01:49 +0100
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 33/58] fs/cramfs: Utilize
 new kmap_thread()
In-Reply-To: <20201013193643.GK20115@casper.infradead.org>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
 <20201009195033.3208459-34-ira.weiny@intel.com>
 <CAPcyv4gL3jfw4d+SJGPqAD3Dp4F_K=X3domuN4ndAA1FQDGcPg@mail.gmail.com>
 <20201013193643.GK20115@casper.infradead.org>
Message-ID: <20201013200149.GI3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 13, 2020 at 08:36:43PM +0100, Matthew Wilcox wrote:

> static inline void copy_to_highpage(struct page *to, void *vfrom, unsigned int size)
> {
> 	char *vto = kmap_atomic(to);
> 
> 	memcpy(vto, vfrom, size);
> 	kunmap_atomic(vto);
> }
> 
> in linux/highmem.h ?

You mean, like
static void memcpy_from_page(char *to, struct page *page, size_t offset, size_t len)
{
        char *from = kmap_atomic(page);
        memcpy(to, from + offset, len);
        kunmap_atomic(from);
}

static void memcpy_to_page(struct page *page, size_t offset, const char *from, size_t len)
{
        char *to = kmap_atomic(page);
        memcpy(to + offset, from, len);
        kunmap_atomic(to);
}

static void memzero_page(struct page *page, size_t offset, size_t len)
{
        char *addr = kmap_atomic(page);
        memset(addr + offset, 0, len);
        kunmap_atomic(addr);
}

in lib/iov_iter.c?  FWIW, I don't like that "highpage" in the name and
highmem.h as location - these make perfect sense regardless of highmem;
they are normal memory operations with page + offset used instead of
a pointer...
