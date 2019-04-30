From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Apr 2019 22:57:58 +0000
Subject: [Intel-wired-lan] [PATCH S21 13/14] ice: Recognize higher speeds
In-Reply-To: <20190416173503.29847-14-anirudh.venkataramanan@intel.com>
References: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
 <20190416173503.29847-14-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39B00C@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S21 13/14] ice: Recognize higher speeds
> 
> In ice_print_link_msg, add cases for 50GB and 100GB speeds. This results in
> the right speed being reported on load, instead of "Unknownbps".
> 
> When VF link if forced (in ice_set_pfe_link_forced), report max speed
> 100GB.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c        | 6 ++++++
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


