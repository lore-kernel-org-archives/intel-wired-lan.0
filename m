From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 23:18:00 +0000
Subject: [Intel-wired-lan] [PATCH S14 08/15] ice: Prevent unintended
 multiple chain resets
In-Reply-To: <20190213185115.25877-9-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
 <20190213185115.25877-9-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D36717C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, February 13, 2019 10:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S14 08/15] ice: Prevent unintended
> multiple chain resets
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> In the current implementation of ice_reset_subtask, if multiple reset types
> are set in the pf->state, the most intrusive one is meant to be performed
> only, but the bits requesting the other types are not being cleared. This
> would lead to another reset being performed the next time the service task
> is scheduled.
> 
> Change the flow of ice_reset_subtask so that all reset request bits in
> pf->state are cleared, and we still perform the most intrusive of the
> resets requested.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


