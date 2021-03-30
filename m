From: Switzer, David <david.switzer@intel.com>
Date: Tue, 30 Mar 2021 20:27:21 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] igb: Add double-check
 MTA_REGISTER for i210 and i211
In-Reply-To: <1614089727-337500-1-git-send-email-grzegorz.siwik@intel.com>
References: <1614089727-337500-1-git-send-email-grzegorz.siwik@intel.com>
Message-ID: <MW3PR11MB4748FE2ED889FDD47DF8343AEB7D9@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Siwik, Grzegorz
>Sent: Tuesday, February 23, 2021 6:15 AM
To: intel-wired-lan@lists.osuosl.org
>Cc: Siwik, Grzegorz <grzegorz.siwik@intel.com>
>Subject: [Intel-wired-lan] [PATCH net-next v1] igb: Add double-check
>MTA_REGISTER for i210 and i211
>
>Add new function which checks MTA_REGISTER if its filled correctly.
>If not then writes again to same register.
>There is possibility that i210 and i211 could not accept MTA_REGISTER settings,
>specially when you add and remove many of multicast addresses in short
>time.
>Without this patch there is possibility that multicast settings will be not always
>set correctly in hardware.
>
>Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
>---
> drivers/net/ethernet/intel/igb/e1000_mac.c | 27
>+++++++++++++++++++++++++++
> 1 file changed, 27 insertions(+)
Tested-by: Dave Switzer <david.switzer@intel.com>


