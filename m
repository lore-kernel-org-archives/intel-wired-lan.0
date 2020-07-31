From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Jul 2020 19:59:16 +0000
Subject: [Intel-wired-lan] [PATCH S51 01/13] ice: rename misleading
 grst_delay variable
In-Reply-To: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21455CB211F909E6017EB5308C4E0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, July 29, 2020 5:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S51 01/13] ice: rename misleading
> grst_delay variable
> 
> From: Nick Nunley <nicholas.d.nunley@intel.com>
> 
> The grst_delay variable in ice_check_reset contains the maximum time (in
> 100 msec units) that the driver will wait for a reset event to transition to the
> Device Active state. The value is the sum of three separate components:
> 1) The maximum time it may take for the firmware to process its outstanding
> command before handling the reset request.
> 2) The value in RSTCTL.GRSTDEL (the delay firmware inserts between first
> seeing the driver reset request and the actual hardware assertion).
> 3) The maximum expected reset processing time in hardware.
> 
> Referring to this total time as "grst_delay" is misleading and potentially
> confusing to someone checking the code and cross-referencing the
> hardware specification.
> 
> Fix this by renaming the variable to "grst_timeout", which is more descriptive
> of its actual use.
> 
> Signed-off-by: Nick Nunley <nicholas.d.nunley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


