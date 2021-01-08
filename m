From: Shannon Nelson <snelson@pensando.io>
Date: Fri, 8 Jan 2021 11:21:38 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 1/2] net: core: count
 drops from GRO
In-Reply-To: <20210108102630.00004202@intel.com>
References: <20210106215539.2103688-1-jesse.brandeburg@intel.com>
 <20210106215539.2103688-2-jesse.brandeburg@intel.com>
 <1e4ee1cf-c2b7-8ba3-7cb1-5c5cb3ff1e84@pensando.io>
 <20210108102630.00004202@intel.com>
Message-ID: <c11bb25a-f73d-3ae9-b1fd-7eb96bc79cc7@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/8/21 10:26 AM, Jesse Brandeburg wrote:
> Shannon Nelson wrote:
>
>> On 1/6/21 1:55 PM, Jesse Brandeburg wrote:
>>> When drivers call the various receive upcalls to receive an skb
>>> to the stack, sometimes that stack can drop the packet. The good
>>> news is that the return code is given to all the drivers of
>>> NET_RX_DROP or GRO_DROP. The bad news is that no drivers except
>>> the one "ice" driver that I changed, check the stat and increment
>> If the stack is dropping the packet, isn't it up to the stack to track
>> that, perhaps with something that shows up in netstat -s?? We don't
>> really want to make the driver responsible for any drops that happen
>> above its head, do we?
> I totally agree!
>
> In patch 2/2 I revert the driver-specific changes I had made in an
> earlier patch, and this patch *was* my effort to make the stack show the
> drops.
>
> Maybe I wasn't clear. I'm seeing packets disappear during TCP
> workloads, and this GRO_DROP code was the source of the drops (I see it
> returning infrequently but regularly)
>
> The driver processes the packet but the stack never sees it, and there
> were no drop counters anywhere tracking it.
>

My point is that the patch increments a netdev counter, which to my mind 
immediately implicates the driver and hardware, rather than the stack.? 
As a driver maintainer, I don't want to be chasing driver packet drop 
reports that are a stack problem.? I'd rather see a new counter in 
netstat -s that reflects the stack decision and can better imply what 
went wrong.? I don't have a good suggestion for a counter name at the 
moment.

I guess part of the issue is that this is right on the boundary of 
driver-stack.? But if we follow Eric's suggestions, maybe the problem 
magically goes away :-) .

sln

