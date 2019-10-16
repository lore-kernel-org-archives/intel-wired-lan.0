From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Oct 2019 16:25:15 +0000
Subject: [Intel-wired-lan] [PATCH S31 15/15] ice: Fix return value when
 SR-IOV is not supported
In-Reply-To: <20191009140953.14087-15-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
 <20191009140953.14087-15-anthony.l.nguyen@intel.com>
Message-ID: <1d21ba9beb664d3f98c0a399ef03fefd@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S31 15/15] ice: Fix return value when SR-
> IOV is not supported
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> When the device is not capable of supporting SR-IOV -ENODEV is being
> returned; -EOPNOTSUPP is more appropriate.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


