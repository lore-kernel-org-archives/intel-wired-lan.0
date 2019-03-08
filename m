From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:52:21 +0000
Subject: [Intel-wired-lan] [PATCH S13 v2 13/17] ice: Get VF VSI
 instances directly via PF
In-Reply-To: <20190227003523.28733-14-anirudh.venkataramanan@intel.com>
References: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
 <20190227003523.28733-14-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368F94@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 26, 2019 4:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S13 v2 13/17] ice: Get VF VSI instances
> directly via PF
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch changes how we get VF VSIs instances. Instead of relying on
> mailbox virtual channel message to retrieve VSI, it is more reliable getting it
> directly via VF object in PF data structure.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 35
> ++++++++++++++++++------
>  1 file changed, 27 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


