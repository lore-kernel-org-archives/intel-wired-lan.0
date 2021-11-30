From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Tue, 30 Nov 2021 12:25:47 +0100
Subject: [Intel-wired-lan] [PATCH net-next 2/2] igc: enable XDP metadata
 in driver
In-Reply-To: <9948428f33d013105108872d51f7e6ebec21203c.camel@intel.com>
References: <163700856423.565980.10162564921347693758.stgit@firesoul>
 <163700859087.565980.3578855072170209153.stgit@firesoul>
 <20211126161649.151100-1-alexandr.lobakin@intel.com>
 <6de05aea-9cf4-c938-eff2-9e3b138512a4@redhat.com>
 <20211129145303.10507-1-alexandr.lobakin@intel.com>
 <20211129181320.579477-1-alexandr.lobakin@intel.com>
 <9948428f33d013105108872d51f7e6ebec21203c.camel@intel.com>
Message-ID: <e462ac19-0598-5b68-eab9-93358b7e7a57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 29/11/2021 20.03, Nguyen, Anthony L wrote:
> On Mon, 2021-11-29 at 19:13 +0100, Alexander Lobakin wrote:
>> From: Alexander Lobakin <alexandr.lobakin@intel.com>
>> Date: Mon, 29 Nov 2021 15:53:03 +0100
>>
>>> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
>>> Date: Mon, 29 Nov 2021 15:39:04 +0100
>>>
>>>> On 26/11/2021 17.16, Alexander Lobakin wrote:
>>>>> From: Jesper Dangaard Brouer <brouer@redhat.com>
>>>>> Date: Mon, 15 Nov 2021 21:36:30 +0100
>>>>>
>>>>>> Enabling the XDP bpf_prog access to data_meta area is a very
>>>>>> small
>>>>>> change. Hint passing 'true' to xdp_prepare_buff().
>>
>> [ snip ]
[ snip ]
>>
>>>
>>>> Tony is it worth resending a V2 of this patch?
>>>
>>> Tony, you can take it as it is if you want, I'll correct it later
>>> in
>>> mine. Up to you.
>>
>> My "fixup" looks like (in case of v2 needed or so):
> 
> Thanks Al. If Jesper is ok with this, I'll incorporate it in before
> sending the pull request to netdev. Otherwise, you can do it as follow
> on in the other series you previously referenced.

I'm fine with you incorporating this change. Thanks! :-)
--Jesper

