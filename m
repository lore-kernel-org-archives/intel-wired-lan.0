From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 23:18:10 +0000
Subject: [Intel-wired-lan] [PATCH S46 2/9] ice: Always clear
 QRXFLXP_CNTXT before writing new value
In-Reply-To: <20200516005506.5113-2-anthony.l.nguyen@intel.com>
References: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
 <20200516005506.5113-2-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB165990B8E3C16B71C4C79D118C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S46 2/9] ice: Always clear QRXFLXP_CNTXT
> before writing new value
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Always clear the previous value in QRXFLXP_CNTXT before writing a new
> value. This will make it so re-used queues will not accidentally take the
> previously configured settings.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 33 ++++++++---------------
> drivers/net/ethernet/intel/ice/ice_lib.c  | 26 ++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_lib.h  |  3 +++
>  3 files changed, 40 insertions(+), 22 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


