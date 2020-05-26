From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 May 2020 20:26:58 +0000
Subject: [Intel-wired-lan] [PATCH S44 14/14] ice: Declare functions
 static
In-Reply-To: <20200516004226.4795-14-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
 <20200516004226.4795-14-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659DA6CCFF206343EA5317F8CB00@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S44 14/14] ice: Declare functions static
> 
> ice_get_pfa_module_tlv() and ice_read_sr_word() are not being called
> outside of their file. Declare them as static.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_nvm.c | 5 +++--
> drivers/net/ethernet/intel/ice/ice_nvm.h | 4 ----
>  2 files changed, 3 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


