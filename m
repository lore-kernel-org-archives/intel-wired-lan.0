From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Nov 2019 18:49:17 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Set PHY Access flag on X722
In-Reply-To: <20191106142356.48768-1-alice.michael@intel.com>
References: <20191106142356.48768-1-alice.michael@intel.com>
Message-ID: <b20627593e0c4d70b06afd76a1565e1f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, November 6, 2019 6:24 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Ludkiewicz, Adam <adam.ludkiewicz@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: Set PHY Access flag on X722
> 
> From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
> 
> The X722 FW API version 1.9 adds support for accessing PHY registers with
> Admin Queue Command. This enables reading EEPROM data from (Q)SFP+
> transceivers, what was previously possible only on X710 devices.
> 
> Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c     | 5 +++++
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 2 ++
>  2 files changed, 7 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


