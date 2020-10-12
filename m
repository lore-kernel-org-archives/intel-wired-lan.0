From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 12 Oct 2020 21:28:30 +0000
Subject: [Intel-wired-lan] [PATCH S53 09/15] ice: Enable Support for FW
 Override (E82X)
In-Reply-To: <20200917201347.81570-9-anthony.l.nguyen@intel.com>
References: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
 <20200917201347.81570-9-anthony.l.nguyen@intel.com>
Message-ID: <DM6PR11MB2890EE97D7A0B8CEA6B1494FBC070@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Tony
> Nguyen
> Sent: Thursday, September 17, 2020 1:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S53 09/15] ice: Enable Support for FW
> Override (E82X)
> 
> From: Jeb Cramer <jeb.j.cramer@intel.com>
> 
> The driver is able to override the firmware when it comes to supporting
> a more lenient link mode.  This feature was limited to E810 devices.  It
> is now extended to E82X devices.
> 
> Signed-off-by: Jeb Cramer <jeb.j.cramer@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 4 ----
>  1 file changed, 4 deletions(-)
> 

I do not currently have access to an E820, this tested by was run against E810 adapters and should be considered regression.
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
