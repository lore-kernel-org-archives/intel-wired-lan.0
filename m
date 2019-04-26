From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Apr 2019 20:37:29 +0000
Subject: [Intel-wired-lan] [PATCH S18 11/15] ice: Add function to
 program ethertype based filter rule on VSIs
In-Reply-To: <20190416172128.27184-12-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
 <20190416172128.27184-12-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39993C@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S18 11/15] ice: Add function to program
> ethertype based filter rule on VSIs
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch adds function to program VSI with ethertype based filter rule, so
> that all flow control frames would be disallowed from being transmitted to
> the client, in order to prevent malicious VSI, especially VF from sending out
> PAUSE or PFC frames, and then control other VSIs traffic.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice.h        |  2 +
>  drivers/net/ethernet/intel/ice/ice_lib.c    | 55 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_switch.c | 59 +++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_switch.h |  4 ++
>  4 files changed, 120 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


