From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Sep 2019 21:00:10 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: clear
 __I40E_VIRTCHNL_OP_PENDING on invalid min tx rate
In-Reply-To: <20190903060810.30775-1-sassmann@kpanic.de>
References: <20190903060810.30775-1-sassmann@kpanic.de>
Message-ID: <4bbcbce0cd2f419682fc390af5cd35e5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Stefan Assmann
> Sent: Monday, September 2, 2019 11:08 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH] i40e: clear
> __I40E_VIRTCHNL_OP_PENDING on invalid min tx rate
> 
> In the case of an invalid min tx rate being requested
> i40e_ndo_set_vf_bw() immediately returns -EINVAL instead of releasing
> __I40E_VIRTCHNL_OP_PENDING first.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


