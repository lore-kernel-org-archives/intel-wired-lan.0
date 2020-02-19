From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Feb 2020 19:38:45 +0000
Subject: [Intel-wired-lan] [PATCH S39 v2 03/15] ice: Fix for TCAM entry
 management
In-Reply-To: <20200213213129.34023-2-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
 <20200213213129.34023-2-anthony.l.nguyen@intel.com>
Message-ID: <de1e6b8c532d40a6a62fc0e4e43d3bc1@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S39 v2 03/15] ice: Fix for TCAM entry
> management
> 
> From: Dan Nowlin <dan.nowlin@intel.com>
> 
> Order intermediate VSIG list correct in order to correctly match existing VSIG
> lists.
> 
> When overriding pre-existing TCAM entries, properly delete the existing
> entry and remove it from the change/update list.
> 
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 65 +++++++++++++++----
>  1 file changed, 51 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
