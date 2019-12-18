From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:23:38 +0000
Subject: [Intel-wired-lan] [PATCH S35 07/15] ice: Return error on not
 supported ethtool -C parameters
In-Reply-To: <20191212111307.33566-7-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
 <20191212111307.33566-7-anthony.l.nguyen@intel.com>
Message-ID: <6af1ca51bfb541258f0df9a50317642d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, December 12, 2019 3:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S35 07/15] ice: Return error on not
> supported ethtool -C parameters
> 
> From: Michal Swiatkowski <michal.swiatkowski@intel.com>
> 
> Check for all unused parameters, if ethtool sent one of them, print info
> about that and return error.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 50 ++++++++++++++++++++
>  1 file changed, 50 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


