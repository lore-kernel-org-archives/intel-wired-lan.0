From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 Feb 2019 00:00:51 +0000
Subject: [Intel-wired-lan] [PATCH S11 10/16] ice: don't spam VFs with
 link messages
In-Reply-To: <20190208205043.11975-11-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-11-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D366294@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S11 10/16] ice: don't spam VFs with link
> messages
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Don't send a link message to the VFs unless link actually changes state.
> This avoids a small timing hole in some VF drivers that can cause an apparent
> TX hang if they receive a link status message at the wrong time.
> 
> Although we have fixed the timing hole in the current VF driver, there are
> still lots of drivers in the field that have this timing hole. Let's not fall into it if
> we can avoid it.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


