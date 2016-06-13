From: Tom Herbert <tom@herbertland.com>
Date: Mon, 13 Jun 2016 12:31:26 -0700
Subject: [Intel-wired-lan] [net-next PATCH 02/15] net: Merge VXLAN and
 GENEVE push notifiers into a single notifier
In-Reply-To: <77eb25b2-d775-ec6f-c945-524d73113c96@redhat.com>
References: <20160613173750.15186.24381.stgit@localhost.localdomain>
 <20160613174806.15186.64702.stgit@localhost.localdomain>
 <77eb25b2-d775-ec6f-c945-524d73113c96@redhat.com>
Message-ID: <CALx6S35MsGtRyxYiOi389w05v8y=pG6fXZC3spj8OZKDTeh=Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jun 13, 2016 at 10:57 AM, Hannes Frederic Sowa
<hannes@redhat.com> wrote:
> Hi Alex,
>
> very cool series!
>
> On 13.06.2016 19:48, Alexander Duyck wrote:
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index d101e4d904ba..e959b6348f91 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -1269,6 +1269,14 @@ struct net_device_ops {
>>       void                    (*ndo_del_geneve_port)(struct  net_device *dev,
>>                                                      sa_family_t sa_family,
>>                                                      __be16 port);
>> +     void                    (*ndo_add_udp_enc_port)(struct  net_device *dev,
>> +                                                    sa_family_t sa_family,
>> +                                                    __be16 port,
>> +                                                    unsigned int type);
>> +     void                    (*ndo_del_udp_enc_port)(struct  net_device *dev,
>> +                                                    sa_family_t sa_family,
>> +                                                    __be16 port,
>> +                                                    unsigned int type);
>>       void*                   (*ndo_dfwd_add_station)(struct net_device *pdev,
>>                                                       struct net_device *dev);
>>       void                    (*ndo_dfwd_del_station)(struct net_device *pdev,
>
> What do you think about adding a struct as argument to
> ndo_*_udp_enc_port? As a result we can much easier add new fields in
> case future NICs allow us to e.g. specify a bound ip address?
>
This is why I think we should be using ntuple filtering for
encapsulation instead perpetuating the notion that encapsulation
offload can only be done based on receive ports.

Tom

> Thanks,
> Hannes
>
