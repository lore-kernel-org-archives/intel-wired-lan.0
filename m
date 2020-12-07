From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 07 Dec 2020 14:11:48 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 1/9] ethtool: Add support
 for configuring frame preemption
In-Reply-To: <20201205094325.790b187f@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
References: <20201202045325.3254757-1-vinicius.gomes@intel.com>
 <20201202045325.3254757-2-vinicius.gomes@intel.com>
 <20201205094325.790b187f@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Message-ID: <87eek11d23.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jakub Kicinski <kuba@kernel.org> writes:

>> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
>> index e3da25b51ae4..16d6ee29a6ac 100644
>> --- a/include/linux/ethtool.h
>> +++ b/include/linux/ethtool.h
>> @@ -263,6 +263,19 @@ struct ethtool_pause_stats {
>>  	u64 rx_pause_frames;
>>  };
>>  
>> +/**
>> + * struct ethtool_fp - Frame Preemption information
>> + *
>> + * @enabled: Enable frame preemption.
>> + *
>
> The empty line between members seems unnecessary.

Will fix.

>
>> + * @min_frag_size_mult: Minimum size for all non-final fragment size,
>> + * expressed in terms of X in '(1 + X)*64 + 4'
>
> Is this way of expressing the min frag size from the standard?
>

The standard has this: "A 2-bit integer value indicating, in units of 64
octets, the minimum number of octets over 64 octets required in
non-final fragments by the receiver" from IEEE 802.3br-2016, Table
79-7a.

>> + */
>> +struct ethtool_fp {
>> +	u8 enabled;
>> +	u8 min_frag_size_mult;
>> +};
>
>> +	int	(*get_preempt)(struct net_device *,
>> +			       struct ethtool_fp *);
>> +	int	(*set_preempt)(struct net_device *,
>> +			       struct ethtool_fp *);
>
> Since this is a new op we should probably pass extack to the drivers?

Yes. Will fix.

>
>>  extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
>>  extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
>> @@ -375,6 +376,8 @@ extern const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_HEADER +
>>  extern const struct nla_policy ethnl_cable_test_act_policy[ETHTOOL_A_CABLE_TEST_HEADER + 1];
>>  extern const struct nla_policy ethnl_cable_test_tdr_act_policy[ETHTOOL_A_CABLE_TEST_TDR_CFG + 1];
>>  extern const struct nla_policy ethnl_tunnel_info_get_policy[ETHTOOL_A_TUNNEL_INFO_HEADER + 1];
>> +extern const struct nla_policy ethnl_preempt_get_policy[ETHTOOL_A_PREEMPT_MAX + 1];
>> +extern const struct nla_policy ethnl_preempt_set_policy[ETHTOOL_A_PREEMPT_MAX + 1];
>
> Let's make the size
>
> ETHTOOL_A_PREEMPT_MIN_FRAG_SIZE_MULT + 1
>
> for set, and
>
> ETHTOOL_A_PREEMPT_HEADER + 1
>
> for get, like the other tables
>
>> +const struct nla_policy
>> +ethnl_preempt_get_policy[ETHTOOL_A_PREEMPT_MAX + 1] = {
>> +	[ETHTOOL_A_PREEMPT_UNSPEC]		= { .type = NLA_REJECT },
>
> Unnecessary, NLA_REJECT is 0.
>
>> +	[ETHTOOL_A_PREEMPT_HEADER]		= { .type = NLA_NESTED },
>
> Please specify nested policy
>
>> +	[ETHTOOL_A_PREEMPT_ENABLED]		= { .type = NLA_REJECT },
>> +	[ETHTOOL_A_PREEMPT_MIN_FRAG_SIZE_MULT]	= { .type = NLA_REJECT },
>
> Unnecessary
>
>> +const struct nla_policy
>> +ethnl_preempt_set_policy[ETHTOOL_A_PREEMPT_MAX + 1] = {
>> +	[ETHTOOL_A_PREEMPT_UNSPEC]			= { .type = NLA_REJECT },
>> +	[ETHTOOL_A_PREEMPT_HEADER]			= { .type = NLA_NESTED },
>> +	[ETHTOOL_A_PREEMPT_ENABLED]			= { .type = NLA_U8 },
>
> Set the right netlink policy to check the value is <= 1.
>
>> +	[ETHTOOL_A_PREEMPT_MIN_FRAG_SIZE_MULT]		= { .type = NLA_U8 },
>> +};


Will fix these netlink validation issues.


Cheers,
-- 
Vinicius
