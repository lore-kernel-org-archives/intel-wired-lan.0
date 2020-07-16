From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Jul 2020 17:45:51 +0000
Subject: [Intel-wired-lan] [PATCH S50 05/15] ice: return correct error
 code from ice_aq_sw_rules
In-Reply-To: <20200713205318.32425-5-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
 <20200713205318.32425-5-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21452BF5A905E918F70F34C38C7F0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, July 13, 2020 1:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S50 05/15] ice: return correct error code
> from ice_aq_sw_rules
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> Return ICE_ERR_DOES_NOT_EXIST return code if admin command error code
> is ICE_AQ_RC_ENOENT (not exist). ice_aq_sw_rules is used when switch rule
> is getting added/deleted/updated. In case of delete/update switch rule,
> admin command can return ICE_AQ_RC_ENOENT error code if such rule does
> not exist, hence return ICE_ERR_DOES_NOT_EXIST error code from
> ice_aq_sw_rule, so that caller of this function can decide how to handle
> ICE_ERR_DOES_NOT_EXIST.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


