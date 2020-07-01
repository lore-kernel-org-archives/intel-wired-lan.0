From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 1 Jul 2020 16:55:56 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ice: avoid unnecessary
 single-member variable-length structs
In-Reply-To: <20200630002746.64140-1-anthony.l.nguyen@intel.com>
References: <20200630002746.64140-1-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB214500D41C86C0815DB21D038C6C0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, June 29, 2020 5:28 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/2] ice: avoid unnecessary single-member
> variable-length structs
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> There are a number of structures that consist of a one-element array as the
> only struct member.  Some of those are unused so remove them. Others are
> used to index into a buffer/array consisting of a variable number of a
> different data or structure type.  Those are unnecessary since we can use
> simple pointer arithmetic or index directly into the buffer to access individual
> elements of the buffer/array.
> 
> Additional code cleanups were done near areas affected by this change.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 39 +-----------
>  drivers/net/ethernet/intel/ice/ice_common.c   | 29 ++++-----
>  drivers/net/ethernet/intel/ice/ice_common.h   |  2 +-
>  drivers/net/ethernet/intel/ice/ice_dcb.c      |  4 +-
>  drivers/net/ethernet/intel/ice/ice_sched.c    | 61 ++++++++-----------
>  drivers/net/ethernet/intel/ice/ice_sched.h    |  2 +-
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 14 ++---
>  7 files changed, 51 insertions(+), 100 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


