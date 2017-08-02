From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 2 Aug 2017 08:02:15 -0400
Subject: [Intel-wired-lan] [PATCH 6/6] [net-next]net: i40e: Enable cloud
 filters in i40e via tc/flower classifier
In-Reply-To: <30cd59b5-4175-8641-f288-a2373475837d@intel.com>
References: <150154569340.4135.11548126443780491627.stgit@anamdev.jf.intel.com>
 <150154788503.4135.7051219373661945937.stgit@anamdev.jf.intel.com>
 <f93480af-9ae0-2e02-7b11-78f8ab53899c@mojatatu.com>
 <30cd59b5-4175-8641-f288-a2373475837d@intel.com>
Message-ID: <382b07c6-562b-9dc6-a4be-8f82819ab87a@mojatatu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 17-08-01 10:13 PM, Nambiar, Amritha wrote:
> 
> On 8/1/2017 3:56 AM, Jamal Hadi Salim wrote:
>> On 17-07-31 08:38 PM, Amritha Nambiar wrote:
>>> This patch enables tc-flower based hardware offloads. tc/flower
>>> filter provided by the kernel is configured as driver specific
>>> cloud filter. The patch implements functions and admin queue
>>> commands needed to support cloud filters in the driver and
>>> adds cloud filters to configure these tc-flower filters.
>>>
>>> The only action supported is to redirect packets to a traffic class
>>> on the same device.
>>>
>>> # tc qdisc add dev eth0 ingress
>>> # ethtool -K eth0 hw-tc-offload on
>>>
>>> # tc filter add dev eth0 protocol ip parent ffff:\
>>>     prio 1 flower dst_mac 3c:fd:fe:a0:d6:70 skip_sw indev eth0\
>>>     action mirred ingress redirect dev eth0 tc 0
>>>
>>
>> Out of curiosity - did you need to say "indev eth0" there?
> 
> It looks like I don't need to specify "indev eth0". I will need to look
> up how this part is offloaded and probably validate in the driver when
> this is specified.
> 
>> Also: Is it possible to add an skbmark? Example something like
>> these that directs two flows to the same queue but different
>> skb marks:
>>
>> # tc filter add dev eth0 protocol ip parent ffff: \
>>     prio 2 flower dst_ip 192.168.3.5/32 \
>>     ip_proto udp dst_port 2a skip_sw \
>>     action skbedit mark 11 \
>>     action mirred ingress redirect dev eth0 tcqueue 1
>>
>> # tc filter add dev eth0 protocol ip parent ffff: \
>>       prio 1 flower dst_mac 3c:fd:fe:a0:d6:70 skip_sw \
>>       action skbedit mark 12 \
>>       action mirred ingress redirect dev eth0 tcqueue 1
>>
> 
> It is possible to support the skbedit mark action for the first rule
> here (L3 and L4) which I can take up in a subsequent patch, but this
> cannot be supported on our device for L2 based match in the second rule.
> 

Ok, thanks. So the issue is one of hardware limitation?

cheers,
jamal
