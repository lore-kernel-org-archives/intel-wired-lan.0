From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 8 Sep 2015 21:10:39 +0000
Subject: [Intel-wired-lan] [next PATCH S11 10/15] i40e: Never let speed
 get	set to 0 in get_settings
In-Reply-To: <1440616461-110869-11-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
 <1440616461-110869-11-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5AEF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, August 26, 2015 12:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S11 10/15] i40e: Never let speed get
> set to 0 in get_settings
> 
> In ethtool, there is a possibility of speed getting set to 0 if advertise is set to 0
> (which it is when autoneg is disabled).
> We never want this to happen as the firmware will actually attempt to set
> the speed to 0 sending link down, so add an extra check to make sure this
> doesn't happen.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I62e0eeee2cbf043d8e6f5c9c9f0b92794e877f01
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, speed does not get set to 0 with autoneg off (shows proper speed)
