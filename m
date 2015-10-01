From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Oct 2015 18:50:59 +0000
Subject: [Intel-wired-lan] [next PATCH S16 10/15] i40e: reset the
 invalid	msg counter in vf when a valid msg is received
In-Reply-To: <1443463964-148204-11-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
 <1443463964-148204-11-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2CB1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Wu, Jingjing
> Subject: [Intel-wired-lan] [next PATCH S16 10/15] i40e: reset the invalid msg
> counter in vf when a valid msg is received
> 
> From: Jingjing Wu <jingjing.wu@intel.com>
> 
> When the number of invalid messages from a VF is exceeded, the VF will be
> disabled, due to the invalid messages.  This happens if other VF drivers (like
> DPDK) send a message through the driver's mailbox (aka virtchannel)
> interface, but the message is not supported by the i40e pf driver, such as
> CONFIG_PROMISCUOUS_MODE.
> 
> This patch changes the num_invalid_msgs in struct i40e_vf to record the
> continuous invalid msgs, and it will be reset when a valid msg is received.
> 
> Signed-off-by: Jingjing Wu <jingjing.wu@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Iaec42fd3dcdd281476b3518be23261dd46fc3718
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 ++
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
