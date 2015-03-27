From: Vlad Zolotarov <vladz@cloudius-systems.com>
Date: Fri, 27 Mar 2015 12:53:53 +0300
Subject: [Intel-wired-lan] [PATCH net-next v2 0/2] ixgbe: Add the
 appropriate ethtool ops to query RSS indirection table and key
In-Reply-To: <1427429878.2497.46.camel@jtkirshe-mobl>
References: <1427409886-20261-1-git-send-email-vladz@cloudius-systems.com>
 <1427429878.2497.46.camel@jtkirshe-mobl>
Message-ID: <551528B1.90303@cloudius-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 03/27/15 07:17, Jeff Kirsher wrote:
> On Fri, 2015-03-27 at 00:44 +0200, Vlad Zolotarov wrote:
>> Add the ethtool ops to VF driver to allow querying the RSS indirection
>> table
>> and RSS Random Key.
>>
>> This series refactors the RSS configuration code to store the current
>> contents of
>> RSS indirection table and Hash Key in the "adapter" struct so that we
>> won't need
>> to access registers every time this info is queried.
>>
>> New in v2:
>>     - Some styling fixes.
>>     - Moved macros definitions from ixgbe_type.h to ixgbe.h.
>>
>> Vlad Zolotarov (2):
>>    ixgbe: Refactor the RSS configuration code.
>>    ixgbe: Add the appropriate ethtool ops to query RSS indirection
>> table
>>      and key
> I am assuming that this series is to replace the latest v8 series,
> correct?

This series is a precondition for v9. I have prepared it and waited for 
this series to get it... I'll send it on Sunday.

Have a nice weekend...


