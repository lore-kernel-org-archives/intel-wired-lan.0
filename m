From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 4 Jan 2022 21:56:03 +0000
Subject: [Intel-wired-lan] [PATCH] intel: Simplify DMA setting
In-Reply-To: <20220104132936.252202-1-alexandr.lobakin@intel.com>
References: <c7a34d0096eb4ba98dd9ce5b64ba079126cab708.1641255235.git.christophe.jaillet@wanadoo.fr>
 <20220104132936.252202-1-alexandr.lobakin@intel.com>
Message-ID: <c258c3bb440b88e984b0385af8ffb38a017ba644.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2022-01-04 at 14:29 +0100, Alexander Lobakin wrote:
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Date: Tue, 4 Jan 2022 01:15:20 +0100
> 
> > As stated in [1], dma_set_mask() with a 64-bit mask will never fail
> > if
> > dev->dma_mask is non-NULL.
> > So, if it fails, the 32 bits case will also fail for the same
> > reason.
> > 
> > Simplify code and remove some dead code accordingly.
> > 
> > [1]: https://lkml.org/lkml/2021/6/7/398
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > ?drivers/net/ethernet/intel/e1000e/netdev.c??? | 22 ++++++---------
> > ----
> > ?drivers/net/ethernet/intel/i40e/i40e_main.c?? |? 9 +++-----
> > ?drivers/net/ethernet/intel/iavf/iavf_main.c?? |? 9 +++-----
> > ?drivers/net/ethernet/intel/ice/ice_main.c???? |? 2 --
> > ?drivers/net/ethernet/intel/ixgb/ixgb_main.c?? | 19 +++++----------
> > -
> > ?drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 ++++++---------
> > --
> > ?.../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 20 +++++----------
> > --
> > ?7 files changed, 31 insertions(+), 70 deletions(-)
> 
> I like it, thanks!
> 
> Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> 
> Tony might ask to split it into per-driver patches tho, will see.

Hi Christophe,

As mentioned by others, would mind breaking these per-driver?

Thanks,
Tony

> 
> --- 8< ---
> 
> Al

