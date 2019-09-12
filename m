From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 12 Sep 2019 16:27:08 +0000
Subject: [Intel-wired-lan] [PATCH bpf-next 1/3] i40e: fix xdp handle
 calculations
In-Reply-To: <20190911172435.21042-1-ciara.loftus@intel.com>
References: <20190911172435.21042-1-ciara.loftus@intel.com>
Message-ID: <0c1b13d4fba947a1a99dac9ebef2635d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Ciara Loftus
> Sent: Wednesday, September 11, 2019 10:25 AM
> To: netdev at vger.kernel.org; ast at kernel.org; daniel at iogearbox.net; Topel,
> Bjorn <bjorn.topel@intel.com>; Karlsson, Magnus
> <magnus.karlsson@intel.com>; jonathan.lemon at gmail.com
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; bpf at vger.kernel.org;
> intel-wired-lan at lists.osuosl.org; Loftus, Ciara <ciara.loftus@intel.com>;
> Laatz, Kevin <kevin.laatz@intel.com>
> Subject: [Intel-wired-lan] [PATCH bpf-next 1/3] i40e: fix xdp handle
> calculations
> 
> Commit 4c5d9a7fa149 ("i40e: fix xdp handle calculations") reintroduced the
> addition of the umem headroom to the xdp handle in the i40e_zca_free,
> i40e_alloc_buffer_slow_zc and i40e_alloc_buffer_zc functions. However, the
> headroom is already added to the handle in the function i40_run_xdp_zc.
> This commit removes the latter addition and fixes the case where the
> headroom is non-zero.
> 
> Fixes: 4c5d9a7fa149 ("i40e: fix xdp handle calculations")
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


