From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 30 Sep 2021 04:57:17 +0000
Subject: [Intel-wired-lan] [PATCH net-next v6 5/9] ice: allow deleting
 advanced rules
In-Reply-To: <1628239746-17380-6-git-send-email-wojciech.drewek@intel.com>
References: <1628239746-17380-1-git-send-email-wojciech.drewek@intel.com>
 <1628239746-17380-6-git-send-email-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB4554E9F386622F55006AB69C9CAA9@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v6 5/9] ice: allow deleting advanced
>rules
>
>From: Shivanshu Shukla <shivanshu.shukla@intel.com>
>
>To remove advanced rule the same protocols list like in adding should be send
>to function. Based on this information list of advanced rules is searched to
>find the correct rule id.
>
>Remove advanced rule if it forwards to only one VSI. If it forwards to list of VSI
>remove only input VSI from this list.
>
>Introduce function to remove rule by id. It is used in case rule needs to be
>removed even if it forwards to the list of VSI.
>
>Allow removing all advanced rules from a particular VSI. It is useful in
>rebuilding VSI path.
>
>Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
>Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
>Signed-off-by: Shivanshu Shukla <shivanshu.shukla@intel.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_switch.c | 223
>++++++++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_switch.h |   6 +
> 2 files changed, 229 insertions(+)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
