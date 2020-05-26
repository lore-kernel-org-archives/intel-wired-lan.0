From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 May 2020 20:25:44 +0000
Subject: [Intel-wired-lan] [PATCH S44 10/14] ice: Poll for reset
 completion when DDP load fails
In-Reply-To: <20200516004226.4795-10-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
 <20200516004226.4795-10-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659DF4FEF20A48B6753A5178CB00@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:42 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S44 10/14] ice: Poll for reset completion
> when DDP load fails
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> There are certain cases where the DDP load fails and the FW issues a core
> reset. For these cases, wait for reset to complete before proceeding with
> reset of the driver init.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


