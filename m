From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 2 Aug 2017 08:01:07 -0400
Subject: [Intel-wired-lan] [PATCH net-next RFC 0/6] Configure cloud
 filters in i40e via tc/flower classifier
In-Reply-To: <78fbc08d-f846-a3e4-ffbd-f0cba43780e3@intel.com>
References: <150154569340.4135.11548126443780491627.stgit@anamdev.jf.intel.com>
 <2d833571-a5f3-41a6-0e6c-9d2c27b0a8c5@mojatatu.com>
 <78fbc08d-f846-a3e4-ffbd-f0cba43780e3@intel.com>
Message-ID: <146b5375-5d70-bb65-74aa-5c19c1de7daf@mojatatu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 17-08-01 08:57 PM, Nambiar, Amritha wrote:
> 
> On 8/1/2017 3:15 AM, Jamal Hadi Salim wrote:
>> On 17-07-31 08:36 PM, Amritha Nambiar wrote:

>>>
>>> # tc filter add dev eth0 protocol ip parent ffff: prio 1 flower\
>>>     dst_ip 192.168.1.1/32 ip_proto udp dst_port 22\
>>>     skip_sw indev eth0 action mirred ingress redirect dev eth0 tc 1
>>>
>>
>> I think "queue 1" sounds better than "tc 1".
>> "tc" is  already a keyword in a few places (even within that declaration
>> above).
> 
> The idea is to redirect to a traffic class that has queues assigned to
> it and not a single queue i.e. these are actually queue groups and not a
> single queue. So may be "qgroup 1" or "tcqgroup 1" fits better.
> 

Can you describe how this works? So the specific memeber of a
a tcgroups show up on a specific rx DMA ring? If you only have
16 and 512 RX DMA rings - how does that work?

cheers,
jamal
