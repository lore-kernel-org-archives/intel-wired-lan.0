From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 18 Apr 2017 21:10:11 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/3] ixgbevf: Fix errors in
 retrieving	RETA and RSS from PF
In-Reply-To: <20170413142607.7364-2-anthony.l.nguyen@intel.com>
References: <20170413142607.7364-1-anthony.l.nguyen@intel.com>
 <20170413142607.7364-2-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA0D90@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, April 13, 2017 7:26 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 2/3] ixgbevf: Fix errors in retrieving RETA
> and RSS from PF
> 
> Mailbox support for getting RETA and RSS is available for only 82599 and x540;
> a previous patch reversed the logic and these adapters were returning not
> supported.
> 
> Also, the NACK check in ixgbevf_get_rss_key_locked() was checking for the
> command IXGBE_VF_GET_RETA instead of IXGBE_VF_GET_RSS_KEY.
> 
> This patch corrects both issues by correcting the logic and checking for the
> right command.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/vf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


