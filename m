From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 May 2020 20:07:27 +0000
Subject: [Intel-wired-lan] [PATCH S43 12/15] ice: fix MAC write command
In-Reply-To: <20200516003644.4658-12-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
 <20200516003644.4658-12-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659BE271364BF690014B3A98CB40@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S43 12/15] ice: fix MAC write command
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The manage MAC write command was implemented in an overly complex
> way that actually didn't work, as it wasn't symmetric to the manage MAC
> read command, and was feeding bytes out of order to the firmware. Fix the
> implementation by just using a simple array to represent the MAC address
> when it is being written via firmware command.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 10 ++++------
>  drivers/net/ethernet/intel/ice/ice_common.c     |  5 +----
>  2 files changed, 5 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


