From: Alex Duyck <aduyck@mirantis.com>
Date: Tue, 24 May 2016 10:46:10 -0700
Subject: [Intel-wired-lan] [net-next PATCH 0/2] Follow-ups for GUEoIPv6
	patches
In-Reply-To: <1464110072.2631.13.camel@intel.com>
References: <20160518173605.2608.42484.stgit@localhost.localdomain>
 <1463606878.2713.68.camel@intel.com>
 <20160518.211043.773402183440053556.davem@davemloft.net>
 <1464110072.2631.13.camel@intel.com>
Message-ID: <CAMt9YRqHXFQ9uo-qZrJcJfz28uiMWaLRMukC4KJgt09U4yvf1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 24, 2016 at 10:14 AM, Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
> On Wed, 2016-05-18 at 21:10 -0700, David Miller wrote:
>> From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>> Date: Wed, 18 May 2016 14:27:58 -0700
>>
>> > On Wed, 2016-05-18 at 10:44 -0700, Alexander Duyck wrote:
>> >> This patch series is meant to be applied after:
>> >> [PATCH v7 net-next 00/16] ipv6: Enable GUEoIPv6 and more fixes for v6
>> >> tunneling
>> >>
>> >> The first patch addresses an issue we already resolved in the GREv4
>> and
>> >> is
>> >> now present in GREv6 with the introduction of FOU/GUE for IPv6 based
>> GRE
>> >> tunnels.
>> >>
>> >> The second patch goes through and enables IPv6 tunnel offloads for the
>> >> Intel
>> >> NICs that already support the IPv4 based IP-in-IP tunnel offloads.  I
>> >> have
>> >> only done a bit of touch testing but have seen ~20 Gb/s over an i40e
>> >> interface using a v4-in-v6 tunnel, and I have verified IPv6 GRE is
>> still
>> >> passing traffic at around the same rate.  I plan to do further testing
>> >> but
>> >> with these patches present it should enable a wider audience to be
>> able
>> >> to
>> >> test the new features introduced in Tom's patchset with hardware
>> >> offloads.
>> >>
>> >> ---
>> >>
>> >> Alexander Duyck (2):
>> >>       ip6_gre: Do not allow segmentation offloads GRE_CSUM is enabled
>> >> with FOU/GUE
>> >>       intel: Add support for IPv6 IP-in-IP offload
>> >
>> > Dave, I have this series added to my queue.
>>
>> Why would you if it depends upon Tom's series, as mentioned above, which
>> isn't even in my tree yet?
>
> I was not able to apply his patches to my dev-queue due to conflicts and
> from discussion with Alex, I made the mistake in assuming the issues I saw
> was because it did not have Tom's driver changes.

I thought Dave had already applied the patches to his tree?  If so
there shouldn't be a need for you to pull them in and apply them.
That might also be the source of the conflicts if they are already in
the tree.

- Alex
