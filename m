From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Oct 2019 16:22:48 +0000
Subject: [Intel-wired-lan] [PATCH S31 10/15] ice: write register with
 correct offset
In-Reply-To: <20191009140953.14087-10-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
 <20191009140953.14087-10-anthony.l.nguyen@intel.com>
Message-ID: <608b8ba2540c4e42a56489db457b79bf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 9, 2019 7:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S31 10/15] ice: write register with correct
> offset
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The VF_MBX_ARQLEN register array is per-PF, not global, so we should not
> use the absolute VF ID as an index. Instead, use the per-PF VF ID.
> 
> This fixes an issue with VFs on PFs other than 0 not seeing reset.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


