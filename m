From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 4 Nov 2019 20:19:58 +0000
Subject: [Intel-wired-lan] [PATCH] ice: fix potential infinite loop
 because loop counter being too small
In-Reply-To: <20191101140017.16646-1-colin.king@canonical.com>
References: <20191101140017.16646-1-colin.king@canonical.com>
Message-ID: <19998571b6704752955e3c951b50eb92@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Friday, November 1, 2019 7:00 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S . Miller
> <davem@davemloft.net>; Venkataramanan, Anirudh
> <anirudh.venkataramanan@intel.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ice: fix potential infinite loop because loop
> counter being too small
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the for-loop counter i is a u8 however it is being checked against a
> maximum value hw->num_tx_sched_layers which is a u16. Hence there is a
> potential wrap-around of counter i back to zero if
> hw->num_tx_sched_layers is greater than 255.  Fix this by making i
> a u16.
> 
> Addresses-Coverity: ("Infinite loop")
> Fixes: b36c598c999c ("ice: Updates to Tx scheduler code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

