From: Young, James M <james.m.young@intel.com>
Date: Mon, 1 Jun 2015 17:12:13 +0000
Subject: [Intel-wired-lan] [net-next S5 11/15] i40e/i40evf: Fix and
 refactor	dynamic ITR code
In-Reply-To: <1430161042-28494-12-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
 <1430161042-28494-12-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA08BC8@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, April 27, 2015 11:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Singhai, Anjali; Abodunrin, Akeem G
> Subject: [Intel-wired-lan] [net-next S5 11/15] i40e/i40evf: Fix and refactor
> dynamic ITR code
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch changes the switch statement for dynamic interrupt throttling
> and adds a default case. With this patch, we check the latency setting
> instead of the current ITR settings and the included refactor improves
> performance.
> 
> Without this patch, the ITR setting would never change dynamically, and
> there was no default.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Idb5a8a14c7109ec47c90f6e94bd43baa17d7ee37
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 146 ++++++++++++++++---------
> -
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 113 +++++++++++++-------
>  2 files changed, 161 insertions(+), 98 deletions(-)

Patch failed
James.m.young at intel.com


