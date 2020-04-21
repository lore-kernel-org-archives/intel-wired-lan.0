From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 21 Apr 2020 12:50:12 +0800
Subject: [Intel-wired-lan] [PATCH 1/1] e1000e: Disable s0ix flow for X1
 Carbon 7th
In-Reply-To: <DM6PR11MB2890E32FBCE91DF33D252087BCD40@DM6PR11MB2890.namprd11.prod.outlook.com>
References: <20200319052629.7282-1-kai.heng.feng@canonical.com>
 <DM6PR11MB2890E32FBCE91DF33D252087BCD40@DM6PR11MB2890.namprd11.prod.outlook.com>
Message-ID: <B58AFDD4-7153-40A0-88E0-5490EF2919A2@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

> On Apr 21, 2020, at 04:27, Brown, Aaron F <aaron.f.brown@intel.com> wrote:
> 
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Kai-
>> Heng Feng
>> Sent: Wednesday, March 18, 2020 10:26 PM
>> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
>> Cc: open list:NETWORKING DRIVERS <netdev@vger.kernel.org>; Kai-Heng Feng
>> <kai.heng.feng@canonical.com>; moderated list:INTEL ETHERNET DRIVERS
>> <intel-wired-lan@lists.osuosl.org>; David S. Miller <davem@davemloft.net>;
>> open list <linux-kernel@vger.kernel.org>
>> Subject: [Intel-wired-lan] [PATCH 1/1] e1000e: Disable s0ix flow for X1 Carbon
>> 7th
>> 
>> The s0ix flow makes X1 Carbon 7th can only run S2Idle for only once.
>> 
>> Temporarily disable it until Intel found a solution.
>> 
>> Link: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-
>> 20200316/019222.html
>> BugLink: https://bugs.launchpad.net/bugs/1865570
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++++++++++++++--
>> 1 file changed, 14 insertions(+), 2 deletions(-)
> 
> I do not have access to the "X1 Carbon 7th" this patch targets, but from a regression perspective against a number of other e1000e based parts:

This patch can be superseded by "e1000e: bump up timeout to wait when ME un-configure ULP mode". 
So it's better to drop this patch in favor of a more generic solution.

Kai-Heng

> Tested-by: Aaron Brown <aaron.f.brown@intel.com>

