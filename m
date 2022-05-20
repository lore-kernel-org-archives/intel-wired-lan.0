From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 20 May 2022 13:54:34 -0700
Subject: [Intel-wired-lan] [PATCH net] ice: Fix switchdev rules book
 keeping
In-Reply-To: <20220520084527.123885-1-wojciech.drewek@intel.com>
References: <20220520084527.123885-1-wojciech.drewek@intel.com>
Message-ID: <3092a89c-fbfd-b613-827d-337e7c2b633e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 5/20/2022 1:45 AM, Wojciech Drewek wrote:
> Adding two filters with same matching criteria ends up with
> one rule in hardware with act = ICE_FWD_TO_VSI_LIST.
> In order to remove them properly we have to keep the
> information about vsi handle which is used in VSI bitmap
> (ice_adv_fltr_mgmt_list_entry::vsi_list_info::vsi_map).
> 
> Fixes: 0d08a441fb1a ("ice: ndo_setup_tc implementation for PF")
> Reported-by: Sridhar Samudrala<sridhar.samudrala@intel.com>

Need a space between name and email.

> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

This doesn't build:

../drivers/net/ethernet/intel/ice/ice_tc_lib.c: In function 
?ice_eswitch_add_tc_fltr?:
../drivers/net/ethernet/intel/ice/ice_tc_lib.c:527:8: error: ?struct 
ice_tc_flower_fltr? has no member named ?dest_vsi_handle?; did you mean 
?dest_vsi??
   fltr->dest_vsi_handle = rule_added.vsi_handle;
         ^~~~~~~~~~~~~~~
         dest_vsi
