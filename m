From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 25 Mar 2020 17:42:33 +0800
Subject: [Intel-wired-lan] [PATCH v3 1/2] igb: Use device_lock() insead
 of rtnl_lock()
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B97224361@ORSMSX103.amr.corp.intel.com>
References: <20200207101005.4454-1-kai.heng.feng@canonical.com>
 <309B89C4C689E141A5FF6A0C5FB2118B971F9210@ORSMSX103.amr.corp.intel.com>
 <3CA021B0-FEB8-4DAA-9CF2-224F305A8C8A@canonical.com>
 <309B89C4C689E141A5FF6A0C5FB2118B97224361@ORSMSX103.amr.corp.intel.com>
Message-ID: <4A655203-7609-434C-9225-269A39AD5B35@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Aaron,

> On Mar 20, 2020, at 15:00, Brown, Aaron F <aaron.f.brown@intel.com> wrote:
> 
>> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> Sent: Monday, February 24, 2020 3:02 AM
>> To: Brown, Aaron F <aaron.f.brown@intel.com>
>> Cc: davem at davemloft.net; mkubecek at suse.cz; Kirsher, Jeffrey T
>> <jeffrey.t.kirsher@intel.com>; open list:NETWORKING DRIVERS
>> <netdev@vger.kernel.org>; moderated list:INTEL ETHERNET DRIVERS <intel-
>> wired-lan at lists.osuosl.org>; open list <linux-kernel@vger.kernel.org>
>> Subject: Re: [Intel-wired-lan] [PATCH v3 1/2] igb: Use device_lock() insead of
>> rtnl_lock()
>> 
>> 
>> 
>>> On Feb 22, 2020, at 08:30, Brown, Aaron F <aaron.f.brown@intel.com> wrote:
>>> 
>>> 
>>> 
>>>> -----Original Message-----
>>>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>>>> Kai-Heng Feng
>>>> Sent: Friday, February 7, 2020 2:10 AM
>>>> To: davem at davemloft.net; mkubecek at suse.cz; Kirsher, Jeffrey T
>>>> <jeffrey.t.kirsher@intel.com>
>>>> Cc: open list:NETWORKING DRIVERS <netdev@vger.kernel.org>; Kai-Heng
>>>> Feng <kai.heng.feng@canonical.com>; moderated list:INTEL ETHERNET
>>>> DRIVERS <intel-wired-lan@lists.osuosl.org>; open list <linux-
>>>> kernel at vger.kernel.org>
>>>> Subject: [Intel-wired-lan] [PATCH v3 1/2] igb: Use device_lock() insead of
>>>> rtnl_lock()
>>>> 
>>>> Commit 9474933caf21 ("igb: close/suspend race in netif_device_detach")
>>>> fixed race condition between close and power management ops by using
>>>> rtnl_lock().
>>>> 
>>>> However we can achieve the same by using device_lock() since all power
>>>> management ops are protected by device_lock().
>>>> 
>>>> This fix is a preparation for next patch, to prevent a dead lock under
>>>> rtnl_lock() when calling runtime resume routine.
>>>> 
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>> v3:
>>>> - Fix unreleased lock reported by 0-day test bot.
>>>> v2:
>>>> - No change.
>>>> 
>>>> drivers/net/ethernet/intel/igb/igb_main.c | 14 ++++++++------
>>>> 1 file changed, 8 insertions(+), 6 deletions(-)
>>> 
>>> This patch introduces the following call trace / RIP when I sleep / resume (via
>> rtcwake) a system that has an igb port with link up:  I'm not sure if it introduces
>> the issue or just exposes / displays it as it only shows up on the first sleep /
>> resume cycle and the systems I have that were stable for many sleep / resume
>> cycles (arbitrarily 50+) continue to be so.
>> 
>> I can't reproduce the issue here.
>> 
> 
> I just got back to looking at the igb driver and  found a similar call trace / RIP with this patch.  Turns out any of my igb systems will freeze if the igb driver is unloaded while the interface is logically up with link.  The system continues to run if I switch to another console, but any attempt to look at the network (ifconfig, ethtool, etc...) makes that other session freeze up.  Then about 5 minutes later a trace appears on the screen and continues to do so every few minutes.  Here's what I pulled out of the system log for this instance:

Yes I can reproduce the bug by removing the module while link is up.
I am currently finding a fix for this issue.

Kai-Heng

