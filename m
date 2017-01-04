From: kbuild test robot <lkp@intel.com>
Date: Wed, 4 Jan 2017 08:58:26 +0800
Subject: [Intel-wired-lan] [next PATCH v3 1/3] mm: Rename
 __alloc_page_frag to page_frag_alloc and __free_page_frag to page_frag_free
In-Reply-To: <20170103171024.5144.17036.stgit@localhost.localdomain>
Message-ID: <201701040815.YtW6y7i3%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alexander,

[auto build test ERROR on mmotm/master]
[also build test ERROR on v4.10-rc2 next-20170103]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexander-Duyck/Page-fragment-updates/20170104-080239
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: i386-randconfig-x003-201701 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the linux-review/Alexander-Duyck/Page-fragment-updates/20170104-080239 HEAD 81fa8f8a69c1b7187ae789eb536cdfcb3263d366 builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   net/core/skbuff.c: In function '__netdev_alloc_frag':
>> net/core/skbuff.c:372:9: error: implicit declaration of function 'page_frag_alloc' [-Werror=implicit-function-declaration]
     data = page_frag_alloc(nc, fragsz, gfp_mask);
            ^~~~~~~~~~~~~~~
>> net/core/skbuff.c:372:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     data = page_frag_alloc(nc, fragsz, gfp_mask);
          ^
   net/core/skbuff.c: In function '__napi_alloc_frag':
>> net/core/skbuff.c:394:9: warning: return makes pointer from integer without a cast [-Wint-conversion]
     return page_frag_alloc(&nc->page, fragsz, gfp_mask);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/skbuff.c: In function '__netdev_alloc_skb':
   net/core/skbuff.c:444:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     data = page_frag_alloc(nc, len, gfp_mask);
          ^
   net/core/skbuff.c: In function '__napi_alloc_skb':
   net/core/skbuff.c:508:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     data = page_frag_alloc(&nc->page, len, gfp_mask);
          ^
   cc1: some warnings being treated as errors

vim +/page_frag_alloc +372 net/core/skbuff.c

   366		struct page_frag_cache *nc;
   367		unsigned long flags;
   368		void *data;
   369	
   370		local_irq_save(flags);
   371		nc = this_cpu_ptr(&netdev_alloc_cache);
 > 372		data = page_frag_alloc(nc, fragsz, gfp_mask);
   373		local_irq_restore(flags);
   374		return data;
   375	}
   376	
   377	/**
   378	 * netdev_alloc_frag - allocate a page fragment
   379	 * @fragsz: fragment size
   380	 *
   381	 * Allocates a frag from a page for receive buffer.
   382	 * Uses GFP_ATOMIC allocations.
   383	 */
   384	void *netdev_alloc_frag(unsigned int fragsz)
   385	{
   386		return __netdev_alloc_frag(fragsz, GFP_ATOMIC | __GFP_COLD);
   387	}
   388	EXPORT_SYMBOL(netdev_alloc_frag);
   389	
   390	static void *__napi_alloc_frag(unsigned int fragsz, gfp_t gfp_mask)
   391	{
   392		struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
   393	
 > 394		return page_frag_alloc(&nc->page, fragsz, gfp_mask);
   395	}
   396	
   397	void *napi_alloc_frag(unsigned int fragsz)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25575 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170104/905cc418/attachment-0001.bin>
