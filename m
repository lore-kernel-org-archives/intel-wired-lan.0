From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Nov 2018 00:43:34 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Change req_speeds to be u16
In-Reply-To: <20181105201835.2166-1-anirudh.venkataramanan@intel.com>
References: <20181105201835.2166-1-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3295D0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Monday, November 5, 2018 12:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ice: Change req_speeds to be u16
> 
> From: Chinh T Cao <chinh.t.cao@intel.com>
> 
> Since the req_speeds field in struct ice_link_status is a u8, req_speeds &
> ICE_AQ_LINK_SPEED_40GB always returns 0. This was caught by a coverity
> scan.
> 
> Fix this by changing req_speeds to be u16.
> 
> Reported-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote
> commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_type.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


