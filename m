From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Feb 2020 22:06:17 +0000
Subject: [Intel-wired-lan] [PATCH][next] ice: remove redundant
 assignment to pointer vsi
In-Reply-To: <20200222171054.171505-1-colin.king@canonical.com>
References: <20200222171054.171505-1-colin.king@canonical.com>
Message-ID: <86c1fa9338da4e35a977773832a1188c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Saturday, February 22, 2020 9:11 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S . Miller
> <davem@davemloft.net>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH][next] ice: remove redundant assignment
> to pointer vsi
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer vsi is being re-assigned a value that is never read, the assignment is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

