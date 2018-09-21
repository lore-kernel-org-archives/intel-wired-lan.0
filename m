From: Alexei Starovoitov <ast@fb.com>
Date: Fri, 21 Sep 2018 15:14:43 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: check return value of
 napi_complete_done()
In-Reply-To: <e6afa0d0-ba22-8205-076c-6a259a9f1b52@gmail.com>
References: <20180920190113.490005-1-songliubraving@fb.com>
 <c1251d5d-4b18-a1de-acd2-6de829b7c7ac@gmail.com>
 <2ca0e823642d232092017f66e8151652e22e74a1.camel@intel.com>
 <0DAF1AF9-E98D-4D0F-BD68-F5936A0312C6@fb.com>
 <ee9b9a55-c967-cec3-7df1-79f84b06154c@gmail.com>
 <E4A7BD0D-B091-4FBD-94A9-F0104729DCF6@fb.com>
 <028b4cea-0e3f-fab5-7a74-cf003bbd1134@gmail.com>
 <ACD41205-3FDD-4FD2-BF36-897DD98D63EC@fb.com>
 <74672b30-1627-efcd-383f-adda6cdf486f@gmail.com>
 <71fd1305-17ad-2bdc-c123-9bc0ab37b0a4@fb.com>
 <e6afa0d0-ba22-8205-076c-6a259a9f1b52@gmail.com>
Message-ID: <d15e9eec-6236-af26-0eb5-84e7dc27b4d7@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/21/18 7:59 AM, Eric Dumazet wrote:
>
>
> On 09/21/2018 07:55 AM, Alexei Starovoitov wrote:
>
>>
>> should we remove ndo_poll_controller then?
>> My understanding that the patch helps by not letting
>> drivers do napi_schedule() for all queues into this_cpu, right?
>> But most of the drivers do exactly that in their ndo_poll_controller
>> implementations. Means most of the drivers will experience
>> this nasty behavior.
>>
>
> Some legacy drivers do not use NAPI yet, but provide ndo_poll_controller()
>
> I believe users caring about system behavior with multi queue NIC are
> all using NAPI enabled drivers, so this should be fine.

I'm not following.
All modern napi enabled drivers need to _remove_ ndo_poll_controller
from the driver. This is a lot of churn.
Isn't it cleaner (less error prone) to introduce new ndo
for legacy drivers without napi?

