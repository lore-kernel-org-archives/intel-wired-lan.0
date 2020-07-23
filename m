From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jul 2020 01:26:18 +0000
Subject: [Intel-wired-lan] [PATCH S49 03/15] ice: split
 ice_discover_caps into two functions
In-Reply-To: <20200709161614.61098-3-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
 <20200709161614.61098-3-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145494F024E8FE3BD4314E58C760@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S49 03/15] ice: split ice_discover_caps into
> two functions
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Using the new ice_aq_list_caps and ice_parse_(dev|func)_caps functions,
> replace ice_discover_caps with two functions that each take a pointer to the
> dev_caps and func_caps structures respectively.
> 
> This makes the side effect of updating the hw->dev_caps and
> hw->func_caps obvious from reading the implementation of the function.
> Additionally, it opens the way for enabling reading of device capabilities
> outside of the initialization flow. By passing in a pointer, another caller will be
> able to read the capabilities without modifying the hw capabilities structures.
> 
> As there are no other callers, it is safe to now remove ice_aq_discover_caps
> and ice_parse_caps.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 94 +++++++++------------
>  1 file changed, 39 insertions(+), 55 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


