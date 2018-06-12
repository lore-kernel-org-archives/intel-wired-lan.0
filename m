From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 12 Jun 2018 15:18:13 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 2/7] net: Add
 support for subordinate device traffic classes
In-Reply-To: <f4eaac32-204e-259d-b69b-c2c9885d55fa@gmail.com>
References: <20180612151322.86792.97587.stgit@ahduyck-green-test.jf.intel.com>
 <20180612151835.86792.93718.stgit@ahduyck-green-test.jf.intel.com>
 <f4eaac32-204e-259d-b69b-c2c9885d55fa@gmail.com>
Message-ID: <CAKgT0UeC3Ewcffq0GT8F+6StK0-eH-8MqqiSHpr55yWB-DHNBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jun 12, 2018 at 10:49 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 06/12/2018 08:18 AM, Alexander Duyck wrote:
>> This patch is meant to provide the basic tools needed to allow us to create
>> subordinate device traffic classes. The general idea here is to allow
>> subdividing the queues of a device into queue groups accessible through an
>> upper device such as a macvlan.
>>
>> The idea here is to enforce the idea that an upper device has to be a
>> single queue device, ideally with IFF_NO_QUQUE set. With that being the
>> case we can pretty much guarantee that the tc_to_txq mappings and XPS maps
>> for the upper device are unused. As such we could reuse those in order to
>> support subdividing the lower device and distributing those queues between
>> the subordinate devices.
>
> This is not necessarily a valid paradigm to work with. For instance in
> DSA we have IFF_NO_QUEUE devices, but we still expose multiple egress
> queues because that is how an application can choose how it wants to get
> packets transmitted at the switch level. We have a 1:1 representation
> between a queue at the net_device level, and what an egress queue at the
> switch level is, so things like buffer reservation etc. can be configured.

I'm not saying that IFF_NO_QUEUE implies that a device is single
queue, but in this case we enforce that the upper device has to be a
single queue device so that the code in netdev_pick_tx will ignore the
XPS and tc_to_txq mappings for that netdev. I had mentioned
IFF_NO_QUEUE as a suggestion as that allows us to avoid head-of-line
blocking if the lower device starts to apply back-pressure.

> I think you should consider that an upper device might want to have a
> 1:1 mapping to the lower device's queues and make that permissible.
> Thoughts?

I had considered that. However the issue becomes that at that point it
makes the setup much more rigid. With this approach I can enable and
disable the offload without needing to stop the upper device to either
create or remove qdiscs. I would much rather keep the upper device
generic and leave it to the lower device to populate the rings and
such.
