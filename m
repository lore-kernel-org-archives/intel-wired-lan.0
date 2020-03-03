From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Mar 2020 19:06:36 +0000
Subject: [Intel-wired-lan] [PATCH S40 07/15] ice: Fix corner case when
 switching from IEEE to CEE
In-Reply-To: <20200227181505.61720-7-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
 <20200227181505.61720-7-anthony.l.nguyen@intel.com>
Message-ID: <45da74d3b855413fa243612fe4861d94@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S40 07/15] ice: Fix corner case when
> switching from IEEE to CEE
> 
> From: Avinash JD <avinash.dayanand@intel.com>
> 
> While testing DCB for a corner case in which mode is switched from IEEE to
> CEE and pfc_ena bitmask unchanged then DCBX mode doesn't get updated.
> 
> This is happening because the function ice_dcb_get_mode() is called in a "no
> change detected block" instead of "change detected block".
> 
> Signed-off-by: Avinash JD <avinash.dayanand@intel.com>
> Signed-off-by: Scott Register <scottx.register@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


