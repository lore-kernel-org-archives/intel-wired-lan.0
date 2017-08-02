From: Nambiar, Amritha <amritha.nambiar@intel.com>
Date: Tue, 1 Aug 2017 18:12:24 -0700
Subject: [Intel-wired-lan] [PATCH 1/6] [net-next]net: sched: act_mirred:
 Extend redirect action to accept a traffic class
In-Reply-To: <85d57ef2-1c9f-d0e6-a3e8-d65078485afb@mojatatu.com>
References: <150154569340.4135.11548126443780491627.stgit@anamdev.jf.intel.com>
 <150154785793.4135.15194023552358061083.stgit@anamdev.jf.intel.com>
 <85d57ef2-1c9f-d0e6-a3e8-d65078485afb@mojatatu.com>
Message-ID: <558ba1d1-7d1e-50e6-390a-dc8eae1ba3ae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 8/1/2017 3:22 AM, Jamal Hadi Salim wrote:
> On 17-07-31 08:37 PM, Amritha Nambiar wrote:
>> The Mirred/redirect action is extended to forward to a traffic
>> class on the device. The traffic class index needs to be
>> provided in addition to the device's ifindex.
>>
>> Example:
>> # tc filter add dev eth0 protocol ip parent ffff: prio 1 flower\
>>    dst_ip 192.168.1.1/32 ip_proto udp dst_port 22\
>>    skip_sw indev eth0 action mirred ingress redirect dev eth0 tc 1
>>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
>> ---
>>   include/net/tc_act/tc_mirred.h        |    7 +++++++
>>   include/uapi/linux/tc_act/tc_mirred.h |    5 +++++
>>   net/sched/act_mirred.c                |   17 +++++++++++++++++
>>   3 files changed, 29 insertions(+)
>>
>> diff --git a/include/net/tc_act/tc_mirred.h b/include/net/tc_act/tc_mirred.h
>> index 604bc31..60058c4 100644
>> --- a/include/net/tc_act/tc_mirred.h
>> +++ b/include/net/tc_act/tc_mirred.h
>> @@ -9,6 +9,8 @@ struct tcf_mirred {
>>   	int			tcfm_eaction;
>>   	int			tcfm_ifindex;
>>   	bool			tcfm_mac_header_xmit;
>> +	u8			tcfm_tc;
>> +	u32			flags;
>>   	struct net_device __rcu	*tcfm_dev;
>>   	struct list_head	tcfm_list;
>>   };
>> @@ -37,4 +39,9 @@ static inline int tcf_mirred_ifindex(const struct tc_action *a)
>>   	return to_mirred(a)->tcfm_ifindex;
>>   }
>>   
>> +static inline int tcf_mirred_tc(const struct tc_action *a)
>> +{
>> +	return to_mirred(a)->tcfm_tc;
>> +}
>> +
>>   #endif /* __NET_TC_MIR_H */
>> diff --git a/include/uapi/linux/tc_act/tc_mirred.h b/include/uapi/linux/tc_act/tc_mirred.h
>> index 3d7a2b3..8ff4d76 100644
>> --- a/include/uapi/linux/tc_act/tc_mirred.h
>> +++ b/include/uapi/linux/tc_act/tc_mirred.h
>> @@ -9,6 +9,10 @@
>>   #define TCA_EGRESS_MIRROR 2 /* mirror packet to EGRESS */
>>   #define TCA_INGRESS_REDIR 3  /* packet redirect to INGRESS*/
>>   #define TCA_INGRESS_MIRROR 4 /* mirror packet to INGRESS */
>> +
>> +#define MIRRED_F_TC_MAP		0x1
>> +#define MIRRED_TC_MAP_MAX	0x10
> 
> Assuming this is the max number of queues?
> Where does this upper bound come from? Is it a spec
> or an intel thing? If spec - mentioning which
> spec and section would be useful.

This is the max number of TCs. The Linux upper bound for this is defined
in linux/netdevice.h. I will fix this part to remove the definition here
and reuse the existing one.

> 
> cheers,
> jamal
> 
