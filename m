From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Nov 2016 15:52:40 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: remove unnecessary __packed
In-Reply-To: <1479592438-17078-1-git-send-email-tushar.n.dave@oracle.com>
References: <1479592438-17078-1-git-send-email-tushar.n.dave@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA387ED@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tushar Dave
> Sent: Saturday, November 19, 2016 1:54 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: remove unnecessary __packed
> 
> 'struct i40e_dma_mem' defined with 'packed' directive causing kernel
> unaligned errors on sparc.
> 
> e.g.
> i40e: Intel(R) Ethernet Connection XL710 Network Driver - version 1.6.16-k
> i40e: Copyright (c) 2013 - 2014 Intel Corporation.
> Kernel unaligned access at TPC[44894c]
> dma_4v_alloc_coherent+0x1ac/0x300 Kernel unaligned access at
> TPC[44894c] dma_4v_alloc_coherent+0x1ac/0x300 Kernel unaligned access
> at TPC[44894c] dma_4v_alloc_coherent+0x1ac/0x300 Kernel unaligned
> access at TPC[44894c] dma_4v_alloc_coherent+0x1ac/0x300 Kernel
> unaligned access at TPC[44894c] dma_4v_alloc_coherent+0x1ac/0x300 i40e
> 0000:03:00.0: fw 5.1.40981 api 1.5 nvm 5.04 0x80002548 0.0.0
> 
> This can be fixed with get_unaligned/put_unaligned(). However no
> reference in driver shows that 'struct i40e_dma_mem' directly shoved into
> NIC hardware. But instead fields of the struct are being read and used for
> hardware. Therefore, __packed is unnecessary for 'struct i40e_dma_mem'.
> 
> In addition, although 'struct i40e_virt_mem' doesn't cause any unaligned
> access, keeping it packed is unnecessary as well because of aforementioned
> reason.
> 
> This change make 'struct i40e_dma_mem' and 'struct i40e_virt_mem'
> unpacked.
> 
> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_osdep.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


