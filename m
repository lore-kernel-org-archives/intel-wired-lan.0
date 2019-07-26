From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jul 2019 18:20:07 +0000
Subject: [Intel-wired-lan] [PATCH S24 11/12] ice: Don't clear auto_fec
 bit in ice_cfg_phy_fec()
In-Reply-To: <20190723092759.3614-11-anthony.l.nguyen@intel.com>
References: <20190723092759.3614-1-anthony.l.nguyen@intel.com>
 <20190723092759.3614-11-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40CE12@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, July 23, 2019 2:28 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S24 11/12] ice: Don't clear auto_fec bit in
> ice_cfg_phy_fec()
> 
> From: Chinh T Cao <chinh.t.cao@intel.com>
> 
> The driver should never clear the auto_fec_enable bit.
> 
> Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


