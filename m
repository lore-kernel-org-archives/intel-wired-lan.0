From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Tue, 2 Mar 2021 10:29:23 +0200
Subject: [Intel-wired-lan] [PATCH net 1/2] e1000e: Fix duplicate include
 guard
In-Reply-To: <20210222040005.20126-1-tseewald@gmail.com>
References: <20210222040005.20126-1-tseewald@gmail.com>
Message-ID: <4b289f9c-b7ca-c48e-de4b-b83b6b540da3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/22/2021 06:00, Tom Seewald wrote:
> The include guard "_E1000_HW_H_" is used by header files in three
> different drivers (e1000/e1000_hw.h, e1000e/hw.h, and igb/e1000_hw.h).
> Using the same include guard macro in more than one header file may
> cause unexpected behavior from the compiler. Fix the duplicate include
> guard in the e1000e driver by renaming it.
> 
> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
> Signed-off-by: Tom Seewald <tseewald@gmail.com>
> ---
>   drivers/net/ethernet/intel/e1000e/hw.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
> index 69a2329ea463..db79c4e6413e 100644
> --- a/drivers/net/ethernet/intel/e1000e/hw.h
> +++ b/drivers/net/ethernet/intel/e1000e/hw.h
> @@ -1,8 +1,8 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /* Copyright(c) 1999 - 2018 Intel Corporation. */
>   
> -#ifndef _E1000_HW_H_
> -#define _E1000_HW_H_
> +#ifndef _E1000E_HW_H_
> +#define _E1000E_HW_H_
>   
>   #include "regs.h"
>   #include "defines.h"
> @@ -714,4 +714,4 @@ struct e1000_hw {
>   #include "80003es2lan.h"
>   #include "ich8lan.h"
>   
> -#endif
> +#endif /* _E1000E_HW_H_ */
> 
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
