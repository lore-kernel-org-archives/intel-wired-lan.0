From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Jan 2016 22:34:47 +0000
Subject: [Intel-wired-lan] [next PATCH S25 07/16] i40e:
	fix	write-back-on-itr to work with legacy itr
In-Reply-To: <1450901156-30904-8-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
 <1450901156-30904-8-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98CAB5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Wednesday, December 23, 2015 12:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S25 07/16] i40e: fix write-back-on-itr
> to work with legacy itr
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> We were not doing write-back on interrupt throttle for Legacy case in X722.
> This patch fixes that, so we do WB_ON_ITR for Legacy as well. Plus the issue
> that we should still be setting NO_ITR if we are touching the DYN_CTLN
> register since we do not want to change ITR setting here.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I5db8491ee1544118a389db839cecc93e1bbc480e
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 18 +++++++++++++-----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  3 ++-
>  2 files changed, 15 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
4 tx_timeouts observed with ~10hr of stress traffic, driver properly recovered, continued to pass traffic normally. tx_force_wb at 5 million
