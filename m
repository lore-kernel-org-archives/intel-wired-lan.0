From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 9 Nov 2018 18:27:36 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Fix possible NULL pointer
 de-reference
In-Reply-To: <20181107181935.10337-1-anirudh.venkataramanan@intel.com>
References: <20181107181935.10337-1-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D329D24@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, November 7, 2018 10:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ice: Fix possible NULL pointer de-
> reference
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> A recent update to smatch is causing it to report the error "we previously
> assumed 'm_entry->vsi_list_info' could be null". Fix that.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


