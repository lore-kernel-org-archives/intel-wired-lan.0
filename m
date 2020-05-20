From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 20 May 2020 10:03:42 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v4 09/15] ice,
 xsk: migrate to new MEM_TYPE_XSK_BUFF_POOL
In-Reply-To: <20200520094742.337678-10-bjorn.topel@gmail.com>
References: <20200520094742.337678-1-bjorn.topel@gmail.com>
 <20200520094742.337678-10-bjorn.topel@gmail.com>
Message-ID: <20200520100342.620a0979@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 20 May 2020 11:47:36 +0200 Bj?rn T?pel wrote:
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> Remove MEM_TYPE_ZERO_COPY in favor of the new MEM_TYPE_XSK_BUFF_POOL
> APIs.
> 
> Cc: intel-wired-lan at lists.osuosl.org
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>

patch 8 also has a warning I can't figure out.

But here (patch 9) it's quite clear:

drivers/net/ethernet/intel/ice/ice_xsk.c:414: warning: Excess function parameter 'alloc' description in 'ice_alloc_rx_bufs_zc'
drivers/net/ethernet/intel/ice/ice_xsk.c:480: warning: Excess function parameter 'xdp' description in 'ice_construct_skb_zc'
