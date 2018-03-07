From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Wed, 7 Mar 2018 13:52:00 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 08/18] net: SO_TXTIME: Add
 clockid and drop_if_late params
In-Reply-To: <1520391209.109662.33.camel@gmail.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-9-jesus.sanchez-palencia@intel.com>
 <1520391209.109662.33.camel@gmail.com>
Message-ID: <b612233d-cad6-9fb3-0d08-763bc25553c1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,


On 03/06/2018 06:53 PM, Eric Dumazet wrote:
> On Tue, 2018-03-06 at 17:12 -0800, Jesus Sanchez-Palencia wrote:
>> Extend SO_TXTIME APIs with new per-packet parameters: a clockid_t and
>> a drop_if_late flag. With this commit the API becomes:
>>
>>
> 
>  * diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>  * index d8340e6e8814..951969ceaf65 100644
>  * --- a/include/linux/skbuff.h
>  * +++ b/include/linux/skbuff.h
>  * @@ -788,6 +788,9 @@ struct sk_buff {
>  * ?	__u8			tc_redirected:1;
>  * ?	__u8			tc_from_ingress:1;
>  * ?#endif
>  * +	__u8			tc_drop_if_late:1;
>  * +
>  * +	clockid_t		txtime_clockid;
>  * ?
>  * ?#ifdef CONFIG_NET_SCHED
>  * ?	__u16			tc_index;	/* traffic
>    control index */
> 
> 
> This is adding 32+1 bits to sk_buff, and possibly holes in this very
> very hot (and already too fat) structure.

I should have mentioned on the commit msg, but the tc_drop_if_late is actually
filling a 1 bit hole that was already there.


> 
> Do we really need 32 bits for a clockid_t ?

There is a 2 bytes hole just after tc_index, so a u16 clockid would fit
perfectly without increasing the skbuffs size / cachelines any further.

From Richard's reply, it seems safe to just change the definition here if we
make it explicit on the SCM_CLOCKID documentation the caveat about the max
possible fd count for dynamic clocks.

How does that sound?

Thanks,
Jesus

