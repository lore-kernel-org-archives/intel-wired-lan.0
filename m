From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Mar 2019 23:49:18 +0000
Subject: [Intel-wired-lan] [PATCH S15 04/14] ice: Do not bail out when
 filter already exists
In-Reply-To: <20190219230414.25627-5-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
 <20190219230414.25627-5-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3675AD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 19, 2019 3:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S15 04/14] ice: Do not bail out when filter
> already exists
> 
> From: Preethi Banala <preethi.banala@intel.com>
> 
> If filter already exists, do not go through error path flow but instead continue
> to process rest of the function. Hence have an appropriate check after
> adding MAC filters.
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


