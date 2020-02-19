From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Feb 2020 19:43:09 +0000
Subject: [Intel-wired-lan] [PATCH S39 v2 12/15] ice: add backslash-n to
 strings
In-Reply-To: <20200213213129.34023-11-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
 <20200213213129.34023-11-anthony.l.nguyen@intel.com>
Message-ID: <0e64c42f8d5340fda100646840030e21@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S39 v2 12/15] ice: add backslash-n to strings
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


