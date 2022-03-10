From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 10 Mar 2022 18:44:42 +0100
Subject: [Intel-wired-lan] [PATCH linux-firmware] ice: update ice DDP
 comms package to 1.3.31.0
In-Reply-To: <20220310164115.2004-1-arjun.anantharam@intel.com>
References: <20220310164115.2004-1-arjun.anantharam@intel.com>
Message-ID: <9bae19f0-1b19-77bd-22b9-52dc84ff5d52@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Arjun,


Am 10.03.22 um 17:41 schrieb Arjun Anantharam:
> Update ice DDP comms package file to the latest version: 1.3.31.0

Could you add a change-log for what happend between 1.3.20.0 and 1.3.31.0?


Kind regards,

Paul


> Signed-off-by: Arjun Anantharam <arjun.anantharam@intel.com>
> ---
>   WHENCE                                        |   2 +-
>   ...ms-1.3.20.0.pkg => ice_comms-1.3.31.0.pkg} | Bin 688388 -> 717176 bytes
>   2 files changed, 1 insertion(+), 1 deletion(-)
>   rename intel/ice/ddp-comms/{ice_comms-1.3.20.0.pkg => ice_comms-1.3.31.0.pkg} (75%)
> 
> diff --git a/WHENCE b/WHENCE
> index 16cc12f..a0f0dc0 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -5880,7 +5880,7 @@ Link: intel/ice/ddp/ice.pkg -> ice-1.3.26.0.pkg
>   
>   License: Redistributable. See LICENSE.ice for details
>   
> -File: intel/ice/ddp-comms/ice_comms-1.3.20.0.pkg
> +File: intel/ice/ddp-comms/ice_comms-1.3.31.0.pkg

[?]
