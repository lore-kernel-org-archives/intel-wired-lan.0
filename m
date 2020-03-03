From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Mar 2020 19:10:52 +0000
Subject: [Intel-wired-lan] [PATCH S40 15/15] ice: fix incorrect size
 description of ice_get_nvm_version
In-Reply-To: <20200227181505.61720-15-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
 <20200227181505.61720-15-anthony.l.nguyen@intel.com>
Message-ID: <0037bbf254ed4a94866c4719eacad706@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 27, 2020 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S40 15/15] ice: fix incorrect size description
> of ice_get_nvm_version
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The function comment for ice_get_nvm_version indicated that the ver_hi
> and ver_lo values were 16 bits. In fact, they are only uint8_t values, meaning
> that they have a maximum size of 8 bits. Fix the comment to match the
> correct size.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


