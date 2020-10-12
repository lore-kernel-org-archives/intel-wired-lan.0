From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 12 Oct 2020 21:21:09 +0000
Subject: [Intel-wired-lan] [PATCH S53 10/15] ice: Remove gate to OROM
 init
In-Reply-To: <20200917201347.81570-10-anthony.l.nguyen@intel.com>
References: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
 <20200917201347.81570-10-anthony.l.nguyen@intel.com>
Message-ID: <DM6PR11MB28905A921F104FDEF946B3A6BC070@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Tony
> Nguyen
> Sent: Thursday, September 17, 2020 1:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S53 10/15] ice: Remove gate to OROM init
> 
> From: Jeb Cramer <jeb.j.cramer@intel.com>
> 
> Remove the gate that prevents the OROM and netlist info from being
> populated.  The NVM now has the appropriate section for software to
> reference the versioning info.
> 
> Signed-off-by: Jeb Cramer <jeb.j.cramer@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_nvm.c | 26 ------------------------
>  1 file changed, 26 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
