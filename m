From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 2 Apr 2020 18:38:08 +0200
Subject: [Intel-wired-lan] [PATCH v1] e1000e: Add support for S0ix
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B9714C814@ORSMSX103.amr.corp.intel.com>
References: <20190916065240.41486-1-sasha.neftin@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B9714C814@ORSMSX103.amr.corp.intel.com>
Message-ID: <cf87df61-9a63-5eb3-6589-a29a934bfa93@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Aaron,


Am 11.10.19 um 02:56 schrieb Brown, Aaron F:
>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
>> Sasha Neftin
>> Sent: Sunday, September 15, 2019 11:53 PM
>> To: intel-wired-lan at lists.osuosl.org
>> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>> Subject: [Intel-wired-lan] [PATCH v1] e1000e: Add support for S0ix
>>
>> Implement flow for S0ix support. Modern SoCs support S0ix low power
>> states during idle periods, which are sub-states of ACPI S0 that increase
>> power saving while supporting an instant-on experience for providing
>> lower latency that ACPI S0. The S0ix states shut off parts of the SoC
>> when they are not in use, while still maintaning optimal performance.
>> This patch add support for S0ix started from an Ice Lake platform.
>>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>> ---
>>   drivers/net/ethernet/intel/e1000e/netdev.c | 186
>> +++++++++++++++++++++++++++++
>>   drivers/net/ethernet/intel/e1000e/regs.h   |   4 +
>>   2 files changed, 190 insertions(+)
> 
> I do not yet have access to an Ice lake platform but this does not seem to harm any of my regression systems, so...
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>

Is testing several s2idle cycles part of your testing (with (un)plugging 
the cable)?

Can you reproduce the issues reported on the list [1][2]?


Kind regards,

Paul


[1]: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1865570
[2]: https://bugzilla.redhat.com/show_bug.cgi?id=1816621
