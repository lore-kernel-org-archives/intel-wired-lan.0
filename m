From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 28 Oct 2016 07:58:53 -0700
Subject: [Intel-wired-lan] [net-next PATCH 3/3] net: Add support for XPS
 with QoS via traffic classes
In-Reply-To: <CALx6S36F=6R12O6Xb-WfhruOQN7S6QjOite7PVW2JqNK5BtWYg@mail.gmail.com>
References: <20161027153539.13989.14349.stgit@ahduyck-blue-test.jf.intel.com>
 <20161027154014.13989.33421.stgit@ahduyck-blue-test.jf.intel.com>
 <CALx6S36F=6R12O6Xb-WfhruOQN7S6QjOite7PVW2JqNK5BtWYg@mail.gmail.com>
Message-ID: <CAKgT0UcZY4eKP0ezsijiJquqGKEwap8kA3Kqmg0BRYL8JF_90g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Oct 27, 2016 at 7:38 PM, Tom Herbert <tom@herbertland.com> wrote:
> On Thu, Oct 27, 2016 at 8:40 AM, Alexander Duyck
> <alexander.h.duyck@intel.com> wrote:
>> This patch adds support for setting and using XPS when QoS via traffic
>> classes is enabled.  With this change we will factor in the priority and
>> traffic class mapping of the packet and use that information to correctly
>> select the queue.
>>
>> This allows us to define a set of queues for a given traffic class via
>> mqprio and then configure the XPS mapping for those queues so that the
>> traffic flows can avoid head-of-line blocking between the individual CPUs
>> if so desired.
>>
> Does this change the sys API for XPS? Is it up the user to know which
> are priority queues in sys?

The idea was to keep the change transparent.  So for now the only
change in relation to XPS from the XPS point of view is that the map
for a given queue is invalidated when either the dev->num_tcs changes
or if the queue is moved into a dev->tx_to_txq mapping.  Otherwise the
interface should behave exactly the same as before.

One thing I could look at doing is adding a read-only sysfs value that
the user could use to identify which traffic class a given queue
belongs to.  Then at least that way they would be able to dump both
the XPS map and the tc to determine how the traffic will flow through
the device.

Thanks.

- Alex
