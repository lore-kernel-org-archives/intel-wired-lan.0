From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 15 Mar 2022 22:26:33 -0700
Subject: [Intel-wired-lan] [PATCH -next] ice: clean up one inconsistent
 indenting
In-Reply-To: <20220316000307.66863-1-yang.lee@linux.alibaba.com>
References: <20220316000307.66863-1-yang.lee@linux.alibaba.com>
Message-ID: <6fda3983-a32f-c78c-0150-37593bf5db68@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/15/2022 5:03 PM, Yang Li wrote:
> Eliminate the follow smatch warning:
> drivers/net/ethernet/intel/ice/ice_switch.c:5568 ice_find_dummy_packet()
> warn: inconsistent indenting
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks but this patch has already been submitted on intel-wired-lan, as 
it was already reported by the kernel test robot.

https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20220314164314.15218-1-marcin.szycik at linux.intel.com/

As well, the other inconsistent indent patch is also fixed at
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20220314164137.15101-1-marcin.szycik at linux.intel.com/

They will probably be sent to net-next tomorrow in the PDT timezone.

Thanks!
