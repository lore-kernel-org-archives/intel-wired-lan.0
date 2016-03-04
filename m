From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Thu, 03 Mar 2016 16:59:01 -0800
Subject: [Intel-wired-lan] [net-next] ixgbe: fix error handling in tc
 cls_u32 offload routines
In-Reply-To: <56D8D728.3050304@gmail.com>
References: <1457047192-17092-1-git-send-email-sridhar.samudrala@intel.com>
 <56D8D6DA.7080702@gmail.com> <56D8D728.3050304@gmail.com>
Message-ID: <56D8DDD5.1020503@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 3/3/2016 4:30 PM, John Fastabend wrote:
> On 16-03-03 04:29 PM, John Fastabend wrote:
>> On 16-03-03 03:42 PM, Jeff Kirsher wrote:
>>> From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
>>>
>>> Check for handle ids when adding/deleting hash nodes OR adding/deleting
>>> filter entries and limit them to max number of links or header nodes
>>> supported(IXGBE_MAX_LINK_HANDLE).
>>>
>>> Start from bit 0 when setting hash table bit-map.(adapter->tables)
>>>
>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>> ---
>>>
>>> Sending this to the correct mailing list (get_maintainer.pl is your
>>> friend, please use it in the future)
>>>
>>>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 52 +++++++++++++++++----------
>>>   1 file changed, 34 insertions(+), 18 deletions(-)
>>>
>>
>> Looks like a good cleanup to me.
>>
>> Acked-by: John Fastabend <john.r.fastabend@intel.com>
>>
> Also just checking Sridhar you tested both the adding just to
> the first list e.g. matching ip address for example and doing
> matches deeper in the stack ala match on sport/dport?

Yes.

I tested adding matches on src/dst ip on the root hash table and matches 
on tcp src port on the link hash table.

tc filter add dev p4p1 parent ffff: protocol ip prio 99 handle 800:0:1 
u32 ht 800: match ip dst 15.0.0.1/32 match ip src 15.0.0.2/32 action drop

This creates the following flow director rule as seen via ethtool

Filter: 1
     Rule Type: Raw IPv4
     Src IP addr: 15.0.0.2 mask: 0.0.0.0
     Dest IP addr: 15.0.0.1 mask: 0.0.0.0
     TOS: 0x0 mask: 0xff
     Protocol: 0 mask: 0xff
     L4 bytes: 0x0 mask: 0xffffffff
     VLAN EtherType: 0x0 mask: 0xffff
     VLAN: 0x0 mask: 0xffff
     User-defined: 0x0 mask: 0xffffffffffffffff
     Action: Drop

To do tcp matches,  i had to delete ip match rule in the root hash 
table,  create a new hash table linked to the root and add a filter 
entry to that table.

c filter del dev p4p1 parent ffff: protocol ip prio 99 handle 800:0:1 u32
tc filter add dev p4p1 parent ffff: protocol ip prio 99 handle 1: u32 
divisor 1
tc filter add dev p4p1 protocol ip parent ffff: prio 99 u32 ht 800: 
order 2 link 1: offset at 0 mask 0f00 shift 6 plus 0 eat match ip 
protocol 6 ff
tc filter add dev p4p1 parent ffff: protocol ip prio 99 u32 ht 1: order 
3 match tcp src 23 ffff action drop

This creates the following  flow director rule
Filter: 3
     Rule Type: TCP over IPv4
     Src IP addr: 0.0.0.0 mask: 255.255.255.255
     Dest IP addr: 0.0.0.0 mask: 255.255.255.255
     TOS: 0x0 mask: 0xff
     Src port: 23 mask: 0x0
     Dest port: 0 mask: 0xffff
     VLAN EtherType: 0x0 mask: 0xffff
     VLAN: 0x0 mask: 0xffff
     User-defined: 0x0 mask: 0xffffffffffffffff
     Action: Drop

Looks like we cannot have both these rules at the same time.

Also, more work is required to support matches on both ip as well as tcp 
headers in the same rule.

Thanks
Sridhar
