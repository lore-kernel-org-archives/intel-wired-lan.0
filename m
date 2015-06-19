From: Young, James M <james.m.young@intel.com>
Date: Fri, 19 Jun 2015 23:14:24 +0000
Subject: [Intel-wired-lan] [net-next PATCH S5 11/15 v2] i40e/i40evf: Fix
 and refactor dynamic ITR code
In-Reply-To: <CAL3LdT6THJw3WaDt9pwN710twzWvY2da9BnqfDSoDYkHG7_X5g@mail.gmail.com>
References: <1433958127-222743-1-git-send-email-catherine.sullivan@intel.com>
 <CAL3LdT6THJw3WaDt9pwN710twzWvY2da9BnqfDSoDYkHG7_X5g@mail.gmail.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1A1D0@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> ---------- Forwarded message ----------
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> Date: Wed, Jun 10, 2015 at 10:42 AM
> Subject: [Intel-wired-lan] [net-next PATCH S5 11/15 v2] i40e/i40evf:
> Fix and refactor dynamic ITR code
> To: intel-wired-lan at lists.osuosl.org
> Cc: Anjali Singhai Jain <anjali.singhai@intel.com>, Akeem G Abodunrin
> <akeem.g.abodunrin@intel.com>
> 
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch changes the switch statement for dynamic interrupt throttling and
> adds a default case. With this patch, we check the latency setting instead of
> the current ITR settings and the included refactor improves performance.
> 
> Without this patch, the ITR setting would never change dynamically, and
> there was no default.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Mitch Willivam <mitch.a.williams@intel.com>
> Change-ID: Idb5a8a14c7109ec47c90f6e94bd43baa17d7ee37
> ---
> v2: Fix i40e_update_enable_itr in i40evf/i40e_txrx.c to write the register
> I40E_VF_INT_DYN_CTLN1 instead of I40E_VF_INT_DYN_CTLN in two places.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 146 ++++++++++++++++-----
> -----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 113 +++++++++++++-------
>  2 files changed, 161 insertions(+), 98 deletions(-)
>
Tested-by: Jim Young <james.m.young@intel.com>

Retested in ww25 with v2 patch. 
