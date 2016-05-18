From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 18 May 2016 16:19:35 -0700
Subject: [Intel-wired-lan] [net-next PATCH 0/2] Follow-ups for GUEoIPv6
	patches
In-Reply-To: <1463606878.2713.68.camel@intel.com>
References: <20160518173605.2608.42484.stgit@localhost.localdomain>
 <1463606878.2713.68.camel@intel.com>
Message-ID: <CAKgT0UexDWi0axSiR7GWz5jz91oLbjqqz7zPNWL+jyPf4bfLew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, May 18, 2016 at 2:27 PM, Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
> On Wed, 2016-05-18 at 10:44 -0700, Alexander Duyck wrote:
>> This patch series is meant to be applied after:
>> [PATCH v7 net-next 00/16] ipv6: Enable GUEoIPv6 and more fixes for v6
>> tunneling
>>
>> The first patch addresses an issue we already resolved in the GREv4 and
>> is
>> now present in GREv6 with the introduction of FOU/GUE for IPv6 based GRE
>> tunnels.
>>
>> The second patch goes through and enables IPv6 tunnel offloads for the
>> Intel
>> NICs that already support the IPv4 based IP-in-IP tunnel offloads.  I
>> have
>> only done a bit of touch testing but have seen ~20 Gb/s over an i40e
>> interface using a v4-in-v6 tunnel, and I have verified IPv6 GRE is still
>> passing traffic at around the same rate.  I plan to do further testing
>> but
>> with these patches present it should enable a wider audience to be able
>> to
>> test the new features introduced in Tom's patchset with hardware
>> offloads.
>>
>> ---
>>
>> Alexander Duyck (2):
>>       ip6_gre: Do not allow segmentation offloads GRE_CSUM is enabled
>> with FOU/GUE
>>       intel: Add support for IPv6 IP-in-IP offload
>
> Dave, I have this series added to my queue.

Jeff,

If Tom's patches make it in for 4.7, then I would like to see if we
could push these patches for "net" since essentially the first patch
is a fix for Tom's earlier patches and the second is needed in order
to really be able to test Tom's patches with a driver that actually
supports a hardware offload.

Thanks.

- Alex
