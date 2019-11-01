From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Nov 2019 16:42:17 +0000
Subject: [Intel-wired-lan] [PATCH S32 04/15] ice: avoid setting features
 during reset
In-Reply-To: <20191025143441.50151-4-anthony.l.nguyen@intel.com>
References: <20191025143441.50151-1-anthony.l.nguyen@intel.com>
 <20191025143441.50151-4-anthony.l.nguyen@intel.com>
Message-ID: <37bcdd00a1f24d5baf0fbf52e209b8c4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, October 25, 2019 7:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 04/15] ice: avoid setting features
> during reset
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> Certain subsystems behave very badly when called during reset (core dump).
> This patch returns -EBUSY when reconfiguring some subsystems during
> reset. With this patch some ethtool functions will not core dump during
> reset.
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


