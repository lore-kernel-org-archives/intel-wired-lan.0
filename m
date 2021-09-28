From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 28 Sep 2021 05:51:10 +0000
Subject: [Intel-wired-lan] [PATCH net-next v6 3/9] ice: create advanced
 switch recipe
In-Reply-To: <1628239746-17380-4-git-send-email-wojciech.drewek@intel.com>
References: <1628239746-17380-1-git-send-email-wojciech.drewek@intel.com>
 <1628239746-17380-4-git-send-email-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB45543D9E79121408D862CB899CA89@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v6 3/9] ice: create advanced switch
>recipe
>
>From: Dan Nowlin <dan.nowlin@intel.com>
>
>These changes introduce code for creating advanced recipes for the
>switch in hardware.
>
>There are a couple of recipes already defined in the HW. They apply to
>matching on basic protocol headers, like MAC, VLAN, MACVLAN,
>ethertype or direction (promiscuous), etc.. If the user wants to match on
>other protocol headers (eg. ip address, src/dst port etc.) or different
>variation of already supported protocols, there is a need to create
>new, more complex recipe. That new recipe is referred as
>'advanced recipe', and the filtering rule created on top of that recipe
>is called 'advanced rule'.
>
>One recipe can have up to 5 words, but the first word is always reserved
>for match on switch id, so the driver can define up to 4 words for one
>recipe. To support recipes with more words up to 5 recipes can be
>chained, so 20 words can be programmed for look up.
>
>Input for adding recipe function is a list of protocols to support. Based
>on this list correct profile is being chosen. Correct profile means
>that it contains all protocol types from a list. Each profile have up to
>48 field vector words and each of this word have protocol id and offset.
>These two fields need to match with input data for adding recipe
>function. If the correct profile can't be found the function returns an
>error.
>
>The next step after finding the correct profile is grouping words into
>groups. One group can have up to 4 words. This is done to simplify
>sending recipes to HW (because recipe also can have up to 4 words).
>
>In case of chaining (so when look up consists of more than 4 words) last
>recipe will always have results from the previous recipes used as words.
>
>A recipe to profile map is used to store information about which profile
>is associate with this recipe. This map is an array of 64 elements (max
>number of recipes) and each element is a 256 bits bitmap (max number of
>profiles)
>
>Profile to recipe map is used to store information about which recipe is
>associate with this profile. This map is an array of 256 elements (max
>number of profiles) and each element is a 64 bits bitmap (max number of
>recipes)
>
>Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_flex_pipe.c     |   33 +-
> drivers/net/ethernet/intel/ice/ice_flex_pipe.h     |    6 +
> drivers/net/ethernet/intel/ice/ice_protocol_type.h |  169 +++
> drivers/net/ethernet/intel/ice/ice_switch.c        | 1112
>+++++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_switch.h        |  110 +-
> 5 files changed, 1410 insertions(+), 20 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
