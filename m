From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 30 Sep 2021 04:55:07 +0000
Subject: [Intel-wired-lan] [PATCH net-next v6 7/9] ice: Allow changing
 lan_en and lb_en on all kinds of filters
In-Reply-To: <1628239746-17380-8-git-send-email-wojciech.drewek@intel.com>
References: <1628239746-17380-1-git-send-email-wojciech.drewek@intel.com>
 <1628239746-17380-8-git-send-email-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB4554D2C9C85B4F18B4C23C129CAA9@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v6 7/9] ice: Allow changing lan_en
>and lb_en on all kinds of filters
>
>From: Michal Swiatkowski <michal.swiatkowski@intel.com>
>
>There is no way to change default lan_en and lb_en flags while adding new
>rule. Add function that allows changing these flags on rule determined by rule
>id and recipe id.
>
>Function checks if the rule is presented on regular rules list or advance rules
>list and call the appropriate function to update rule entry.
>
>As rules with ICE_SW_LKUP_DFLT recipe aren't tracked in a list, implement
>function which updates flags without searching for rules based only on rule id.
>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_fltr.c | 127
>++++++++++++++++++++++++++++++
> 1 file changed, 127 insertions(+)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
