From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 16 Mar 2018 11:07:12 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v4 6/8] igb: Add MAC
 address support for ethtool nftuple filters
In-Reply-To: <87muz7vr4n.fsf@intel.com>
References: <20180308003713.29195-1-vinicius.gomes@intel.com>
 <20180308003713.29195-7-vinicius.gomes@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C8032A0@ORSMSX101.amr.corp.intel.com>
 <CAKgT0Uf3MmMRELo0c11Aqah92+shLFASzPkZxE6OzGU5bjvzfA@mail.gmail.com>
 <87muz7vr4n.fsf@intel.com>
Message-ID: <CAKgT0UchtULE4YT30JQbORS6O=g20cjkmodX7UHkn6E-N9jxrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Mar 16, 2018 at 10:59 AM, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
> Hi,
>
> Alexander Duyck <alexander.duyck@gmail.com> writes:
>
>> On Tue, Mar 13, 2018 at 8:04 PM, Brown, Aaron F <aaron.f.brown@intel.com> wrote:
>>>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
>>>> Behalf Of Vinicius Costa Gomes
>>>> Sent: Wednesday, March 7, 2018 4:37 PM
>>>> To: intel-wired-lan at lists.osuosl.org
>>>> Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
>>>> palencia at intel.com>
>>>> Subject: [Intel-wired-lan] [next-queue PATCH v4 6/8] igb: Add MAC address
>>>> support for ethtool nftuple filters
>>>>
>>>> This adds the capability of configuring the queue steering of arriving
>>>> packets based on their source and destination MAC addresses.
>>>>
>>>> In practical terms this adds support for the following use cases,
>>>> characterized by these examples:
>>>>
>>>> $ ethtool -N eth0 flow-type ether dst aa:aa:aa:aa:aa:aa action 0
>>>> (this will direct packets with destination address "aa:aa:aa:aa:aa:aa"
>>>> to the RX queue 0)
>>>>
>>>> $ ethtool -N eth0 flow-type ether src 44:44:44:44:44:44 action 3
>>>> (this will direct packets with source address "44:44:44:44:44:44" to
>>>> the RX queue 3)
>>>
>>> This seems to work fine on i210, and the patch series allows me to set the rx filters on the i350, i354 and i211, but it is not directing the packets to the queue I request.
>>>
>>> With the exception of i210 the rx_queues number does not seem to be effected by setting the filter.  In the case of i211 the rx packets stay on rx_queue 0 with or without an ether src or dst filter.  The first example one seems to work at first since it's directing to queue 0, but changing the filter to "action 1" does not change the behavior.  With the i350 and i354 ports the packets are spread across the rx_queues with or without the filter set.
>>
>> Do any of the other parts actually support this functionality? I don't
>> think they do.
>
> From what I can see, the only other part that supports queue steering (by MAC
> addresses) is the 82575. But as I don't have any of those handy, making
> it work only for the i210 seems more reasonable, to avoid getting into
> this situation again.

That sounds good to me. What you might do is add a comment explaining
that this is only supported on 82575 and i210 wherever you put the
check that limits this. Then if we have time for the
development/validation efforts, or someone in the community does they
could take it upon themselves to enable and test it for 82575.

I have done similar things in the past. As long as it is clear that
the reason why we limited it to i210 is mostly because of
development/validation resources somebody else can come along and
enable it if they have the resources and time to invest in doing so.
