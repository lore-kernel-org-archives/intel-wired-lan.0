From: Steffen Klassert <steffen.klassert@secunet.com>
Date: Sat, 7 May 2022 09:28:35 +0200
Subject: [Intel-wired-lan] [PATCH ipsec-next 0/8] Be explicit with XFRM
 offload direction
In-Reply-To: <cover.1651743750.git.leonro@nvidia.com>
References: <cover.1651743750.git.leonro@nvidia.com>
Message-ID: <20220507072835.GI680067@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, May 05, 2022 at 01:06:37PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi Steffen,
> 
> I may admit that the title of this series is not the best one as it
> contains straightforward cleanups and code that converts flags to
> something less confusing.
> 
> This series follows removal of FPGA IPsec code from the mlx5 driver and
> based on net-next commit 4950b6990e3b ("Merge branch 'ocelot-vcap-cleanups'").
> 
> As such, first two patches delete code that was used by mlx5 FPGA code
> but isn't needed anymore.
> 
> Third patch is simple struct rename.
> 
> Rest of the patches separate user's provided flags variable from driver's
> usage. This allows us to created more simple in-kernel interface, that
> supports type checking without blending different properties into one
> variable. It is achieved by converting flags to specific bitfield variables
> with clear, meaningful names.
>     
> Such change allows us more clear addition of new input flags needed to
> mark IPsec offload type.
> 
> The followup code uses this extensively:
> https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=xfrm-next
> 
> Thanks
> 
> Leon Romanovsky (8):
>   xfrm: free not used XFRM_ESP_NO_TRAILER flag
>   xfrm: delete not used number of external headers
>   xfrm: rename xfrm_state_offload struct to allow reuse
>   xfrm: store and rely on direction to construct offload flags
>   ixgbe: propagate XFRM offload state direction instead of flags
>   netdevsim: rely on XFRM state direction instead of flags
>   net/mlx5e: Use XFRM state direction instead of flags
>   xfrm: drop not needed flags variable in XFRM offload struct

Series applied, thanks a lot Leon!
