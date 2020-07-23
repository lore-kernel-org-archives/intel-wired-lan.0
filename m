From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jul 2020 01:26:41 +0000
Subject: [Intel-wired-lan] [PATCH S49 02/15] ice: split ice_parse_caps
 into separate functions
In-Reply-To: <20200709161614.61098-2-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
 <20200709161614.61098-2-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21458F5F374DCD53A54F18A58C760@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, July 9, 2020 9:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S49 02/15] ice: split ice_parse_caps into
> separate functions
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_parse_caps function is used to convert the capability block data
> coming from firmware into a structured format used by other parts of the
> code.
> 
> The current implementation directly updates the hw->func_caps and
> hw->dev_caps structures. It is directly called from within
> ice_aq_discover_caps. This causes the discover_caps function to have the
> side effect of modifying the hw capability structures, which is not intuitive.
> 
> Split this function into ice_parse_dev_caps and ice_parse_func_caps.
> These functions will take a pointer to the dev_caps and func_caps
> respectively. Also create an ice_parse_common_caps for sharing the
> capability logic that is common to device and function.
> 
> Doing so enables a future refactor to allow reading and parsing capabilities
> into a local caps structure instead of modifying the members of the hw
> structure directly.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 548 ++++++++++++++------
>  1 file changed, 378 insertions(+), 170 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


