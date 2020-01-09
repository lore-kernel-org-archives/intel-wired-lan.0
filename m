From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 9 Jan 2020 10:50:23 -0800
Subject: [Intel-wired-lan] [PATCH 3/4] devlink: add support for
 triggering snapshots from userspace
In-Reply-To: <20200109070502.GC2235@nanopsycho.orion>
References: <20200109010818.1326575-1-jacob.e.keller@intel.com>
 <20200109010818.1326575-4-jacob.e.keller@intel.com>
 <20200109070502.GC2235@nanopsycho.orion>
Message-ID: <aace193a-066b-ef8d-72a0-7489ba989d87@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/8/2020 11:05 PM, Jiri Pirko wrote:
> Thu, Jan 09, 2020 at 02:08:18AM CET, jacob.e.keller at intel.com wrote:
>> At region creation time, drivers may optionally define
>> a trigger_snapshot function callback. If not defined, the
>> DEVLINK_CMD_REGION_TRIGGER_SNAPSHOT will simply report EOPNOTSUPP.
> 
> Similar mechanism is already implemented for health reporters. Why that
> wouln't work for you?
> 

Mostly, I didn't feel that the necessary information (flash contents)
really made sense as a health report. The intent is to enable diagnostic
tools to read the contents of the flash on a device.

I'm fine using the health interface but in this case features like
recovery method, etc do not make sense at all as it would not be
triggered in response to error conditions.

Thanks,
Jake
