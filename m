From: David Miller <davem@davemloft.net>
Date: Thu, 28 Jan 2016 01:56:43 -0500 (EST)
Subject: [Intel-wired-lan] i40e: Kernel unaligned access due to 'struct
 i40e_dma_mem' being 'packed'
In-Reply-To: <56A973D6.4060202@oracle.com>
References: <56A973D6.4060202@oracle.com>
Message-ID: <20160128.015643.125847430094859447.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: tndave <tushar.n.dave@oracle.com>
Date: Wed, 27 Jan 2016 17:50:14 -0800

> Hi,
> 
> i40e driver has 'struct i40e_dma_mem' defined with 'packed' directive
> causing kernel unaligned errors on sparc (when
> 40e_allocate_dma_mem_d()
> is being called)
> 
> log_unaligned: 1031 callbacks suppressed
> Kernel unaligned access at TPC[448ae8]
> dma_4v_alloc_coherent+0x188/0x2e0
> Kernel unaligned access at TPC[448ae8]
> dma_4v_alloc_coherent+0x188/0x2e0
> Kernel unaligned access at TPC[448ae8]
> dma_4v_alloc_coherent+0x188/0x2e0
> Kernel unaligned access at TPC[448ae8]
> dma_4v_alloc_coherent+0x188/0x2e0
> 
> This can be fixed with get_unaligned/put_unaligned(). However I don't
> see 'struct i40e_dma_mem' is being directly shoved into NIC hardware.
> But instead fields of the struct are being read and used for hardware
> (e.g. dma_addr_t pa). For the test, I remove __packed, and i40e driver
> and HW works fine. (of course kernel unaligned errors are gone too).
> My question is, does 'struct i40e_dma_mem' required to be __packed?

People get overzealoud with __packed.

And even if it doesn't cause unaligned accesses like this, it generates
terrible code (byte at a time accesses to words) on several architectures.
