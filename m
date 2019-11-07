From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Nov 2019 18:40:18 +0000
Subject: [Intel-wired-lan] [PATCH S32 v3 12/15] ice: remove unnecessary
 conditional check
In-Reply-To: <20191106100541.48639-12-anthony.l.nguyen@intel.com>
References: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
 <20191106100541.48639-12-anthony.l.nguyen@intel.com>
Message-ID: <dc47b3057704414580fb8df693f061c1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, November 6, 2019 2:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 v3 12/15] ice: remove unnecessary
> conditional check
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> There is no reason to do this conditional check before the assignment so
> simply remove it.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


