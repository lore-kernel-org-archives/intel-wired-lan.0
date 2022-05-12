From: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Date: Thu, 12 May 2022 10:39:38 +0200
Subject: [Intel-wired-lan] [PATCH net-next v6 2/2] net: vxlan: Add
 extack support to vxlan_fdb_delete
In-Reply-To: <20220509154603.4a7b4243@kernel.org>
References: <cover.1651762829.git.eng.alaamohamedsoliman.am@gmail.com>
 <ac4b6c650b6519cc56baa32ef20415460a5aa8ee.1651762830.git.eng.alaamohamedsoliman.am@gmail.com>
 <20220509154603.4a7b4243@kernel.org>
Message-ID: <191b395a-996b-597e-4ee9-06722ac3c776@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On ???/??/???? ??:??, Jakub Kicinski wrote:
> On Thu,  5 May 2022 17:09:58 +0200 Alaa Mohamed wrote:
>> +			NL_SET_ERR_MSG(extack,
>> +						  "DST, VNI, ifindex and port are mutually exclusive with NH_ID");
> This continuation line still does not align with the opening bracket.
> Look here if your email client makes it hard to see:
>
> https://lore.kernel.org/all/ac4b6c650b6519cc56baa32ef20415460a5aa8ee.1651762830.git.eng.alaamohamedsoliman.am at gmail.com/
>
> Same story in patch 1:
>
>>   static int ocelot_port_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
>>   			       struct net_device *dev,
>> -			       const unsigned char *addr, u16 vid)
>> +			       const unsigned char *addr, u16 vid,
>> +				   struct netlink_ext_ack *extack)
> and here:
>
>>   static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
>>   			    struct net_device *dev,
>> -			    const unsigned char *addr, u16 vid)
>> +			    const unsigned char *addr, u16 vid,
>> +				struct netlink_ext_ack *extack)


I will fix it, thanks.

