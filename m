From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Jul 2019 17:19:11 +0000
Subject: [Intel-wired-lan] [PATCH v2 01/10] i40e: simplify Rx buffer
 recycle
In-Reply-To: <20190716030637.5634-2-kevin.laatz@intel.com>
References: <20190620090958.2135-1-kevin.laatz@intel.com>
 <20190716030637.5634-1-kevin.laatz@intel.com>
 <20190716030637.5634-2-kevin.laatz@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40C2FD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Kevin Laatz
> Sent: Monday, July 15, 2019 8:06 PM
> To: netdev at vger.kernel.org; ast at kernel.org; daniel at iogearbox.net; Topel,
> Bjorn <bjorn.topel@intel.com>; Karlsson, Magnus
> <magnus.karlsson@intel.com>; jakub.kicinski at netronome.com;
> jonathan.lemon at gmail.com
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Loftus, Ciara
> <ciara.loftus@intel.com>; intel-wired-lan at lists.osuosl.org;
> bpf at vger.kernel.org; Laatz, Kevin <kevin.laatz@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 01/10] i40e: simplify Rx buffer recycle
> 
> Currently, the dma, addr and handle are modified when we reuse Rx buffers
> in zero-copy mode. However, this is not required as the inputs to the
> function are copies, not the original values themselves. As we use the copies
> within the function, we can use the original 'old_bi' values directly without
> having to mask and add the headroom.
> 
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


