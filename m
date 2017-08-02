From: Nambiar, Amritha <amritha.nambiar@intel.com>
Date: Tue, 1 Aug 2017 17:57:06 -0700
Subject: [Intel-wired-lan] [PATCH net-next RFC 0/6] Configure cloud
 filters in i40e via tc/flower classifier
In-Reply-To: <2d833571-a5f3-41a6-0e6c-9d2c27b0a8c5@mojatatu.com>
References: <150154569340.4135.11548126443780491627.stgit@anamdev.jf.intel.com>
 <2d833571-a5f3-41a6-0e6c-9d2c27b0a8c5@mojatatu.com>
Message-ID: <78fbc08d-f846-a3e4-ffbd-f0cba43780e3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 8/1/2017 3:15 AM, Jamal Hadi Salim wrote:
> On 17-07-31 08:36 PM, Amritha Nambiar wrote:
>> This patch series enables configuring cloud filters in i40e
>> using the tc/flower classifier. The only tc-filter action
>> supported is to redirect packets to a traffic class on the
>> same device. The tc/mirred:redirect action is extended to
>> accept a traffic class to achieve this.
>>
>> The cloud filters are added for a VSI and are cleaned up when
>> the VSI is deleted. The filters that match on L4 ports needs
>> enhanced admin queue functions with big buffer support for
>> extended general fields in Add/Remove Cloud filters command.
>>
>> Example:
>> # tc qdisc add dev eth0 ingress
>>
>> # ethtool -K eth0 hw-tc-offload on
>>
>> # tc filter add dev eth0 protocol ip parent ffff: prio 1 flower\
>>    dst_ip 192.168.1.1/32 ip_proto udp dst_port 22\
>>    skip_sw indev eth0 action mirred ingress redirect dev eth0 tc 1
>>
> 
> I think "queue 1" sounds better than "tc 1".
> "tc" is  already a keyword in a few places (even within that declaration
> above).

The idea is to redirect to a traffic class that has queues assigned to
it and not a single queue i.e. these are actually queue groups and not a
single queue. So may be "qgroup 1" or "tcqgroup 1" fits better.

> 
> cheers,
> jamal
> 
