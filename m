From: kbuild test robot <lkp@intel.com>
Date: Sun, 24 May 2020 16:07:05 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 19/99]
 drivers/net/ethernet/intel/i40e/i40e_xsk.c:234:6: error: redefinition of
 'i40e_alloc_rx_buffers_zc'
Message-ID: <202005241602.TlnvanY4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   5950d1e508b225372208a78339e6434adf129852
commit: b530c4dd1d0830c45139e65808038373cc54ebc8 [19/99] i40e: trivial fixup of comments in i40e_xsk.c
config: i386-allyesconfig (attached as .config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        git checkout b530c4dd1d0830c45139e65808038373cc54ebc8
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>, old ones prefixed by <<):

>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:234:6: error: redefinition of 'i40e_alloc_rx_buffers_zc'
bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_xsk.c:183:6: note: previous definition of 'i40e_alloc_rx_buffers_zc' was here
bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function 'i40e_alloc_rx_buffers_zc':
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:236:9: error: implicit declaration of function '__i40e_alloc_rx_buffers_zc'; did you mean 'i40e_alloc_rx_buffers_zc'? [-Werror=implicit-function-declaration]
return __i40e_alloc_rx_buffers_zc(rx_ring, count,
^~~~~~~~~~~~~~~~~~~~~~~~~~
i40e_alloc_rx_buffers_zc
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:237:8: error: 'i40e_alloc_buffer_slow_zc' undeclared (first use in this function); did you mean 'i40e_alloc_rx_buffers_zc'?
i40e_alloc_buffer_slow_zc);
^~~~~~~~~~~~~~~~~~~~~~~~~
i40e_alloc_rx_buffers_zc
drivers/net/ethernet/intel/i40e/i40e_xsk.c:237:8: note: each undeclared identifier is reported only once for each function it appears in
drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function 'i40e_alloc_rx_buffers_fast_zc':
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:253:8: error: 'i40e_alloc_buffer_zc' undeclared (first use in this function); did you mean 'i40e_alloc_rx_buffers_zc'?
i40e_alloc_buffer_zc);
^~~~~~~~~~~~~~~~~~~~
i40e_alloc_rx_buffers_zc
drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function 'i40e_reuse_rx_buffer_zc':
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:302:8: error: 'struct i40e_rx_buffer' has no member named 'addr'
new_bi->addr = old_bi->addr;
^~
drivers/net/ethernet/intel/i40e/i40e_xsk.c:302:23: error: 'struct i40e_rx_buffer' has no member named 'addr'
new_bi->addr = old_bi->addr;
^~
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:303:8: error: 'struct i40e_rx_buffer' has no member named 'handle'
new_bi->handle = old_bi->handle;
^~
drivers/net/ethernet/intel/i40e/i40e_xsk.c:303:25: error: 'struct i40e_rx_buffer' has no member named 'handle'
new_bi->handle = old_bi->handle;
^~
drivers/net/ethernet/intel/i40e/i40e_xsk.c:305:8: error: 'struct i40e_rx_buffer' has no member named 'addr'
old_bi->addr = NULL;
^~
drivers/net/ethernet/intel/i40e/i40e_xsk.c: At top level:
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:313:6: warning: no previous prototype for 'i40e_zca_free' [-Wmissing-prototypes]
void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
^~~~~~~~~~~~~
In file included from include/linux/export.h:43:0,
from include/linux/linkage.h:7,
from include/linux/kernel.h:8,
from include/linux/list.h:9,
from include/linux/timer.h:5,
from include/linux/netdevice.h:24,
from include/trace/events/xdp.h:8,
from include/linux/bpf_trace.h:5,
from drivers/net/ethernet/intel/i40e/i40e_xsk.c:4:
drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function 'i40e_zca_free':
>> include/linux/kernel.h:994:32: error: dereferencing pointer to incomplete type 'struct zero_copy_allocator'
BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&                                    ^~~~~~
include/linux/compiler.h:330:9: note: in definition of macro '__compiletime_assert'
if (!(condition))                 ^~~~~~~~~
include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
^~~~~~~~~~~~~~~~~~
include/linux/kernel.h:994:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&      ^~~~~~~~~~~~~~~~
include/linux/kernel.h:994:20: note: in expansion of macro '__same_type'
BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&                        ^~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:320:12: note: in expansion of macro 'container_of'
rx_ring = container_of(alloc, struct i40e_ring, zca);
^~~~~~~~~~~~
>> include/linux/kernel.h:994:51: error: 'struct i40e_ring' has no member named 'zca'
BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&                                                       ^
include/linux/compiler.h:330:9: note: in definition of macro '__compiletime_assert'
if (!(condition))                 ^~~~~~~~~
include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
^~~~~~~~~~~~~~~~~~
include/linux/kernel.h:994:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&      ^~~~~~~~~~~~~~~~
include/linux/kernel.h:994:20: note: in expansion of macro '__same_type'
BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&                        ^~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:320:12: note: in expansion of macro 'container_of'
rx_ring = container_of(alloc, struct i40e_ring, zca);
^~~~~~~~~~~~
In file included from <command-line>:0:0:
>> include/linux/compiler_types.h:129:35: error: 'struct i40e_ring' has no member named 'zca'
#define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
^
include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
#define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
^~~~~~~~~~~~~~~~~~~
include/linux/kernel.h:997:21: note: in expansion of macro 'offsetof'
((type *)(__mptr - offsetof(type, member))); })
^~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:320:12: note: in expansion of macro 'container_of'
rx_ring = container_of(alloc, struct i40e_ring, zca);
^~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:322:28: error: 'struct xdp_umem' has no member named 'chunk_mask'; did you mean 'chunk_size'?
mask = rx_ring->xsk_umem->chunk_mask;
^~~~~~~~~~
chunk_size
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:332:12: error: implicit declaration of function 'xdp_umem_get_dma'; did you mean 'xp_raw_get_dma'? [-Werror=implicit-function-declaration]
bi->dma = xdp_umem_get_dma(rx_ring->xsk_umem, handle);
^~~~~~~~~~~~~~~~
xp_raw_get_dma
drivers/net/ethernet/intel/i40e/i40e_xsk.c:335:4: error: 'struct i40e_rx_buffer' has no member named 'addr'
bi->addr = xdp_umem_get_data(rx_ring->xsk_umem, handle);
^~
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:335:13: error: implicit declaration of function 'xdp_umem_get_data'; did you mean 'xp_raw_get_data'? [-Werror=implicit-function-declaration]
bi->addr = xdp_umem_get_data(rx_ring->xsk_umem, handle);
^~~~~~~~~~~~~~~~~
xp_raw_get_data
drivers/net/ethernet/intel/i40e/i40e_xsk.c:336:4: error: 'struct i40e_rx_buffer' has no member named 'addr'
bi->addr += hr;
^~
drivers/net/ethernet/intel/i40e/i40e_xsk.c:338:4: error: 'struct i40e_rx_buffer' has no member named 'handle'
bi->handle = xsk_umem_adjust_offset(rx_ring->xsk_umem, (u64)handle,
^~
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:338:15: error: implicit declaration of function 'xsk_umem_adjust_offset'; did you mean 'vmem_altmap_offset'? [-Werror=implicit-function-declaration]
bi->handle = xsk_umem_adjust_offset(rx_ring->xsk_umem, (u64)handle,
^~~~~~~~~~~~~~~~~~~~~~
vmem_altmap_offset
drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function 'i40e_alloc_rx_buffers_zc':
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:238:1: warning: control reaches end of non-void function [-Wreturn-type]
}
^
At top level:
drivers/net/ethernet/intel/i40e/i40e_xsk.c:290:13: warning: 'i40e_reuse_rx_buffer_zc' defined but not used [-Wunused-function]
static void i40e_reuse_rx_buffer_zc(struct i40e_ring *rx_ring,
^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_xsk.c:266:31: warning: 'i40e_get_rx_buffer_zc' defined but not used [-Wunused-function]
static struct i40e_rx_buffer *i40e_get_rx_buffer_zc(struct i40e_ring *rx_ring,
^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_xsk.c:250:13: warning: 'i40e_alloc_rx_buffers_fast_zc' defined but not used [-Wunused-function]
static bool i40e_alloc_rx_buffers_fast_zc(struct i40e_ring *rx_ring, u16 count)
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

vim +/i40e_alloc_rx_buffers_zc +234 drivers/net/ethernet/intel/i40e/i40e_xsk.c

   182	
 > 183	bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
   184	{
   185		u16 ntu = rx_ring->next_to_use;
   186		union i40e_rx_desc *rx_desc;
   187		struct xdp_buff **bi, *xdp;
   188		dma_addr_t dma;
   189		bool ok = true;
   190	
   191		rx_desc = I40E_RX_DESC(rx_ring, ntu);
   192		bi = i40e_rx_bi(rx_ring, ntu);
   193		do {
   194			xdp = xsk_buff_alloc(rx_ring->xsk_umem);
   195			if (!xdp) {
   196				ok = false;
   197				goto no_buffers;
   198			}
   199			*bi = xdp;
   200			dma = xsk_buff_xdp_get_dma(xdp);
   201			rx_desc->read.pkt_addr = cpu_to_le64(dma);
   202			rx_desc->read.hdr_addr = 0;
   203	
   204			rx_desc++;
   205			bi++;
   206			ntu++;
   207	
   208			if (unlikely(ntu == rx_ring->count)) {
   209				rx_desc = I40E_RX_DESC(rx_ring, 0);
   210				bi = i40e_rx_bi(rx_ring, 0);
   211				ntu = 0;
   212			}
   213	
   214			count--;
   215		} while (count);
   216	
   217	no_buffers:
   218		if (rx_ring->next_to_use != ntu)
   219			i40e_release_rx_desc(rx_ring, ntu);
   220	
   221		return ok;
   222	}
   223	
   224	/**
   225	 * i40e_alloc_rx_buffers_zc - Allocates a number of Rx buffers
   226	 * @rx_ring: Rx ring
   227	 * @count: The number of buffers to allocate
   228	 *
   229	 * This function allocates a number of Rx buffers from the reuse queue
   230	 * or fill ring and places them on the Rx ring.
   231	 *
   232	 * Returns true for a successful allocation, false otherwise
   233	 **/
 > 234	bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
   235	{
 > 236		return __i40e_alloc_rx_buffers_zc(rx_ring, count,
 > 237						  i40e_alloc_buffer_slow_zc);
 > 238	}
   239	
   240	/**
   241	 * i40e_alloc_rx_buffers_fast_zc - Allocates a number of Rx buffers
   242	 * @rx_ring: Rx ring
   243	 * @count: The number of buffers to allocate
   244	 *
   245	 * This function allocates a number of Rx buffers from the fill ring
   246	 * or the internal recycle mechanism and places them on the Rx ring.
   247	 *
   248	 * Returns true for a successful allocation, false otherwise
   249	 **/
   250	static bool i40e_alloc_rx_buffers_fast_zc(struct i40e_ring *rx_ring, u16 count)
   251	{
   252		return __i40e_alloc_rx_buffers_zc(rx_ring, count,
 > 253						  i40e_alloc_buffer_zc);
   254	}
   255	
   256	/**
   257	 * i40e_get_rx_buffer_zc - Return the current Rx buffer
   258	 * @rx_ring: Rx ring
   259	 * @size: The size of the rx buffer (read from descriptor)
   260	 *
   261	 * This function returns the current, received Rx buffer, and also
   262	 * does DMA synchronization.  the Rx ring.
   263	 *
   264	 * Returns the received Rx buffer
   265	 **/
   266	static struct i40e_rx_buffer *i40e_get_rx_buffer_zc(struct i40e_ring *rx_ring,
   267							    const unsigned int size)
   268	{
   269		struct i40e_rx_buffer *bi;
   270	
   271		bi = &rx_ring->rx_bi[rx_ring->next_to_clean];
   272	
   273		/* we are reusing so sync this buffer for CPU use */
   274		dma_sync_single_range_for_cpu(rx_ring->dev,
   275					      bi->dma, 0,
   276					      size,
   277					      DMA_BIDIRECTIONAL);
   278	
   279		return bi;
   280	}
   281	
   282	/**
   283	 * i40e_reuse_rx_buffer_zc - Recycle an Rx buffer
   284	 * @rx_ring: Rx ring
   285	 * @old_bi: The Rx buffer to recycle
   286	 *
   287	 * This function recycles a finished Rx buffer, and places it on the
   288	 * recycle queue (next_to_alloc).
   289	 **/
   290	static void i40e_reuse_rx_buffer_zc(struct i40e_ring *rx_ring,
   291					    struct i40e_rx_buffer *old_bi)
   292	{
   293		struct i40e_rx_buffer *new_bi = &rx_ring->rx_bi[rx_ring->next_to_alloc];
   294		u16 nta = rx_ring->next_to_alloc;
   295	
   296		/* update, and store next to alloc */
   297		nta++;
   298		rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
   299	
   300		/* transfer page from old buffer to new buffer */
   301		new_bi->dma = old_bi->dma;
 > 302		new_bi->addr = old_bi->addr;
 > 303		new_bi->handle = old_bi->handle;
   304	
   305		old_bi->addr = NULL;
   306	}
   307	
   308	/**
   309	 * i40e_zca_free - Free callback for MEM_TYPE_ZERO_COPY allocations
   310	 * @alloc: Zero-copy allocator
   311	 * @handle: Buffer handle
   312	 **/
 > 313	void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
   314	{
   315		struct i40e_rx_buffer *bi;
   316		struct i40e_ring *rx_ring;
   317		u64 hr, mask;
   318		u16 nta;
   319	
 > 320		rx_ring = container_of(alloc, struct i40e_ring, zca);
   321		hr = rx_ring->xsk_umem->headroom + XDP_PACKET_HEADROOM;
 > 322		mask = rx_ring->xsk_umem->chunk_mask;
   323	
   324		nta = rx_ring->next_to_alloc;
   325		bi = &rx_ring->rx_bi[nta];
   326	
   327		nta++;
   328		rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
   329	
   330		handle &= mask;
   331	
 > 332		bi->dma = xdp_umem_get_dma(rx_ring->xsk_umem, handle);
   333		bi->dma += hr;
   334	
 > 335		bi->addr = xdp_umem_get_data(rx_ring->xsk_umem, handle);
 > 336		bi->addr += hr;
   337	
 > 338		bi->handle = xsk_umem_adjust_offset(rx_ring->xsk_umem, (u64)handle,
   339						    rx_ring->xsk_umem->headroom);
   340	}
   341	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 72570 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200524/dc6fa630/attachment-0001.bin>
