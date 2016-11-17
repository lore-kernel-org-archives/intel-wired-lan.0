From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 Nov 2016 21:23:04 +0000
Subject: [Intel-wired-lan] [next PATCH S53-V2 2/5] i40e: Add support for
 25G	devices
In-Reply-To: <1479157609-30812-2-git-send-email-bimmy.pujari@intel.com>
References: <1479157609-30812-1-git-send-email-bimmy.pujari@intel.com>
 <1479157609-30812-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38060@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 14, 2016 1:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Tieman, Henry W <henry.w.tieman@intel.com>; Joyner, Eric
> <eric.joyner@intel.com>; Kosiarz, Michal <michal.kosiarz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S53-V2 2/5] i40e: Add support for 25G
> devices
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> Add support for 25G devices - defines and data structures.
> 
> One tricky part here is that the firmware support for these Devices
> introduces a mismatch between the PHY type enum and the bitfields for the
> phy types.
> 
> This change creates a macro and uses it to increment the 25G PHY values
> when creating 25G bitfields.

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
25G devices identified correctly, show correct link speed, and pass traffic correctly


