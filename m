From: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date: Tue, 11 May 2021 10:49:55 -0500
Subject: [Intel-wired-lan] [PATCH][next] ixgbe: Fix out-bounds warning
 in ixgbe_host_interface_command()
In-Reply-To: <MW3PR11MB47483A28574E9F2C5517D3C5EB589@MW3PR11MB4748.namprd11.prod.outlook.com>
References: <20210413190345.GA304933@embeddedor>
 <MW3PR11MB47483A28574E9F2C5517D3C5EB589@MW3PR11MB4748.namprd11.prod.outlook.com>
Message-ID: <b0749fb9-ff4e-3237-e2f7-b97255545eb0@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

On 5/6/21 02:25, Switzer, David wrote:
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>> Gustavo A. R. Silva
>> Sent: Tuesday, April 13, 2021 12:04 PM
>> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Jakub
>> Kicinski <kuba@kernel.org>
>> Cc: Kees Cook <keescook@chromium.org>; netdev at vger.kernel.org; linux-
>> kernel at vger.kernel.org; Gustavo A. R. Silva <gustavoars@kernel.org>; intel-
>> wired-lan at lists.osuosl.org; linux-hardening at vger.kernel.org
>> Subject: [Intel-wired-lan] [PATCH][next] ixgbe: Fix out-bounds warning in
>> ixgbe_host_interface_command()
>>
>> Replace union with a couple of pointers in order to fix the following out-of-
>> bounds warning:
>>
>>  CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_common.o
>> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c: In function
>> ?ixgbe_host_interface_command?:
>> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c:3729:13: warning: array
>> subscript 1 is above array bounds of ?u32[1]? {aka ?unsigned int[1]?} [-Warray-
>> bounds]
>> 3729 |   bp->u32arr[bi] = IXGBE_READ_REG_ARRAY(hw, IXGBE_FLEX_MNG, bi);
>>      |   ~~~~~~~~~~^~~~
>> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c:3682:7: note: while
>> referencing ?u32arr?
>> 3682 |   u32 u32arr[1];
>>      |       ^~~~~~
>>
>> This helps with the ongoing efforts to globally enable -Warray-bounds.
>>
>> Link: https://github.com/KSPP/linux/issues/109
>> Co-developed-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 16 +++++++---------
>> 1 file changed, 7 insertions(+), 9 deletions(-)
>>
> Tested-by: Dave Switzer <david.switzer@intel.com>

Thanks for this, Dave. :)

By the way, we are about to be able to globally enable -Warray-bounds and,
this is one of the last out-of-bounds warnings in linux-next.

Thanks
--
Gustavo
