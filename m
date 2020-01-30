From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 30 Jan 2020 22:38:59 +0000
Subject: [Intel-wired-lan] [PATCH S39 03/15] ice: Fix for TCAM entry
 management
In-Reply-To: <20200127085927.13999-3-anthony.l.nguyen@intel.com>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
 <20200127085927.13999-3-anthony.l.nguyen@intel.com>
Message-ID: <d8ce43b5a8a54c25973c80ee3c6545b4@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S39 03/15] ice: Fix for TCAM entry
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


