From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Nov 2019 18:40:48 +0000
Subject: [Intel-wired-lan] [PATCH S32 v3 13/15] ice: Introduce and use
 ice_vsi_type_str
In-Reply-To: <20191106100541.48639-13-anthony.l.nguyen@intel.com>
References: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
 <20191106100541.48639-13-anthony.l.nguyen@intel.com>
Message-ID: <85340c0a02d14e60b07aae95aa4540cc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, November 6, 2019 2:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 v3 13/15] ice: Introduce and use
> ice_vsi_type_str
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> ice_vsi_type_str converts an ice_vsi_type enum value to its string
> equivalent. This is expected to help easily identify VSI types from module
> print statements.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 21 ++++++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_lib.h  |  2 ++
> drivers/net/ethernet/intel/ice/ice_main.c | 16 ++++++++--------
>  3 files changed, 30 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


