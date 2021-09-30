From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 30 Sep 2021 04:56:38 +0000
Subject: [Intel-wired-lan] [PATCH net-next v6 4/9] ice: allow adding
 advanced rules
In-Reply-To: <1628239746-17380-5-git-send-email-wojciech.drewek@intel.com>
References: <1628239746-17380-1-git-send-email-wojciech.drewek@intel.com>
 <1628239746-17380-5-git-send-email-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB4554C5A25AE5E05CEF3AB6D19CAA9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Wojciech Drewek
>Sent: Friday, August 6, 2021 2:19 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next v6 4/9] ice: allow adding advanced
>rules
>
>From: Grishma Kotecha <grishma.kotecha@intel.com>
>
>Define dummy packet headers to allow adding advanced rules in HW. This
>header is used as admin queue command parameter for adding a rule.
>The firmware will extract correct fields and will use them in look ups.
>
>Define each supported packets header and offsets to words used in recipe.
>Supported headers:
>- MAC + IPv4 + UDP
>- MAC + VLAN + IPv4 + UDP
>- MAC + IPv4 + TCP
>- MAC + VLAN + IPv4 + TCP
>- MAC + IPv6 + UDP
>- MAC + VLAN + IPv6 + UDP
>- MAC + IPv6 + TCP
>- MAC + VLAN + IPv6 + TCP
>
>Add code for creating an advanced rule. Rule needs to match defined dummy
>packet, if not return error, which means that this type of rule isn't currently
>supported.
>
>The first step in adding advanced rule is searching for an advanced recipe
>matching this kind of rule. If it doesn't exist new recipe is created. Dummy
>packet has to be filled with the correct header field value from the rule
>definition. It will be used to do look up in HW.
>
>Support searching for existing advance rule entry. It is used in case of adding
>the same rule on different VSI. In this case, instead of creating new rule, the
>existing one should be updated with refreshed VSI list.
>
>Add initialization for prof_res_bm_init flag to zero so that the possible
>resource for fv in the files can be initialized.
>
>Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
>Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
>Signed-off-by: Grishma Kotecha <grishma.kotecha@intel.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_common.c |   1 +
> drivers/net/ethernet/intel/ice/ice_switch.c | 832
>+++++++++++++++++++++++++++-  drivers/net/ethernet/intel/ice/ice_switch.h
>|  14 +
> drivers/net/ethernet/intel/ice/ice_type.h   |   1 +
> 4 files changed, 847 insertions(+), 1 deletion(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
