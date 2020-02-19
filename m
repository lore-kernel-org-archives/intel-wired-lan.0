From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Feb 2020 19:45:33 +0000
Subject: [Intel-wired-lan] [PATCH S39 v2 14/15] ice: add support for
 E823 devices
In-Reply-To: <20200213213129.34023-13-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
 <20200213213129.34023-13-anthony.l.nguyen@intel.com>
Message-ID: <f20630e718ca46be9e751d7a6a88dc51@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 13, 2020 1:31 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 v2 14/15] ice: add support for E823
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


