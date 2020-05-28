From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 23:20:06 +0000
Subject: [Intel-wired-lan] [PATCH S46 7/9] ice: Use coalesce values from
 q_vector 0 when increasing q_vectors
In-Reply-To: <20200516005506.5113-7-anthony.l.nguyen@intel.com>
References: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
 <20200516005506.5113-7-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659F3FD9950A7DF12482C098C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S46 7/9] ice: Use coalesce values from
> q_vector 0 when increasing q_vectors
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when a VSI is built (i.e. reset, set channels, etc.) the coalesce
> settings will be preserved in most cases. However, when the number of
> q_vectors are increased the settings for the new q_vectors will be set to the
> driver defaults of AIM on, Rx/Tx ITR 50, and INTRL 0.
> This is causing issues with how the ethtool layer gets the current coalesce
> settings since it only uses q_vector 0. So, assume that the user set the
> coalesce settings globally (i.e. ethtool -C eth0) and use q_vector 0's settings
> for all of the new q_vectors.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


