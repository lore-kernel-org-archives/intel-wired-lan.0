From: Tom Herbert <tom@herbertland.com>
Date: Mon, 18 Jul 2016 18:34:52 +0200
Subject: [Intel-wired-lan] [RFC PATCH 00/30] Kernel NET policy
In-Reply-To: <37D7C6CF3E00A74B8858931C1DB2F07712C1968E@SHSMSX103.ccr.corp.intel.com>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
 <20160718151841.GA19066@breakpoint.cc>
 <37D7C6CF3E00A74B8858931C1DB2F07712C1968E@SHSMSX103.ccr.corp.intel.com>
Message-ID: <CALx6S36vLAEN-ezqm7EHwwGE876troCkDkkQKhsmeTc4VH0E9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jul 18, 2016 at 5:51 PM, Liang, Kan <kan.liang@intel.com> wrote:
>
>
>> >
>> > It is a big challenge to get good network performance. First, the
>> > network performance is not good with default system settings. Second,
>> > it is too difficult to do automatic tuning for all possible workloads,
>> > since workloads have different requirements. Some workloads may want
>> high throughput.
>>
>> Seems you did lots of tests to find optimal settings for a given base policy.
>>
> Yes. Current test only base on Intel i40e driver. The optimal settings should
> vary for other devices. But adding settings for new device is not hard.
>
The optimal settings are very dependent on system architecture (NUMA
config, #cpus, memory, etc.) and sometimes kernel version as well. A
database that provides best configurations across different devices,
architectures, and kernel version might be interesting; but beware
that that is a whole bunch of work to maintain, Either way policy like
this really should be handled in userspace.

Tom
