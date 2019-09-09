From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Sep 2019 21:16:46 +0000
Subject: [Intel-wired-lan] [PATCH S29 v2 2/6] ice: Fix FW version
 formatting in dmesg
In-Reply-To: <20190906134626.37344-2-anthony.l.nguyen@intel.com>
References: <20190906134626.37344-1-anthony.l.nguyen@intel.com>
 <20190906134626.37344-2-anthony.l.nguyen@intel.com>
Message-ID: <3d46d2d164d04816b4a423127e4861d0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, September 6, 2019 6:46 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S29 v2 2/6] ice: Fix FW version formatting in
> dmesg
> 
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> The FW build id is currently being displayed as an int which doesn't make
> sense. Instead display FW build id as a hex value. Also add other useful
> information to the output such as NVM version, api patch info, and FW build
> hash.
> 
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  1 -
>  drivers/net/ethernet/intel/ice/ice_common.c  | 23 ++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_common.h  |  3 +++
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 25 --------------------
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 19 +++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.h     |  2 ++
>  drivers/net/ethernet/intel/ice/ice_main.c    |  7 +++---
>  drivers/net/ethernet/intel/ice/ice_type.h    |  2 ++
>  8 files changed, 53 insertions(+), 29 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


