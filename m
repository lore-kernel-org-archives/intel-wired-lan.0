From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 22:21:52 +0000
Subject: [Intel-wired-lan] [PATCH S9 07/15] ice: Cleanup duplicate
 control queue code
In-Reply-To: <20181026184447.13547-8-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
 <20181026184447.13547-8-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328DF9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 11:45 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S9 07/15] ice: Cleanup duplicate control
> queue code
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> 1. Assigning the register offset and mask values contains duplicate code
>    that can easily be replaced with a macro.
> 
> 2. Separate functions for freeing send queue and receive queue rings are
>    not needed; replace with a single function that uses a pointer to the
>    struct ice_ctl_q_ring structure as a parameter instead of a pointer to
>    the struct ice_ctl_q_info structure.
> 
> 3. Initializing register settings for both send queue and receive queue
>    contains duplicate code that can easily be replaced with a helper
>    function.
> 
> 4. Separate functions for freeing send queue and receive queue buffers are
>    not needed; duplicate code can easily be replaced with a macro.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> squashed
> mutiple commits]
> ---
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 218 +++++++++----------------
> -
>  1 file changed, 76 insertions(+), 142 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


