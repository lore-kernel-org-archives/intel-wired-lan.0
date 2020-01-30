From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 30 Jan 2020 22:53:35 +0000
Subject: [Intel-wired-lan] [PATCH S39 14/15] ice: add support for E823
 devices
In-Reply-To: <20200127085927.13999-14-anthony.l.nguyen@intel.com>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
 <20200127085927.13999-14-anthony.l.nguyen@intel.com>
Message-ID: <b57cb684c2544667a3add61833a14936@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, January 27, 2020 12:59 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 14/15] ice: add support for E823
> devices
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Add E823 device ids and convert conditional expressions to a more
> appropriate switch statement.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_devids.h | 20 +++++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c   | 10 +++++++
>  drivers/net/ethernet/intel/ice/ice_nvm.c    | 32 +++++++++++++++------
>  3 files changed, 53 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


