From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 30 Jan 2020 22:52:47 +0000
Subject: [Intel-wired-lan] [PATCH S39 12/15] ice: add backslash-n to
 strings
In-Reply-To: <20200127085927.13999-12-anthony.l.nguyen@intel.com>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
 <20200127085927.13999-12-anthony.l.nguyen@intel.com>
Message-ID: <ef288b93dee94b6ba55580182bc496ed@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S39 12/15] ice: add backslash-n to strings
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> There were several strings found without line feeds, fix them by adding a line
> feed, as is typical.  Without this lotsofmessagescanbejumbledtogether.
> 
> This patch has known checkpatch warnings from long lines for the NL_*
> messages, because checkpatch doesn't know how to ignore them.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c        |  3 +--
>  drivers/net/ethernet/intel/ice/ice_ethtool.c     |  8 ++++----
>  drivers/net/ethernet/intel/ice/ice_main.c        | 12 ++++--------
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  2 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c         |  6 +++---
>  5 files changed, 13 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


