From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 4 Jan 2018 15:46:08 +0000
Subject: [Intel-wired-lan] [PATCH 4/9] ixgbevf: add support for
 DMA_ATTR_SKIP_CPU_SYNC/WEAK_ORDERING
In-Reply-To: <20171211183704.21524.88419.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
 <20171211183704.21524.88419.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64B3EEF7@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Emil Tantilov
> Sent: Monday, December 11, 2017 10:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 4/9] ixgbevf: add support for
> DMA_ATTR_SKIP_CPU_SYNC/WEAK_ORDERING
> 
> Based on commit 5be5955425c2
> ("igb: update driver to make use of DMA_ATTR_SKIP_CPU_SYNC")
> 
> and
> 
> commit 7bd175928280 ("igb: Add support for DMA_ATTR_WEAK_ORDERING")
> 
> Convert the calls to dma_map/unmap_page() to the attributes version
> and add DMA_ATTR_SKIP_CPU_SYNC/WEAK_ORDERING which should help
> improve performance on some platforms.
> 
> Move sync_for_cpu call before we perform a prefetch to avoid
> invalidating the first 128 bytes of the packet on architectures where
> that call may invalidate the cache.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>








	
