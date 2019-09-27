From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 27 Sep 2019 19:01:15 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: prevent memory leak in
 i40e_setup_macvlans
In-Reply-To: <20190925154831.19044-1-navid.emamdoost@gmail.com>
References: <20190925154831.19044-1-navid.emamdoost@gmail.com>
Message-ID: <97cc947a0a08406096349699b6a8dc47@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Navid Emamdoost
> Sent: Wednesday, September 25, 2019 8:49 AM
> Cc: netdev at vger.kernel.org; kjlu at umn.edu; linux-kernel at vger.kernel.org;
> emamd001 at umn.edu; intel-wired-lan at lists.osuosl.org;
> smccaman at umn.edu; David S. Miller <davem@davemloft.net>; Navid
> Emamdoost <navid.emamdoost@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: prevent memory leak in
> i40e_setup_macvlans
> 
> In i40e_setup_macvlans if i40e_setup_channel fails the allocated memory for
> ch should be released.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


