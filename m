From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 21 Feb 2018 08:53:36 -0800
Subject: [Intel-wired-lan] X710 disable flow hashing?
In-Reply-To: <f61e07b4-6728-e636-97bf-6ed9252b23bb@isc.org>
References: <1d4c6e02-2800-1ecb-4e6d-88410837ff8c@isc.org>
 <CAKgT0UdBA9KiCx93xfsYLpw3HhEx+kc1kasR5rRcD5Nekd6Ynw@mail.gmail.com>
 <4709cf54-5c87-d499-65dc-f420e8efb4ae@isc.org>
 <f61e07b4-6728-e636-97bf-6ed9252b23bb@isc.org>
Message-ID: <CAKgT0UcfHEWkfp3gBKqC4yG8umcEctsgq3ty+OJvJw6GgAXv7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Feb 21, 2018 at 2:23 AM, Ray Bellis <ray@isc.org> wrote:
> On 01/02/2018 09:10, Ray Bellis wrote:
>
>> The traffic generator I'm using can only produce a very limited range of
>> source port numbers (24), which is insufficient to produce an even
>> distribution in the queues with flow hashing.
>>
>> ...
>>
>> I suppose that with only 24 source ports I could perhaps create 24
>> individual flow director rules, though?
>
> I'm writing a new traffic generator using AF_PACKET which allows for a
> much wider range of source ports.
>
> I was planning to use Linux's PACKET_FANOUT feature in PACKET_FANOUT_CPU
> mode to have the returned data only be delivered to the CPU core that's
> responsible for a particular port range.
>
> However if I try to specify the mask bits on the dst-port I get this:
>
> --8<--8<--
> # ethtool -U enp5s0f1 flow-type udp4 dst-port 16384 m 0x0fff action 0
> rmgr: Cannot insert RX class rule: Operation not supported
> --8<--8<--
>
> Is dst-port bit masking not supported in this driver or by this card?
> I'm using the latest stable version (i40e v2.4.3)
>
> thanks,
>
> Ray

I don't think the X710 supports bitmasking of the port. You should be
able to mask in/out the entire source or destination port but I don't
think it supports just masking out part of them.

- Alex
