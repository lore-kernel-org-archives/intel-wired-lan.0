From: Pujari, Bimmy <bimmy.pujari@intel.com>
Date: Mon, 14 Nov 2016 21:06:59 +0000
Subject: [Intel-wired-lan] [next PATCH S53 3/5] i40e: Add FEC for 25g
In-Reply-To: <178d1f9e-7645-525f-21d4-2721abc7f8a9@onemain.com>
References: <1478895384-23904-1-git-send-email-bimmy.pujari@intel.com>
 <1478895384-23904-3-git-send-email-bimmy.pujari@intel.com>
 <178d1f9e-7645-525f-21d4-2721abc7f8a9@onemain.com>
Message-ID: <B759292EEECB5C46AEDF3EC46470BC94AD47CC@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fixed it.

-----Original Message-----
From: Shannon Nelson [mailto:sln at onemain.com] 
Sent: Saturday, November 12, 2016 12:13 PM
To: Pujari, Bimmy <bimmy.pujari@intel.com>; intel-wired-lan at lists.osuosl.org
Cc: Naczyk, Jacek <jacek.naczyk@intel.com>
Subject: Re: [Intel-wired-lan] [next PATCH S53 3/5] i40e: Add FEC for 25g



On 11/11/2016 12:16 PM, Bimmy Pujari wrote:
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
>
> This patch adds adminq support for Forward Error Correction ("FEC")for 
> 25g products.

[...]

> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h 
> b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
> index f8d7d95..267c698 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
> @@ -28,7 +28,7 @@
>   #define _I40E_ADMINQ_CMD_H_
>   
>   /* This header file defines the i40e Admin Queue commands and is 
> shared between
> - * i40e Firmware and Software.
> + * i40e Fitruct i40e_aq_set_phy_configmware and Software.

Huh?

sln
