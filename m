From: David Miller <davem@davemloft.net>
Date: Tue, 25 Feb 2020 13:20:41 -0800 (PST)
Subject: [Intel-wired-lan] [patch net-next] iavf: use
 tc_cls_can_offload_basic() instead of chain check
In-Reply-To: <469b51add666cf3df7381b6409a3972c70024c12.camel@intel.com>
References: <20200225121023.6011-1-jiri@resnulli.us>
 <469b51add666cf3df7381b6409a3972c70024c12.camel@intel.com>
Message-ID: <20200225.132041.1071108395246034738.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 25 Feb 2020 13:15:46 -0800

> On Tue, 2020-02-25 at 13:10 +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@mellanox.com>
>> 
>> Looks like the iavf code actually experienced a race condition, when
>> a
>> developer took code before the check for chain 0 was put to helper.
>> So use tc_cls_can_offload_basic() helper instead of direct check and
>> move the check to _cb() so this is similar to i40e code.
>> 
>> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
> 
> Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> 
> Go ahead and pick this up Dave, thanks!

Hmmm, Jiri this doesn't compile?

  CC [M]  drivers/net/ethernet/intel/iavf/iavf_main.o
drivers/net/ethernet/intel/iavf/iavf_main.c: In function ?iavf_setup_tc_block_cb?:
drivers/net/ethernet/intel/iavf/iavf_main.c:3089:7: error: implicit declaration of function ?tc_cls_can_offload_basic?; did you mean ?tc_cls_common_offload_init?? [-Werror=implicit-function-declaration]
  if (!tc_cls_can_offload_basic(adapter->netdev, type_data))
       ^~~~~~~~~~~~~~~~~~~~~~~~
       tc_cls_common_offload_init

Maybe it does depend upon something in the tc filter patch series?
