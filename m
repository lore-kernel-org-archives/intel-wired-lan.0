From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Fri, 04 Mar 2016 14:16:26 -0800
Subject: [Intel-wired-lan] [PATCH net-next] net: ixgbe: Fix cls_u32
 offload support for ports and fields with masks.
In-Reply-To: <1457129413.2936.27.camel@intel.com>
References: <1457120869-3489-1-git-send-email-sridhar.samudrala@intel.com>
 <1457129413.2936.27.camel@intel.com>
Message-ID: <56DA093A.8010500@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 3/4/2016 2:10 PM, Jeff Kirsher wrote:
> On Fri, 2016-03-04 at 11:47 -0800, Sridhar Samudrala wrote:
>> Fix support for 16 bit source/dest port matches in ixgbe model.
>> u32 uses a single 32-bit key value for both source and destination
>> ports
>> starting at offset 0. So replace the 2 functions with a single
>> function
>> that takes this key value/mask to program both source and dest ports.
>>
>> Remove the incorrect check for mask in ixgbe_configure_clsu32()
>>
>> Tested with the following filters:
>>
>>   #tc qdisc add dev p4p1 ingress
>>   #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
>>          handle 800:0:1 u32 ht 800: \
>>          match ip dst 11.0.0.1/24 match ip src 11.0.0.2/24 action drop
>>
>>   #tc filter del dev p4p1 parent ffff: protocol ip prio 99 \
>>          handle 800:0:1 u32
>>   #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
>>          handle 1: u32 divisor 1
>>   #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
>>          handle 800:0:10 u32 ht 800: link 1: \
>>          offset at 0 mask 0f00 shift 6 plus 0 eat match ip protocol 6
>> ff
>>   #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
>>          handle 1:0:10 u32 ht 1: \
>>          match tcp src 1024 ffff match tcp dst 80 ffff action drop
>>
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  3 +--
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_model.h | 17 ++++----------
>> ---
>>   2 files changed, 5 insertions(+), 15 deletions(-)
> Is this v2?  If not, why are you re-sending a patch that is already in
> my queue?  If so, where is the changelog so we know what changed in
> this updated v2 of the patch?
No. This is another patch that fixes other issues on top of the previous 
one.

Thanks
Sridhar

