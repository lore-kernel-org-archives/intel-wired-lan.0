From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Nov 2019 18:39:20 +0000
Subject: [Intel-wired-lan] [PATCH S32 v3 10/15] ice: delay less
In-Reply-To: <20191106100541.48639-10-anthony.l.nguyen@intel.com>
References: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
 <20191106100541.48639-10-anthony.l.nguyen@intel.com>
Message-ID: <60107ba102974e368af99235f8bf4808@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S32 v3 10/15] ice: delay less
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Shorten the delay for SQ responses, but increase the number of loops.
> Max delay time is unchanged, but some operations complete much more
> quickly.
> 
> In the process, add a new define to make the delay count and delay time
> more explicit. Add comments to make things more explicit.
> 
> This fixes a problem with VF resets failing on with many VFs.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 2 +-
> drivers/net/ethernet/intel/ice/ice_controlq.h | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


