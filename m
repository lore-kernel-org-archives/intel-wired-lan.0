From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 12 Jul 2018 11:05:38 -0700
Subject: [Intel-wired-lan] [PATCH v3 04/11] igc: Add interrupt support
In-Reply-To: <B1C1DF2ACD01FD4881736AA51731BAB22DFF7C93@ORSMSX114.amr.corp.intel.com>
References: <20180624084505.10109-1-sasha.neftin@intel.com>
 <bb91c36c-0a1e-5b13-1233-152918c1908f@oracle.com>
 <918e2d98-4cf1-6f85-b24f-d455c7280be4@intel.com>
 <aaa06623-035b-a4ff-14c9-d6d32b8f1f53@intel.com>
 <7e31b5f3-2319-29fa-85ae-32e674fa7510@oracle.com>
 <B1C1DF2ACD01FD4881736AA51731BAB22DFF7C93@ORSMSX114.amr.corp.intel.com>
Message-ID: <ce527bb7-8ae8-0bf9-c469-14556e07a3bb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/12/2018 10:56 AM, Duyck, Alexander H wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
>> Shannon Nelson
>> Sent: Thursday, July 12, 2018 9:46 AM
>> To: Neftin, Sasha <sasha.neftin@intel.com>; intel-wired-lan at osuosl.org
>> Subject: Re: [Intel-wired-lan] [PATCH v3 04/11] igc: Add interrupt support
>>
>> On 7/12/2018 1:57 AM, Neftin, Sasha wrote:
>>> On 7/3/2018 11:25, Neftin, Sasha wrote:
>>>> On 6/28/2018 02:42, Shannon Nelson wrote:
>>>>> On 6/24/2018 1:45 AM, Sasha Neftin wrote:
>>>>>> This patch set adds interrupt support for the igc interfaces.
>>
>> [...]
>>
>>>>>
>>> I need check it. currently it is consistent with our previously driver.
>>
>> I understand the desire to keep with what is working in other drivers, but in
>> some cases they are showing signs of age and might lead you astray.
>>
>> [...]
>>
>>>>>> +
>>>>>> +??????? if (q_vector->rx.ring && q_vector->tx.ring)
>>>>>> +??????????? sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
>>>>>> +??????????????? q_vector->rx.ring->queue_index);
>>>>>> +??????? else if (q_vector->tx.ring)
>>>>>> +??????????? sprintf(q_vector->name, "%s-tx-%u", netdev->name,
>>>>>> +??????????????? q_vector->tx.ring->queue_index);
>>>>>> +??????? else if (q_vector->rx.ring)
>>>>>> +??????????? sprintf(q_vector->name, "%s-rx-%u", netdev->name,
>>>>>> +??????????????? q_vector->rx.ring->queue_index);
>>>>>
>>>>> Is there any reason to support the tx and rx queues split on
>>>>> different interrupts?
>>>>>
>>> i stayed align with previos driver style. any benefit from change it?
>>
>> With RSS putting certain incoming traffic on one particular Rx/interrupt/CPU, it's
>> good to keep the outgoing response traffic on the same Tx/interrupt/CPU so
>> that you don't have to move data to a different CPU and cache.  This is a general
>> case thing, of course, and I'm sure there are examples of where Tx and Rx on
>> separate interrupts is a useful thing.  However, are the target platforms for this
>> device going to want to spread the Tx and Rx queues across different interrupts?
>>
>> If you can assume that queues are always in pairs on the interrupts you can
>> simplify a bunch of code, which is always a good thing.  You'll want to balance
>> the simplified code against user and design requirements.
>>
>> sln
> 
> Let's avoid requiring a 1:1 mapping between Rx and Tx queues. We have scenerios where more Tx than Rx is useful, and there are scenarios where more Rx than Tx queues are useful. As such I would say we should leave that logic.
> 
> - Alex
> 

Works for me.

Cheers,
sln

