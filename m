From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Tue, 2 Nov 2021 23:04:01 +0000
Subject: [Intel-wired-lan] [PATCH net-next 5/7] ice: Add package PTYPE
 enable information
In-Reply-To: <20210716221644.45946-6-anthony.l.nguyen@intel.com>
References: <20210716221644.45946-1-anthony.l.nguyen@intel.com>
 <20210716221644.45946-6-anthony.l.nguyen@intel.com>
Message-ID: <MN2PR11MB4224A40260DB75531B49EA43828B9@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Nguyen, Anthony L
> Sent: Friday, July 16, 2021 3:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 5/7] ice: Add package PTYPE
> enable information
> 
> From: Haiyue Wang <haiyue.wang@intel.com>
> 
> Scan the 'Marker Ptype TCAM' section to retrieve the Rx parser PTYPE enable
> information from the current package.
> 
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 76 +++++++++++++++++++
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |  4 +
>  .../net/ethernet/intel/ice/ice_flex_type.h    | 20 +++++
>  drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
>  4 files changed, 101 insertions(+)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


